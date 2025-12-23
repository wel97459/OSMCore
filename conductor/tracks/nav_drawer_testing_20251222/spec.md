# Specification: Navigation Drawer for Chat Testing

## Overview
Implement a Navigation Drawer on the left side of the application to allow testers to switch between different chat scenarios. Each scenario will navigate to a new page with its own specific configuration and message state.

## Functional Requirements

### 1. Navigation Drawer
- **Location:** Accessible via a standard hamburger menu icon in the AppBar on the left.
- **Content:** A list of navigation items corresponding to the test scenarios.
- **Items:**
    - **Group Chat:** Navigates to a chat configured as a group channel.
    - **Direct Chat (Direct):** Navigates to a direct chat with "Path: Direct".
    - **Direct Chat (Flood):** Navigates to a direct chat with "Path: Flood".
    - **Direct Chat (3 Hops):** Navigates to a direct chat with "Path: 3 Hops".

### 2. Scenario Pages
- Each drawer item uses `Navigator.pushReplacement` to navigate to a `ChatScreen`.
- Each navigation action must initialize the `ChatProvider` with the correct metadata (`isGroupChat`, `connectionPath`, `currentHandle`) for that scenario.
- **State Separation:** Each scenario should maintain its own independent list of messages (for the duration of the app session).

### 3. UI Consistency
- Ensure the AppBar dynamically updates based on the selected scenario (as implemented in the previous track).
- The Drawer should be available on all scenario pages.

## Non-Functional Requirements
- **Simplicity:** The navigation should be intuitive for testing purposes.
- **Extensibility:** Easy to add new test scenarios to the drawer in the future.

## Acceptance Criteria
- [ ] A navigation drawer is added to the `ChatScreen`.
- [ ] The drawer contains at least four items: "Group Chat", "Direct Chat (Direct)", "Direct Chat (Flood)", and "Direct Chat (3 Hops)".
- [ ] Selecting an item navigates to the corresponding chat scenario.
- [ ] Each scenario displays the correct AppBar metadata and avatar configuration.
- [ ] Messages sent/received in one scenario do not appear in the others.

## Out of Scope
- Persistent storage of messages (messages are cleared on app restart).
- User authentication.
