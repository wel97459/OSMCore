# Plan: Migration to Riverpod and Flutter Hooks

## Phase 1: Dependency and Infrastructure Setup [checkpoint: setup_complete]
- [x] Task: Add `hooks_riverpod`, `flutter_hooks`, and `riverpod_annotation` to `pubspec.yaml` 3f9e846
- [x] Task: Add `riverpod_generator`, `build_runner`, and `custom_lint` to `dev_dependencies` 3f9e846
- [x] Task: Remove `provider` from `pubspec.yaml` 3f9e846
- [x] Task: Initialize Riverpod `ProviderScope` in `main.dart` 3f9e846
- [~] Task: Conductor - User Manual Verification 'Phase 1: Dependency and Infrastructure Setup' (Protocol in workflow.md)

## Phase 2: Core State Migration (Riverpod)
- [ ] Task: Create new Riverpod-based `ChatNotifier` using `@riverpod` annotations (Refactor from `ChatProvider`)
- [ ] Task: Implement multi-session state logic in `ChatNotifier`
- [ ] Task: Run `build_runner` to generate providers
- [ ] Task: Write Unit Tests for `ChatNotifier` using `ProviderContainer`
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Core State Migration (Riverpod)' (Protocol in workflow.md)

## Phase 3: Widget Refactoring (Flutter Hooks)
- [ ] Task: Refactor `ChatScreen` to `HookConsumerWidget` and use `useScrollController`
- [ ] Task: Refactor `ChatInput` to `HookConsumerWidget` and use `useTextEditingController`
- [ ] Task: Refactor `AppDrawer` to `ConsumerWidget` to access Riverpod state
- [ ] Task: Refactor remaining widgets (`MessageList`, `UserAvatar`, etc.) to use Riverpod for state access
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Widget Refactoring (Flutter Hooks)' (Protocol in workflow.md)

## Phase 4: Test Suite Migration and Cleanup
- [ ] Task: Update all widget tests to wrap target widgets in `ProviderScope`
- [ ] Task: Update unit tests to use Riverpod `ProviderContainer` patterns
- [ ] Task: Verify overall code coverage is >80%
- [ ] Task: Final project cleanup (remove unused imports, delete old `ChatProvider`)
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Test Suite Migration and Cleanup' (Protocol in workflow.md)
