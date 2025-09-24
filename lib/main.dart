import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'googleLoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    if (kIsWeb) {
      // Web requires explicit FirebaseOptions
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyBQYpd7Z8XuUSBXxB-Y1uFyaRI2VksGHvY",
          authDomain: "app-41cc8.firebaseapp.com",
          projectId: "app-41cc8",
          storageBucket: "app-41cc8.firebasestorage.app",
          messagingSenderId: "902573509389",
          appId: "1:902573509389:web:5c5f474437a32c7bc03e44",
          measurementId: "G-P4WTG351GD",
        ),
      );
    } else {
      // Android & iOS use google-services.json / GoogleService-Info.plist
      await Firebase.initializeApp();
    }
  } catch (e) {
    // Handle initialization errors
    debugPrint("Firebase initialization error: $e");
  }

  runApp(const BugReportApp());
}
// create class for bug report app
class BugReportApp extends StatelessWidget {
  const BugReportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bug Report App",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: GoogleLoginScreen(),
    );
  }
}
