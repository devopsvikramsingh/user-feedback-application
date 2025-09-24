import 'package:app_22/media_collection_screen.dart';
import 'package:flutter/material.dart';

class BugDescriptionScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const BugDescriptionScreen({super.key, required this.userData});

  @override
  State<BugDescriptionScreen> createState() => _BugDescriptionScreenState();
}

class _BugDescriptionScreenState extends State<BugDescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final bugCtrl = TextEditingController();

  @override
  void dispose() {
    bugCtrl.dispose();
    super.dispose();
  }

  void goToMediaScreen() {
    if (_formKey.currentState!.validate()) {
      final bugDescription = bugCtrl.text;

      // Navigate to MediaCollectionScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MediaCollectionScreen(
            userData: widget.userData,
            bugDescription: bugDescription,
          ),
        ),
      );

      bugCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback Description"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Reporting for: ${widget.userData['name']}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: bugCtrl,
                decoration: const InputDecoration(
                  labelText: "Feedback Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) =>
                    value!.isEmpty ? "Enter feedback description" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: goToMediaScreen,
                child: const Text("Next "),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
