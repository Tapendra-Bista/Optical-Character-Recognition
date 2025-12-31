# Image to Text (Flutter)

A cross-platform Flutter app that extracts text from images using OCR (Optical Character Recognition).
<img width="1530" height="3036" alt="Screenshot_20260101_034247-portrait" src="https://github.com/user-attachments/assets/43f25078-7362-4e00-8043-6c8e374073ff" />
<img width="1530" height="3036" alt="Screenshot_20260101_035028-portrait" src="https://github.com/user-attachments/assets/2a436ab2-f871-4ca9-8bcf-fdbfa791b8ae" />


https://github.com/user-attachments/assets/405c608a-5235-4906-aa9f-228d77edcb08


## Features
- Select images from camera or gallery
- Extract text from images using OCR
- Display extracted text in the app
- Works on Android, iOS, Windows, macOS, Linux, and Web

## Getting Started

### Prerequisites
- Flutter SDK (3.x or newer)
- Dart SDK
- Android Studio or Xcode (for mobile)
- A device or emulator

### Installation
1. Clone the repository:
   ```sh
   git clone <your-repo-url>
   cd image_to_text
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app:
   ```sh
   flutter run
   ```

## Usage
- Tap "From Camera" to capture an image
- Tap "From Gallery" to select an image
- The app will display the extracted text below the image

## Project Structure
- `lib/main.dart`: App entry point
- `lib/main_screen.dart`: Main UI and logic
- `lib/claude_api_service.dart`: OCR service integration
- `android/`, `ios/`, `windows/`, `macos/`, `linux/`, `web/`: Platform-specific code

## Dependencies
- `image_picker`: For selecting images
- `flutter`: Core framework
- (Add your OCR package here)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License.
