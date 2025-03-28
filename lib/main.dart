import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/login.dart';
import 'auth/register.dart';
import 'exam_service.dart';
import 'notifications.dart';
import 'student/availableexams.dart';
import 'student/completedexams.dart';
import 'student/exam.dart';
import 'student/examanswers.dart';
import 'student/studenthomepage.dart';
import 'teacher/createexam.dart';
import 'teacher/studentsubmission.dart';
import 'teacher/submissions.dart';
import 'teacher/submittedexams.dart';
import 'teacher/teacherhomepage.dart';
import 'teacher/viewExams.dart';
import 'welcomePage.dart';
import 'firebase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: FirebaseConfig.apiKey,
      authDomain: FirebaseConfig.authDomain,
      projectId: FirebaseConfig.projectId,
      storageBucket: FirebaseConfig.storageBucket,
      messagingSenderId: FirebaseConfig.messagingSenderId,
      appId: FirebaseConfig.appId,
      measurementId: FirebaseConfig.measurementId,
    ),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExamService()..startCheckingExams(),
      child: MaterialApp(
        title: 'Online Exam Management System',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 8, 41, 114),
            titleTextStyle: TextStyle(
              color: Colors.white, 
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              fontFamily: 'Patua One',
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        home: const WelcomePage(),
        routes: {
          "studenthomepage": (context) => const StudentHomePage(),
          "teacherhomepage": (context) => const TeacherHomePage(),
          "login": (context) => const Login(),
          "register": (context) => const Register(),
          "welcomePage": (context) => const WelcomePage(),
          "createexam": (context) => const CreateExam(),
          "submittedexams": (context) => const SubmittedExams(),
          "submissions": (context) => const Submissions(),
          "studentsubmission": (context) => const StudentSubmission(),
          "completedexams": (context) => const CompletedExams(),
          "availableexams": (context) => const AvailableExams(),
          "exam": (context) => const Exam(),
          "examanswers": (context) => const ExamAnswers(),
          "notifications": (context) => const Notifications(),
          "viewexams": (context) => const ViewExamsPage(),
        },
      ),
    );
  }
}