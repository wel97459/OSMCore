# Plan: User Avatars and Dynamic AppBar Status

## Phase 1: State Management and Utilities
- [x] Task: Update `ChatProvider` with new properties (`isGroupChat`, `connectionPath`, `currentHandle`) bb3b421
- [ ] Task: Create Utility for deterministic color generation from strings
- [ ] Task: Create Utility for emoji detection in strings
- [ ] Task: Write Tests for new Utilities
- [ ] Task: Implement new Utilities
- [ ] Task: Conductor - User Manual Verification 'Phase 1: State Management and Utilities' (Protocol in workflow.md)

## Phase 2: User Avatar Widget
- [ ] Task: Write Widget Tests for `UserAvatar` (Verify emoji vs initial, background color consistency)
- [ ] Task: Implement `UserAvatar` widget
- [ ] Task: Conductor - User Manual Verification 'Phase 2: User Avatar Widget' (Protocol in workflow.md)

## Phase 3: Message List and Bubble Updates
- [ ] Task: Write Widget Tests for `MessageBubble` updates (Group chat avatar visibility)
- [ ] Task: Update `MessageBubble` to optionally display `UserAvatar` for received messages
- [ ] Task: Update `MessageList` to pass necessary information to `MessageBubble`
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Message List and Bubble Updates' (Protocol in workflow.md)

## Phase 4: Dynamic AppBar
- [ ] Task: Write Widget Tests for `ChatScreen` AppBar (Direct vs Group mode visuals)
- [ ] Task: Implement dynamic AppBar in `ChatScreen`
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Dynamic AppBar' (Protocol in workflow.md)
