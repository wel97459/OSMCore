# Specification: Core Chat Interface

## Overview
This track focuses on building the foundational components of the Flutter chat template. It includes the data model, state management, and the primary UI elements for displaying and sending messages.

## Requirements
- **Message Model:** `ChatMessage` with `text`, `senderId`, `timestamp`, and `status`.
- **State Management:** `ChatProvider` using the `provider` package to manage a list of `ChatMessage` objects in memory.
- **UI Components:**
    - `ChatScreen`: Main scaffold for the chat.
    - `MessageList`: `ListView.builder` for efficient message display.
    - `MessageBubble`: Styled bubbles with sender/receiver distinction (Material 3).
    - `ChatInput`: Text field with "Send" button.
- **Interactions:**
    - Auto-scroll to bottom on new message.
    - Input clearing on send.
    - Timestamps and status indicators on bubbles.

## Technical Constraints
- Flutter Stable.
- Provider for state management.
- Material 3 Design.
