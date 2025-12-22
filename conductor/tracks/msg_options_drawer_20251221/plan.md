# Plan: Message Options Bottom Drawer

## Phase 1: Logic & Provider Updates [checkpoint: 5a19edc]
- [x] Task: Add `removeMessage` method to `ChatProvider` to support deletion. [b001928]
- [x] Task: Write unit tests for `ChatProvider.removeMessage`. [b001928]
- [x] Task: Conductor - User Manual Verification 'Phase 1: Logic & Provider Updates' (Protocol in workflow.md) [checkpoint]

## Phase 2: UI Implementation
- [ ] Task: Create `MessageOptionsSheet` widget displaying message preview and options (Delete, Copy).
- [ ] Task: Update `MessageBubble` to wrap in `GestureDetector` and trigger `showModalBottomSheet` on long press.
- [ ] Task: Implement clipboard copy logic in `MessageOptionsSheet`.
- [ ] Task: Implement delete logic in `MessageOptionsSheet` (calling `ChatProvider.removeMessage`).
- [ ] Task: Write widget tests for `MessageOptionsSheet` and long-press interaction.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: UI Implementation' (Protocol in workflow.md)

## Phase 3: Final Verification & UX
- [ ] Task: Add `ScaffoldMessenger` feedback (Snackbar) for the "Copy text" action.
- [ ] Task: Verify drawer behavior for both sent and received messages.
- [ ] Task: Ensure code coverage remains >80%.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Final Verification & UX' (Protocol in workflow.md)
