# Initial Concept

i want to make a basic chat window template using flutter

## Target Users
- UI/UX designers needing a functional prototype for chat interactions.

## Primary Goal
- To serve as a simple, bare-bones starting point for developers to add their own logic.

## Core Features
- Message list with distinct styles for sender and receiver bubbles.
- Text input field with a 140-byte limit, real-time counter, and a "Send" button that clears on submission.
- Scroll-to-bottom behavior when new messages are added or when the keyboard appears.
- Timestamps and detailed message status display (Sent, Delivered, Read) below sent bubbles.
- Simulation button to trigger mock incoming messages for UI/UX testing.
- Interactive message options (long-press) to copy text or delete messages.
- Universal emoji support with consistent color rendering across all platforms.
- Dynamic user/channel avatars for received messages in group chats.
- Context-aware AppBar with connection path status for direct chats and channel status for group chats.
- Integrated Navigation Drawer for switching between pre-configured chat scenarios (Group, Direct Flood, etc.).
- Per-conversation draft preservation when switching between chat scenarios.
- Distinct visual styling for failed messages (red bubble, white text) with tap-to-retry functionality.
- Local persistence using ReaxDB for all chat sessions, messages, and drafts.
- Stateful, simulated message sending lifecycle with visual status progression.

## Visual Style
- Material Design 3 (standard Flutter look).
