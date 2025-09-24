import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'user_detail_screen.dart';

class GoogleLoginScreen extends StatefulWidget {
  @override
  _GoogleLoginScreenState createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  User? _user; // Stores the logged-in user
  bool _isSigningIn = false; // Loading indicator

  /// Sign in with Google (Web-compatible)
  Future<void> signInWithGoogle() async {
    setState(() => _isSigningIn = true);

    try {
      UserCredential userCredential;

      if (kIsWeb) {
        // For Web: use Firebase Auth popup
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await FirebaseAuth.instance.signInWithPopup(
          googleProvider,
        );
      } else {
        // For Mobile: implement google_sign_in flow if needed
        // Currently Web-only
        return;
      }

      // Safety check for null user
      if (userCredential.user == null) {
        setState(() => _isSigningIn = false);
        return;
      }

      setState(() {
        _user = userCredential.user;
        _isSigningIn = false;
      });

      // Navigate to user details screen after login
      if (_user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => UserDetailsScreen()),
        );
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
      setState(() => _isSigningIn = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-in failed. Please try again.")),
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() => _user = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Sign-In Web"), centerTitle: true),
      body: Center(
        child: _isSigningIn
            ? CircularProgressIndicator()
            : _user == null
            ? _buildSignInButton()
            : _buildUserProfile(),
      ),
    );
  }

  /// Sign-in button UI
  Widget _buildSignInButton() {
    return ElevatedButton.icon(
      //icon: Image.asset('assets/logo.png', height: 24, width: 24),
      label: Text("Sign in "),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onPressed: signInWithGoogle,
    );
  }

  /// User profile UI after login
  Widget _buildUserProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(_user?.photoURL ?? ''),
        ),
        SizedBox(height: 16),
        Text(
          "Hello, ${_user?.displayName ?? 'User'}",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          _user?.email ?? '',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        SizedBox(height: 24),
        ElevatedButton.icon(
          icon: Icon(Icons.logout),
          label: Text("Sign Out"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: signOut,
        ),
      ],
    );
  }
}
