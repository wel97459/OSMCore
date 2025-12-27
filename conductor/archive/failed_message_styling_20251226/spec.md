# Specification: Failed Message Styling and Retry Logic

## Overview
This track introduces a distinct visual style for messages that fail to send and adds a functional "retry" mechanism. This improves user feedback and recovery options for failed communication attempts.

## Functional Requirements
- **Visual Feedback:**
    - When `ChatMessage.status` is `MessageStatus.failed`:
        - The message bubble background color MUST change to a prominent red (e.g., `theme.colorScheme.error`).
        - The message text color MUST change to white (e.g., `theme.colorScheme.onError`).
        - The status line (timestamp and icon) MUST be styled to remain visible on the red background.
- **Retry Interaction:**
    - Tapping a failed message bubble or its status icon MUST trigger a "retry" action.
    - The retry action SHOULD update the message status back to `pending` or `sent` (for simulation purposes).

## Non-Functional Requirements
- **Accessibility:** Ensure high contrast between the red background and white text.
- **Consistency:** Use Material 3 error colors from the theme where possible.

## Acceptance Criteria
- Failed messages are visually distinct from sent and received messages.
- The red bubble styling applies correctly to the sender's bubble when the status is failed.
- Tapping a failed message successfully triggers a status change (simulated retry).
- All existing message features (long-press for copy/delete) remain functional for failed messages.

## Out of Scope
- Implementing actual network retry logic (this is a UI/UX template, so retry will be simulated).
- Changes to the "Received" message styling.
