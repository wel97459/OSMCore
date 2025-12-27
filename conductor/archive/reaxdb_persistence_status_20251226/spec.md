# Specification: ReaxDB Persistence and Stateful Message Status

## Overview
This track introduces `reaxdb_dart` for local persistence of chat sessions and messages. It also refactors the message sending logic to be stateful and hook-driven, ensuring messages transition through their status lifecycle (`sending` -> `attemptX` -> `delivered/failed`) while being persisted.

## Functional Requirements
- **Persistence (ReaxDB):**
    - Integrate `reaxdb_dart` to persist `Conversation` and `ChatMessage` data.
    - Implement a strict schema for these entities.
    - Synchronize Riverpod state (`ChatSession`) with the ReaxDB database.
- **Message Lifecycle:**
    - New messages originate in a `sending` state.
    - A mechanism (hook or service) automatically progresses the message status through `attempt1`, `attempt2`, etc., eventually reaching `delivered` or `failed`.
    - Allow external logic to easily update message status (e.g., for simulation or future network integration).
- **UI Updates:**
    - The UI must reactively update to show the current status of the message as it changes in the database/state.

## Non-Functional Requirements
- **Hybrid Architecture:** Maintain the responsiveness of the current Riverpod-based UI while using ReaxDB for long-term storage.
- **Strict Schema:** Enforce data consistency using ReaxDB's schema capabilities.

## Acceptance Criteria
- `reaxdb_dart` is added as a dependency and initialized.
- Chat sessions and messages persist across app restarts.
- Sending a message triggers a visible status progression (sending -> attempt -> delivered).
- Status updates are reflected in both the UI and the database.
- External triggers can successfully update a message's status.

## Out of Scope
- Real network transmission (the "sending" process simulates this).
- Complex conflict resolution for concurrent database writes.
