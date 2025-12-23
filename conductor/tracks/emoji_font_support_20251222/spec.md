# Specification: Better Emoji Font Support

## Overview
Improve the rendering of emojis within the chat template to ensure they appear in full color and are consistent across all platforms, particularly addressing the issue where they may render in black and white on Linux. This will be achieved by bundling the "Noto Color Emoji" font as an asset.

## Functional Requirements
- **Font Bundling:** Download and bundle the "Noto Color Emoji" font (.ttf) as a project asset.
- **Theme Configuration:** Update the application's global theme in `lib/main.dart` to include "Noto Color Emoji" as a fallback font family.
- **Universal Rendering:** Ensure emojis in message bubbles and the input field render using the bundled color font regardless of the host operating system.

## Non-Functional Requirements
- **Visual Consistency:** Emojis should look the same on Linux, Android, iOS, and Web.
- **Performance:** Adding a font should not noticeably impact text rendering performance.

## Acceptance Criteria
- [ ] The "Noto Color Emoji" font file is present in the `assets/fonts/` directory.
- [ ] The `pubspec.yaml` file correctly references the font.
- [ ] When running the app on Linux (or any platform), emojis in messages and the input field render in color.
- [ ] No regression in the rendering of standard alphanumeric text.

## Out of Scope
- Implementing a custom emoji picker UI.
- Supporting animated emojis.
