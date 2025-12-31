import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_text/claude_api_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  File? _selectedImage;
  String? _imageDescription;
  bool _isLoading = false;

  OcrSpaceService ocrSpaceService = OcrSpaceService();
  Future<XFile?> pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(
      source: imageSource,
      maxWidth: 1280,
      maxHeight: 1280,
      imageQuality: 85,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Optical Character Recognition'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 60, // Removed invalid property for Column
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        222,
                        221,
                        222,
                      ).withValues(alpha: 0.25),
                      border: Border.all(
                        color: const Color.fromARGB(255, 211, 211, 211),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: _selectedImage == null
                          ? const Text(
                              'Select an Image',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                height: 250,
                                width: double.infinity,
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final image = await pickImage(ImageSource.camera);
                          if (image != null) {
                            setState(() {
                              _isLoading = true;
                              _selectedImage = File(image.path);
                              _imageDescription = null;
                            });
                            try {
                              if (_selectedImage != null) {
                                _imageDescription = await ocrSpaceService
                                    .extractTextFromImage(_selectedImage!);
                              }
                            } catch (e) {
                              _imageDescription = 'Error: ${e.toString()}';
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 55),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 4),
                              Icon(Icons.camera_alt, size: 24),
                              const Text(
                                'From Camera',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 55),
                        ),
                        onPressed: () async {
                          final image = await pickImage(ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              _isLoading = true;
                              _selectedImage = File(image.path);
                              _imageDescription = null;
                            });
                            try {
                              if (_selectedImage != null) {
                                _imageDescription = await ocrSpaceService
                                    .extractTextFromImage(_selectedImage!);
                              }
                            } catch (e) {
                              _imageDescription = 'Error: ${e.toString()}';
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },











                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 4),
                              Icon(Icons.photo_library, size: 24),
                              const Text(
                                'From Gallery',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),















                      ),
                    ],
                  ),

                  if (_isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: CircularProgressIndicator(),
                    ),

                  if (!_isLoading &&
                      _selectedImage != null &&
                      _imageDescription != null)
                    Text(
                      _imageDescription!,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
