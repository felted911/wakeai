# WakeAI - Morning Routine Assistant

## Overview

WakeAI is an AI-powered morning routine assistant that helps users wake up and complete personalized morning routines through voice guidance. The app serves as a "guardian angel" for your mornings, making the start of your day smoother and more productive.

## Features

- Smart alarm system that initiates personalized morning routines
- Voice-activated AI assistant (Peri) that guides users through predefined activities
- Progress tracking over time (weeks, months)
- Personalized interaction styles based on user preferences and responses
- Hybrid approach combining template-based responses with Azure AI for optimal performance

## Technology Stack

- **Framework**: Flutter
- **Language**: Dart
- **AI Backend**: Azure AI services
- **Speech Recognition**: Azure Speech Services
- **Text-to-Speech**: Azure Speech Services
- **Local Storage**: Hive, SharedPreferences

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (included with Flutter)
- Android Studio or VS Code with Flutter extensions
- Azure account for AI services

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/wakeai.git
cd wakeai
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure your Azure service keys in the appropriate configuration files

4. Run the app
```bash
flutter run
```

## Architecture

WakeAI uses a hybrid approach to optimize for both performance and cost:

- Template-based + API Hybrid for AI conversation
- Pre-Generated + On-Demand Hybrid for Text-to-Speech (TTS)
- Pattern Recognition + API Hybrid for Speech-to-Text (STT)
- Middle-Layer NLP Processing for common interactions
- Intelligent Data Management for optimizing storage and usage

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [OpenAI](https://openai.com/) for GPT models that helped in development
- [Azure](https://azure.microsoft.com/) for AI and speech services
- [Flutter team](https://flutter.dev/) for the amazing framework
