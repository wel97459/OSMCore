# Plan: Navigation Drawer for Chat Testing

## Phase 1: Multi-Session State Support [checkpoint: 91adf90]
- [x] Task: Update `ChatProvider` to support multiple independent chat sessions (Conversations) 5bc2417
- [x] Task: Write Unit Tests for multi-session support in `ChatProvider` (Verify isolation) 5bc2417
- [x] Task: Implement multi-session logic in `ChatProvider` 5bc2417
- [x] Task: Conductor - User Manual Verification 'Phase 1: Multi-Session State Support' (Protocol in workflow.md) 91adf90

## Phase 2: App Drawer Widget
- [ ] Task: Create `AppDrawer` widget in `lib/widgets/app_drawer.dart`
- [ ] Task: Write Widget Tests for `AppDrawer` (Verify scenario items and tap handlers)
- [ ] Task: Implement `AppDrawer` UI according to Material Design 3
- [ ] Task: Conductor - User Manual Verification 'Phase 2: App Drawer Widget' (Protocol in workflow.md)

## Phase 3: Integrated Navigation and Initialization
- [ ] Task: Integrate `AppDrawer` into `ChatScreen`
- [ ] Task: Implement navigation logic to switch active conversation session
- [ ] Task: Update `ChatScreen` to pull data from the active session in `ChatProvider`
- [ ] Task: Write Widget Tests for end-to-end navigation and state isolation
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Integrated Navigation and Initialization' (Protocol in workflow.md)
