# Specification: Byte-Limited Input (140 Bytes)

## Overview
Implement a strict limit on the input field in the chat window to prevent messages from exceeding 140 bytes. This includes visual feedback for the user to track their remaining byte allowance.

## Functional Requirements
- **Byte Limit Enforcement:** The input field must not allow more than 140 bytes of data (UTF-8 encoding).
- **Hard Truncation:** If a user types or pastes text that exceeds the limit, the input must be truncated at the last character that fits within the 140-byte boundary.
- **Byte Counter:** Display a counter (e.g., "0/140 bytes") below the input field.
- **Real-time Updates:** The counter must update immediately as the user types or deletes text.

## Non-Functional Requirements
- **Efficiency:** Byte count calculation should be efficient to ensure no lag in the UI during typing.
- **Accuracy:** Correctly handle multi-byte characters (like emojis or special symbols) ensuring the total UTF-8 byte count never exceeds 140.

## Acceptance Criteria
- [ ] The user cannot type more than 140 bytes into the message field.
- [ ] Pasting text longer than 140 bytes results in the text being truncated at the 140-byte limit.
- [ ] A counter is visible and accurately reflects the number of bytes used out of 140.
- [ ] The "Send" button remains functional but only for messages within the byte limit.

## Out of Scope
- Changing the character limit (this is strictly a byte limit).
- Server-side validation (this is a UI/frontend template task).
