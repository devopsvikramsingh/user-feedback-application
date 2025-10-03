import 'package:app_22/userlistscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bug_description_screen.dart';

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

  Box? usersBox;

  @override
  void initState() {
    super.initState();
    openUsersBox();
  }

  Future<void> openUsersBox() async {
    usersBox = await Hive.openBox('users');
    setState(() {}); // Refresh after box is ready
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

      usersBox!.add(user);
      print("All users: ${usersBox!.values.toList()}");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BugDescriptionScreen(userData: user)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (usersBox == null) {
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
              // Name field
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => value!.isEmpty ? "Enter name" : null,
              ),
              const SizedBox(height: 10),

              // Email field with validation
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(60), // block after 60 chars
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  }
                  // Email regex check
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email (e.g. example@gmail.com)";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Contact field with 10-digit restriction
              TextFormField(
                controller: contactCtrl,
                decoration: const InputDecoration(labelText: "Contact"),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10), // only 10 digits
                  FilteringTextInputFormatter.digitsOnly, // only numbers
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter contact";
                  } else if (value.length != 10) {
                    return "Contact must be exactly 10 digits";
                  }
                  return null;
                },
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
                child: const Text("View your reviews"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
