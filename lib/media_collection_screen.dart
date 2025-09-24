import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'thankyou_screen.dart';

class MediaCollectionScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String bugDescription;

  const MediaCollectionScreen({
    super.key,
    required this.userData,
    required this.bugDescription,
  });

  @override
  State<MediaCollectionScreen> createState() => _MediaCollectionScreenState();
}

class _MediaCollectionScreenState extends State<MediaCollectionScreen> {
  final List<XFile> mediaFiles = [];

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        mediaFiles.add(pickedFile);
      });
    }
  }

  Future<void> _submitReport() async {
    final usersBox = Hive.box('users');

    // Convert images to bytes for storage
    List<Uint8List> mediaBytes = [];
    for (var f in mediaFiles) {
      Uint8List bytes;
      if (kIsWeb) {
        bytes = await f.readAsBytes();
      } else {
        bytes = await File(f.path).readAsBytes();
      }
      mediaBytes.add(bytes);
    }

    final finalData = {
      ...widget.userData,
      "bug": widget.bugDescription,
      "media": mediaBytes, // store as bytes
    };

    await usersBox.add(finalData);
    print(" Bug report saved: $finalData");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ThankYouScreen()),
    );
  }

  Widget _buildImagePreview(XFile file) {
    if (kIsWeb) {
      return Image.network(file.path, height: 100, fit: BoxFit.cover);
    } else {
      return Image.file(File(file.path), height: 100, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attach Media")),
      body: Column(
        children: [
          ElevatedButton(onPressed: pickImage, child: const Text("Pick Image")),
          Expanded(
            child: mediaFiles.isEmpty
                ? const Center(child: Text("No media selected"))
                : ListView.builder(
                    itemCount: mediaFiles.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildImagePreview(mediaFiles[index]),
                    ),
                  ),
          ),
          ElevatedButton(onPressed: _submitReport, child: const Text("Submit")),
        ],
      ),
    );
  }
}
