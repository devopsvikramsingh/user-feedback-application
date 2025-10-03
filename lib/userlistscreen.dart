import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  Widget _buildMediaPreview(List<dynamic> mediaList) {
    if (mediaList.isEmpty) return const SizedBox();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: mediaList.map((bytes) {
          final Uint8List data = bytes as Uint8List;
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.memory(data, height: 100, fit: BoxFit.cover),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usersBox = Hive.box('users');

    return Scaffold(
      appBar: AppBar(title: const Text("All Reports")),
      body: ValueListenableBuilder(
        valueListenable: usersBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) return const Center(child: Text("No reports yet."));

          final reports = box.values.toList();
          final keys = box.keys.toList();

          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index] as Map;
              final key = keys[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "👤 ${report['name']} (${report['email']})",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black),
                            tooltip: "Delete Feedback",
                            onPressed: () {
                              // Show confirmation dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Delete Feedback"),
                                  content: const Text(
                                    "Are you sure you want to delete this feedback?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        usersBox.delete(key);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Text("📞 ${report['contact']}"),
                      if (report['bug'] != null &&
                          report['bug'].toString().isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text("📝Bug discription : ${report['bug']}"),
                        ),
                      if (report['media'] != null)
                        _buildMediaPreview(report['media']),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
