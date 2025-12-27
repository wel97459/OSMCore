import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_template/providers/chat_notifier.dart';
import '../utils/byte_counter.dart';
import '../utils/byte_limit_input_formatter.dart';

class ChatInput extends HookConsumerWidget {
  final Function(String) onSend;
  final int maxBytes;

  const ChatInput({
    super.key,
    required this.onSend,
    this.maxBytes = 140,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final chatState = ref.watch(chatSessionProvider);
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    
    // State for sendability and byte count
    final currentBytes = useState(0);
    final canSend = useState(false);

    // Sync controller with draft from state when active conversation changes
    useEffect(() {
      if (controller.text != chatState.currentDraft) {
        controller.text = chatState.currentDraft;
        // Move cursor to end
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      }
      return null;
    }, [chatState.activeConversationId]);

    useEffect(() {
      void listener() {
        currentBytes.value = ByteCounter.countBytes(controller.text);
        canSend.value = controller.text.trim().isNotEmpty && currentBytes.value <= maxBytes;
        
        // Update draft in state (debounce or direct? Direct for now as local state is cheap)
        // Check to avoid infinite loop if the state update triggers a rebuild that triggers this
        if (ref.read(chatSessionProvider).currentDraft != controller.text) {
           ref.read(chatSessionProvider.notifier).updateDraft(controller.text);
        }
      }
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    void handleSend() {
      final text = controller.text.trim();
      if (text.isNotEmpty && ByteCounter.countBytes(text) <= maxBytes) {
        onSend(text);
        controller.clear();
        ref.read(chatSessionProvider.notifier).updateDraft(''); // Clear draft
        focusNode.requestFocus();
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (_) => handleSend(),
                    inputFormatters: [
                      ByteLimitInputFormatter(maxBytes),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: theme.colorScheme.primary,
                  onPressed: canSend.value ? handleSend : null,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${currentBytes.value}/$maxBytes bytes',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
