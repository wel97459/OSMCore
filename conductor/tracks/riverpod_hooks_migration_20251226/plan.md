# Plan: Migration to Riverpod and Flutter Hooks

## Phase 1: Dependency and Infrastructure Setup [checkpoint: 7e47d02]
- [x] Task: Add `hooks_riverpod`, `flutter_hooks`, and `riverpod_annotation` to `pubspec.yaml` 3f9e846
- [x] Task: Add `riverpod_generator`, `build_runner`, and `custom_lint` to `dev_dependencies` 3f9e846
- [x] Task: Remove `provider` from `pubspec.yaml` 3f9e846
- [x] Task: Initialize Riverpod `ProviderScope` in `main.dart` 3f9e846
- [x] Task: Conductor - User Manual Verification 'Phase 1: Dependency and Infrastructure Setup' (Protocol in workflow.md) 7e47d02

## Phase 2: Core State Migration (Riverpod) [checkpoint: 5739f57]
- [x] Task: Create new Riverpod-based `ChatNotifier` using `@riverpod` annotations (Refactor from `ChatProvider`) 1fa7886
- [x] Task: Implement multi-session state logic in `ChatNotifier` 1fa7886
- [x] Task: Run `build_runner` to generate providers 1fa7886
- [x] Task: Write Unit Tests for `ChatNotifier` using `ProviderContainer` 1fa7886
- [x] Task: Conductor - User Manual Verification 'Phase 2: Core State Migration (Riverpod)' (Protocol in workflow.md) 5739f57

## Phase 3: Widget Refactoring (Flutter Hooks)
- [x] Task: Refactor `ChatScreen` to `HookConsumerWidget` and use `useScrollController` 6c0ec0b
- [x] Task: Refactor `ChatInput` to `HookConsumerWidget` and use `useTextEditingController` 6c0ec0b
- [x] Task: Refactor `AppDrawer` to `ConsumerWidget` to access Riverpod state 6c0ec0b
- [x] Task: Refactor remaining widgets (`MessageList`, `UserAvatar`, etc.) to use Riverpod for state access 6c0ec0b
- [x] Task: Implement draft storage in `ConversationState` and `ChatSession` 9c09fb7
- [x] Task: Update `ChatInput` to sync with draft state 9c09fb7
- [~] Task: Conductor - User Manual Verification 'Phase 3: Widget Refactoring (Flutter Hooks)' (Protocol in workflow.md)

## Phase 4: Test Suite Migration and Cleanup
- [ ] Task: Update all widget tests to wrap target widgets in `ProviderScope`
- [ ] Task: Update unit tests to use Riverpod `ProviderContainer` patterns
- [ ] Task: Verify overall code coverage is >80%
- [ ] Task: Final project cleanup (remove unused imports, delete old `ChatProvider`)
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Test Suite Migration and Cleanup' (Protocol in workflow.md)
