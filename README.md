# Eventify
## Introduction

Eventify is a powerful, user-friendly Flutter-based mobile application designed to help you effortlessly manage and organize your events. Whether it's for personal, professional, or social purposes, Eventify provides an intuitive platform to create, view, and manage events in a seamless calendar format. With its clean UI, robust features, and local data storage powered by Hive, Eventify ensures that your event management experience is both efficient and enjoyable.

## Features
- Event Creation & Management: Easily create, update, and delete events with customizable fields including name, description, category, and file attachments.

- Calendar View: Visualize your events in a comprehensive calendar format, making it easy to navigate through different dates and spot special events at a glance.

- Event Search: Quickly locate specific events using the powerful search functionality, helping you find exactly what you need with ease.

- Color-Coded Events: Assign colors to events to visually distinguish them on specific days, making it simple to identify important dates at a glance.

- Category-Based Viewing: Organize your events into categories and view all events within a specific category, streamlining your event management.

- Event Updates: Modify existing events with ease, ensuring that your schedule is always up-to-date.

- Event Deletion: Remove events that are no longer needed, keeping your calendar clean and relevant.

- New Category Creation: Expand your event organization by adding new categories to suit your specific needs.

- Local Data Storage with Hive: All your events and categories are stored locally on your device using Hive, ensuring data privacy and accessibility even without an internet connection.

- State Management with GetX: The app uses GetX for efficient state management, providing a smooth and responsive user experience across all features.
## Architecture
The app is built using the Model-View-Controller (MVC) architecture. This design pattern separates concerns by dividing the application into three main components: the Model, View, and Controller, leading to a more modular and maintainable codebase. The app's architecture is further enhanced by GetX, a state management library that simplifies reactive programming, dependency injection, and state transitions, ensuring a smooth and efficient user experience.

## Dependencies
- GetX: State management and dependency injection.
- Hive: Lightweight and fast key-value database for local data storage.
- Hive Flutter: Integration of Hive with Flutter for easy use.
- Hive Generator: Code generator for Hive TypeAdapters.
- Build Runner: A build system for Dart code generation.
- Flutter ScreenUtil: Responsive screen size and font adaptation for Flutter applications.
- Google Fonts: Access to the Google Fonts library for customizable typography.
- Table Calendar: Highly customizable, feature-rich Flutter calendar widget.
- intl: Internationalization and formatting of dates.
- Status Alert: Customizable alerts and status notifications.
- Flutter Secure Storage: Secure storage of key-value pairs on Android and iOS.
- File Picker: A package for picking files from the device's file system.
- Lottie: A library for adding high-quality animations to your Flutter app.

For a complete list of dependencies, check the pubspec.yaml file.
