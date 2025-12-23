# Specification: Message Options Bottom Drawer

## Overview
This track involves implementing a long-press interaction on message bubbles that opens a bottom drawer (bottom sheet) providing options to delete the message or copy its text to the clipboard.

## Functional Requirements
- **Trigger:** Long-press (press and hold) on any `MessageBubble` in the chat.
- **Drawer Component:** Use `showModalBottomSheet` (Material 3).
- **Drawer Layout:**
    - **Header:** Display a visual copy of the selected `MessageBubble` at the top of the drawer for context.
    - **Options List:** A vertical list of options using `ListTile` widgets.
- **Options:**
    - **Delete Message:**
        - **Label:** "Delete message"
        - **Icon:** `Icons.delete_outline`
        - **Action:** Remove the message from the `ChatProvider`'s in-memory list and close the drawer.
    - **Copy Text:**
        - **Label:** "Copy text"
        - **Icon:** `Icons.copy`
        - **Action:** Copy the `ChatMessage` text content to the system clipboard using `Clipboard.setData` and close the drawer.
- **Visual Feedback:** Provide a subtle vibration or snackbar confirmation when a message is copied (optional but recommended for UX).

## Non-Functional Requirements
- **Smooth Animation:** The bottom sheet should transition smoothly.
- **Context Awareness:** The drawer should show the message being acted upon clearly.

## Acceptance Criteria
- [ ] Long-pressing a sent message bubble opens the drawer.
- [ ] Long-pressing a received message bubble opens the drawer.
- [ ] Tapping "Delete message" removes the message from the list.
- [ ] Tapping "Copy text" copies the message content to the clipboard.
- [ ] The drawer closes automatically after an option is selected.
