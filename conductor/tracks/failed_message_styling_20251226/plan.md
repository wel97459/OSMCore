# Plan: Failed Message Styling and Retry Logic

## Phase 1: Model and State Preparation [checkpoint: cb69b38]
- [x] Task: Update `MessageStatus` enum to include `failed` if not already present
- [x] Task: Add `retryMessage(ChatMessage message)` method to `ChatSession` notifier
- [x] Task: Write Unit Tests for `retryMessage` logic in `ChatSession`
- [x] Task: Conductor - User Manual Verification 'Phase 1: Model and State Preparation' (Protocol in workflow.md) cb69b38

## Phase 2: Visual Implementation (Red Bubbles) [checkpoint: 93e253b]
- [x] Task: Update `MessageBubble` to support conditional styling for failed status
- [x] Task: Update `MessageStatusLine` to display error icon and text for failed status
- [x] Task: Write Widget Tests for `MessageBubble` failed state (Verify red background and white text)
- [x] Task: Conductor - User Manual Verification 'Phase 2: Visual Implementation (Red Bubbles)' (Protocol in workflow.md) 93e253b

## Phase 3: Interaction and Retry Functionality
- [ ] Task: Implement tap listener on `MessageBubble` for retry logic
- [ ] Task: Integrate `retryMessage` call when a failed bubble is tapped
- [ ] Task: Write Widget Tests for retry interaction (Verify status change on tap)
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Interaction and Retry Functionality' (Protocol in workflow.md)
