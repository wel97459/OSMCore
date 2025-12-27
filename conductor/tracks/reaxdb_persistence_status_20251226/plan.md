# Plan: ReaxDB Persistence and Stateful Message Status

## Phase 1: ReaxDB Setup and Schema Definition [checkpoint: 627e543]
- [x] Task: Add `reaxdb_dart` to `pubspec.yaml` d6c96d9
- [x] Task: Create ReaxDB schema definitions for `Conversation` and `ChatMessage` 46300
- [x] Task: Implement a database service/provider to initialize and expose the ReaxDB instance 46300
- [x] Task: Write Unit Tests for ReaxDB schema and initialization 46766
- [x] Task: Conductor - User Manual Verification 'Phase 1: ReaxDB Setup and Schema Definition' (Protocol in workflow.md) 627e543

## Phase 2: Hybrid Synchronization (Riverpod <-> ReaxDB)
- [ ] Task: Update `ChatSession` to load initial state from ReaxDB
- [ ] Task: Update `ChatSession` to write changes (add message, update status) to ReaxDB
- [ ] Task: Create a subscription to listen for external database changes and update Riverpod state
- [ ] Task: Write Integration Tests verifying state persistence across "restarts" (re-initializing provider)
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Hybrid Synchronization (Riverpod <-> ReaxDB)' (Protocol in workflow.md)

## Phase 3: Stateful Message Lifecycle
- [ ] Task: Create a `useMessageSender` hook (or similar logic) to handle automatic status progression
- [ ] Task: Integrate the sending logic into `ChatScreen` or `ChatSession`
- [ ] Task: Ensure status updates are persisted to ReaxDB
- [ ] Task: Write Widget Tests for the message lifecycle (verify status transitions)
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Stateful Message Lifecycle' (Protocol in workflow.md)
