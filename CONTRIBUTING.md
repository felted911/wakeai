# Contributing to WakeAI

Thank you for your interest in contributing to WakeAI! This document provides guidelines and instructions for contributing to this project.

## Code of Conduct

Please be respectful and considerate of others when contributing to this project. We strive to create a welcoming and inclusive environment for everyone.

## How to Contribute

### Reporting Bugs

If you find a bug in the application, please create an issue with the following information:

- A clear, descriptive title
- Steps to reproduce the bug
- Expected behavior
- Actual behavior
- Screenshots or videos (if applicable)
- Device information (model, OS version, Flutter version)

### Suggesting Features

If you have an idea for a new feature, please create an issue with:

- A clear, descriptive title
- Detailed description of the feature
- Any relevant mockups or examples
- Use cases or benefits of the feature

### Pull Requests

1. Fork the repository
2. Create a branch for your feature or bugfix (`git checkout -b feature/amazing-feature` or `git checkout -b fix/annoying-bug`)
3. Make your changes
4. Run tests and ensure they all pass
5. Commit your changes with clear, descriptive commit messages
6. Push the branch to your fork
7. Open a pull request against the main repository

## Development Guidelines

### Code Style

Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) and use the recommended analyzer settings.

### Architecture

- Maintain the hybrid architecture approach as outlined in the documentation
- Keep the separation of concerns between UI, business logic, and data layers
- Follow the established patterns for state management

### Testing

- Write tests for new features or bug fixes
- Ensure all tests pass before submitting a pull request
- Aim for good test coverage, especially for critical components

### Documentation

- Update documentation when you change code
- Document new features, APIs, or significant changes
- Use clear, concise comments in your code

## Setting Up the Development Environment

1. Install Flutter by following the [official installation guide](https://flutter.dev/docs/get-started/install)
2. Clone the repository
3. Run `flutter pub get` to install dependencies
4. Configure your Azure service keys (see README for instructions)
5. Run the app with `flutter run`

## Questions?

If you have any questions about contributing, please open an issue or contact the project maintainers.

Thank you for helping improve WakeAI!
