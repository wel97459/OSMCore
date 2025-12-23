# Plan: User Avatars and Dynamic AppBar Status

## Phase 1: State Management and Utilities [checkpoint: 56313f3]
- [x] Task: Update `ChatProvider` with new properties (`isGroupChat`, `connectionPath`, `currentHandle`) bb3b421
- [x] Task: Create Utility for deterministic color generation from strings dba2a94
- [x] Task: Create Utility for emoji detection in strings dba2a94
- [x] Task: Write Tests for new Utilities dba2a94
- [x] Task: Implement new Utilities dba2a94
- [x] Task: Conductor - User Manual Verification 'Phase 1: State Management and Utilities' (Protocol in workflow.md) 56313f3

## Phase 2: User Avatar Widget [checkpoint: 391b2ec]
- [x] Task: Write Widget Tests for `UserAvatar` (Verify emoji vs initial, background color consistency) fab2208
- [x] Task: Implement `UserAvatar` widget fab2208
- [x] Task: Conductor - User Manual Verification 'Phase 2: User Avatar Widget' (Protocol in workflow.md) 391b2ec

## Phase 3: Message List and Bubble Updates
- [x] Task: Write Widget Tests for `MessageBubble` updates (Group chat avatar visibility) b3e9483
- [x] Task: Update `MessageBubble` to optionally display `UserAvatar` for received messages b3e9483
- [x] Task: Update `MessageList` to pass necessary information to `MessageBubble` b3e9483
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Message List and Bubble Updates' (Protocol in workflow.md)

## Phase 4: Dynamic AppBar
- [ ] Task: Write Widget Tests for `ChatScreen` AppBar (Direct vs Group mode visuals)
- [ ] Task: Implement dynamic AppBar in `ChatScreen`
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Dynamic AppBar' (Protocol in workflow.md)
