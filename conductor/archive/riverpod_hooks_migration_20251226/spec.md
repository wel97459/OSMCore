# Specification: Migration to Riverpod and Flutter Hooks

## Overview
This track involves a full migration of the application's state management from `Provider` to `Riverpod` (using code generation) and `flutter_hooks`. The goal is to modernize the state management architecture, reduce UI boilerplate, and ensure better testability and type safety.

## Functional Requirements
- **Global State (Riverpod):**
    - Replace `ChatProvider` with a Riverpod `Notifier` using `@riverpod` annotations.
    - Implement multi-session/conversation logic within the Riverpod state.
    - Expose methods for sending messages, clearing history, and switching sessions.
- **Local State & UI (Flutter Hooks):**
    - Refactor `ChatScreen`, `ChatInput`, and other stateful widgets to `HookConsumerWidget`.
    - Use hooks (e.g., `useTextEditingController`, `useScrollController`) to manage local UI state, replacing manual `initState` and `dispose` logic.
- **Dependency Injection:** Use Riverpod to provide all necessary services and state to the widget tree.

## Non-Functional Requirements
- **Type Safety:** Use Riverpod's code generation (`build_runner`) to ensure compile-time safety for all providers.
- **Testability:** Maintain >80% code coverage. All tests must be migrated to use `ProviderScope` for widget tests and `ProviderContainer` for unit tests.
- **Code Quality:** Adhere to the project's TDD workflow and Material 3 design principles.

## Acceptance Criteria
- `Provider` package is completely removed from `pubspec.yaml`.
- All `ChangeNotifierProvider` and `Consumer` widgets are replaced with Riverpod equivalents.
- `ChatScreen` and `ChatInput` no longer use `StatefulWidget` or manual controller management.
- All existing features (messaging, session switching, scroll behavior) work as before.
- The test suite passes fully with updated Riverpod testing patterns.

## Out of Scope
- Visual redesign or changes to the Material 3 aesthetic.
- Introduction of persistent storage (database).
