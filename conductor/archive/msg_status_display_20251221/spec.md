# Specification: Detailed Message Status Display

## Overview
This track involves adding a detailed status indicator (text and icon) below sent message bubbles to provide clearer feedback on message delivery and read status.

## Functional Requirements
- **Status Display:** Add a status line below sent message bubbles.
- **Content:** The line must include both status text and a corresponding icon (e.g., "Sent ✓", "Delivered ✓✓", "Read ✓✓").
- **Positioning:** The status line should be located outside and below the message bubble, aligned to the right (sender's side).
- **Styling:**
    - **Side-by-side:** Text and icon must be displayed next to each other.
    - **Color:** Use a consistent color (Material 3 on-surface-variant or similar secondary text color) regardless of the status.
- **Status Mapping:**
    - `sent`: "Sent" + single check icon.
    - `delivered`: "Delivered" + double check icon.
    - `read`: "Read" + double check icon.

## Non-Functional Requirements
- **Layout Consistency:** Ensure the status line does not create excessive vertical gaps between messages.
- **Readability:** Use a small but legible font size for the status text.

## Acceptance Criteria
- [ ] Sent messages display "Sent", "Delivered", or "Read" text with appropriate icons below the bubble.
- [ ] The status line is correctly aligned to the right, matching the bubble's alignment.
- [ ] The "Simulate Receive" button (which adds received messages) does NOT show this status line (as it's only for sent messages).
- [ ] The status line remains visible and consistently styled across all three statuses.
