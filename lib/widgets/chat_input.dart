import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/byte_counter.dart';
import '../utils/byte_limit_input_formatter.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSend;

  const ChatInput({
    super.key,
    required this.onSend,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _canSend = false;
  int _currentBytes = 0;
  static const int _maxBytes = 140;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _currentBytes = ByteCounter.countBytes(_controller.text);
      _canSend = _controller.text.trim().isNotEmpty && _currentBytes <= _maxBytes;
    });
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && ByteCounter.countBytes(text) <= _maxBytes) {
      widget.onSend(text);
      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (_) => _handleSend(),
                    inputFormatters: [
                      ByteLimitInputFormatter(_maxBytes),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: theme.colorScheme.primary,
                  onPressed: _canSend ? _handleSend : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
