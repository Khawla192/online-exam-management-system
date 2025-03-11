# Online Exam Management System  

## Screenshots  
![Login Screen](assets/Logo.png)
---

## About the App  
**Online Exam Management System** is a Flutter-based mobile application designed to facilitate online exams for educational institutions. Built with Firebase backend, it provides:  

### Teacher Features:  
- Create exams with multiple question types (MCQ/TrueFalse/Essay/Short Answer)  
- Manage submissions and grade student attempts  
- Real-time exam monitoring  
- Push notifications for exam updates  

### Student Features:  
- Take timed exams with resume functionality  
- View completed exams with answers/feedback  
- Receive result notifications  
- Password recovery system  

---

## Technologies Used  
- **Frontend**: Flutter (Dart)  
- **Backend**:  
  - Firebase Authentication  
  - Cloud Firestore  
  - Firebase Cloud Messaging  
- **State Management**: Provider  
- **Key Packages**:  
  - `firebase_core`: Firebase integration  
  - `awesome_dialog`: Interactive dialogs  
  - `intl`: Date/time formatting  
  - `file_picker` & `image_picker`: File attachments  

---

## Getting Started  

### Prerequisites  
- Flutter SDK 3.0+  
- Firebase account  
- Android Studio/VSCode with Flutter plugins  

### Installation  
1. **Clone Repository**  
   ```bash
   git clone https://github.com/Khawla192/online-exam-management-system.git
   cd online-exam-management-system
   ```
2. **Install Dependencies**  
   ```bash
   flutter pub get
   ```
3. **Firebase Setup**  
   - Create Firebase project  
   - Add Android/iOS apps and download config files:  
     - `google-services.json` → `android/app/`  
     - `GoogleService-Info.plist` → `ios/Runner/`  
4. **Run the App**  
   ```bash
   flutter run
   ```

---

## Project Structure  
```
Online Exam Management System/
├── .dart_tool/
├── .idea/
├── lib/
│   ├── auth/
│   │   └── login.dart
│   ├── student/
│   │   ├── availableexams.dart
│   │   ├── completedexams.dart
│   │   ├── exam.dart
│   │   ├── examanswers.dart
│   │   └── studenthomepage.dart
│   ├── teacher/
│   │   ├── createexam.dart
│   │   ├── studentsubmission.dart
│   │   ├── submissions.dart
│   │   ├── submittedexams.dart
│   │   └── teacherhomepage.dart
│   ├── exam_service.dart
│   ├── main.dart
│   ├── notifications.dart
│   └── welcomePage.dart
├── android/
├── assets/
├── build/
├── fonts/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
├── .flutter-plugins
├── .flutter-plugins-dependencies
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── itcs444_project.iml
├── pubspec.lock
├── pubspec.yaml
└── README.md            
```

---

## Key Features  

### Shared Functionality  
- Role-based authentication (Student/Teacher)  
- Push notifications system  
- Real-time exam scheduling/expiry  
- Fuzzy-search for exams/questions  

### Teacher Specific  
- Rich exam creation with:  
  - Question randomization  
  - File/image attachments  
  - Multiple grading schemes  
- Submission management with:  
  - Manual essay grading  
  - Feedback system  
  - Bulk result publishing  

### Student Specific  
- Timed exam interface with:  
  - Auto-save progress  
  - Question navigation  
  - Type-specific answer inputs  
- Historical attempt review:  
  - Correct answers highlighting  
  - Grade breakdowns  
  - Teacher feedback  

---

## Components Highlights  

### Core Services  
- **ExamService**: Manages exam lifecycle and auto-submissions  
- **NotificationService**: Handles push notifications  
- **AuthService**: Manages user authentication flows  

### Key Screens  
- **Login**: Secure auth with password recovery  
- **CreateExam**: Dynamic form with validation  
- **Exam**: Full-screen timed test interface  
- **StudentSubmission**: Grading interface with rubrics  

---

## Firebase Collections  
- **Exams**: Exam metadata and scheduling  
- **Questions**: Exam content storage  
- **Attempts**: Student exam attempts  
- **Answers**: Student responses  
- **Feedbacks**: Teacher evaluations  
- **Notifications**: System messages  

---

## Future Roadmap  
- Advanced student performance analytics  
- Offline exam support with sync  
- Multi-language support  
- Detailed reporting dashboard  

---

## License  
This project is licensed under the MIT License - see `LICENSE` for details.  

---

## Acknowledgments  
- Flutter community for extensive documentation  
- Firebase team for robust backend services  
- Icons8 for UI assets  
- Provider package for state management  

For questions or support, contact [kvenus192@gmail.com](mailto:kvenus192@gmail.com)

## Next Steps
- Planned future enhancements include:

- Advanced Analytics: Provide detailed performance analytics for students and teachers.

- Offline Mode: Allow students to take exams offline and sync results later.

- Multi-Language Support: Add support for multiple languages.