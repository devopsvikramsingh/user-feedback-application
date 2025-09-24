import 'package:flutter/material.dart';
import 'user_detail_screen.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UserDetailsScreen()),
      );
    });

    return const Scaffold(
      body: Center(
        child: Text(
          "Thank you! Your feedback has been submitted.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          selectionColor: Colors.lightBlue,
        ),
      ),
    );
  }
}
