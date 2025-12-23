# Specification: User Avatars and Dynamic AppBar Status

## Overview
Enhance the chat interface by adding a dynamic user icon (avatar) for received messages and a context-aware AppBar that displays user/channel information and a "path status" or channel type.

## Functional Requirements

### 1. User Avatar Widget
- **Visuals:** A circular avatar containing either the first emoji found in the user's handle or the first letter of the handle if no emoji is present.
- **Background Color:** Deterministically generated based on the handle string (consistent across sessions and platforms).
- **Placement:** Positioned to the left of received message bubbles.
- **Visibility:** Only displayed for received messages and only when the conversation is a group chat (`isGroupChat == true`).

### 2. Contextual AppBar
- **Non-Group Chat Mode:**
    - Displays the user's handle and avatar in the AppBar title area.
    - Displays a status line below the handle indicating the connection path (e.g., "Path: Direct", "Path: Flood", "Path: 3 Hops").
- **Group Chat Mode:**
    - Displays a generic channel avatar using the Font Awesome icon "" (solid lightbulb or similar).
    - Displays the channel name (handle) in the title.
    - Displays the status "Channel Messages" below the channel name.

### 3. State Management
- Add `isGroupChat` (boolean), `connectionPath` (string), and `currentHandle` (string, for the chat partner or channel name) properties to the `ChatProvider`.

## Non-Functional Requirements
- **Consistency:** Color generation from handles must be identical every time for the same handle.
- **Clean UI:** Ensure the transition between group and direct chat layouts is smooth.

## Acceptance Criteria
- [ ] A new `UserAvatar` widget is created.
- [ ] Received messages in group chats show the avatar to the left of the bubble.
- [ ] Received messages in non-group chats do *not* show the avatar next to the bubble.
- [ ] Non-group chats display the user avatar, handle, and "Path: ..." status in the AppBar.
- [ ] Group chats display the channel avatar (Font Awesome icon), channel name, and "Channel Messages" status in the AppBar.

## Out of Scope
- Dynamic path calculation (path is provided via `ChatProvider`).
- Changing avatars for sent messages.
