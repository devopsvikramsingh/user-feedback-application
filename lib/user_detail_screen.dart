import 'package:app_22/userlistscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bug_description_screen.dart';
// New screen to view all data

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final contactCtrl = TextEditingController();

  Box? usersBox; // Declare as nullable

  @override
  void initState() {
    super.initState();
    openUsersBox();
  }

  Future<void> openUsersBox() async {
    // Open Hive box asynchronously
    usersBox = await Hive.openBox('users');
    setState(() {}); // Refresh UI after box is ready
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    contactCtrl.dispose();
    super.dispose();
  }

  void saveUser() {
    if (_formKey.currentState!.validate() && usersBox != null) {
      final user = {
        'name': nameCtrl.text,
        'email': emailCtrl.text,
        'contact': contactCtrl.text,
      };

      usersBox!.add(user); // Save user temporarily
      print("All users: ${usersBox!.values.toList()}");

      // Navigate to BugDescriptionScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BugDescriptionScreen(userData: user)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (usersBox == null) {
      // Show loading until box is ready
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => value!.isEmpty ? "Enter name" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Enter email" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: contactCtrl,
                decoration: const InputDecoration(labelText: "Contact"),
                validator: (value) => value!.isEmpty ? "Enter contact" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: saveUser, child: const Text("Next")),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserListScreen()),
                  );
                },
                child: const Text(" view your reviews"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
