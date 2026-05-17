# Mindful Mood Tracker 🌈

A beautiful, intuitive, and responsive Flutter web application designed to help users track their daily emotional journey with ease.

[Live Demo](https://mindful-mood-tracker.vercel.app) | [GitHub Repository](https://github.com/theayazsoomro/mood_tracker) | [Flutter CI/CD](https://github.com/theayazsoomro/mood_tracker/actions)

## ✨ Features

- **Interactive Mood Selection**: Express how you feel using custom-animated mood cards.
- **Visual Journey Timeline**: View your latest 7 mood entries in a clean, scrollable timeline.
- **Custom Graphics**: Unique mood faces rendered using high-performance CustomPainters.
- **Responsive Design**: Optimized for mobile, tablet, and desktop browsers.
- **Accessibility**: Semantic labels and screen-reader support integrated throughout.

## 🛠️ Technologies Used

- **Framework**: [Flutter](https://flutter.dev) (Web & Mobile)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Styling**: Material 3 Design System
- **Animations**: Flutter Animation Controller & TweenSequences
- **Formatting**: `intl` for localized date handling

## 🧠 Technical Highlights

### State Management (Provider)
The app uses the **Provider** pattern to maintain a single source of truth for the user's mood history. The `MoodProvider` handles:
- Business logic for adding new entries.
- Enforcing data limits (keeping only the last 7 entries).
- Notifying UI components of state changes efficiently.

### Custom Graphics (CustomPainter)
To provide a unique and lightweight visual experience, the mood faces are not images but **CustomPainters**. 
- **Efficient Rendering**: Faces are drawn mathematically on the canvas, ensuring zero pixelation at any scale.
- **Dynamic Styling**: Eye shapes, mouth curves, and brow angles change programmatically based on the selected `MoodType`.

## 🚀 Deployment Instructions

### Prerequisites
- Flutter SDK (Channel Stable)
- Chrome or any modern web browser

### Build for Web
```bash
# Enable web support (if not already enabled)
flutter config --enable-web

# Get dependencies
flutter pub get

# Build the release version
flutter build web --release --base-href "/"
```

### Local Testing
```bash
flutter run -d chrome
```

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

---
*Built with ❤️ by Mohammad Ayaz*
