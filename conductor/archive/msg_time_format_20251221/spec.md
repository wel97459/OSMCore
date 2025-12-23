# Specification: Message Timestamp Format Update

## Overview
This track involves updating the timestamp display format in the chat bubbles to include both the date (day and month) and the time.

## Functional Requirements
- **Format:** Update message timestamps to use the format `d MMM HH:mm` (e.g., "21 Dec 14:30").
- **Consistency:** The new format must be applied consistently to all message bubbles, including those sent by the current user and those received from others.
- **Always Visible:** The full date and time must be displayed for all messages, regardless of when they were sent.

## Non-Functional Requirements
- **Code Style:** Use the `intl` package or a simple custom formatter to handle the date string generation.
- **Maintainability:** Ensure the formatting logic is reusable or easily adjustable if the format needs to change again.

## Acceptance Criteria
- [ ] All message bubbles show the date and time in `d MMM HH:mm` format.
- [ ] The "Simulate Receive" button results in a message with the new timestamp format.
- [ ] Manual sending of a message results in the new timestamp format.
