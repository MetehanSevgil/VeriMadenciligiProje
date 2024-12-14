import 'package:flutter/material.dart';

import 'model.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
class Page1Init extends StatefulWidget {
  const Page1Init({super.key});

  @override
  State<Page1Init> createState() => _Page1InitState();
}

class _Page1InitState extends State<Page1Init> {
  final ImageProcessor _imageProcessor = ImageProcessor();
  Uint8List? _selectedImage;
  String _result = "";

  @override
  void initState() {
    super.initState();
    _imageProcessor.loadModel();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final imageData = await image.readAsBytes();
      setState(() {
        _selectedImage = imageData;
      });
      _runModel(imageData);
    }
  }

  Future<void> _runModel(Uint8List imageData) async {
    try {
      final result = await _imageProcessor.runModel(imageData);
      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = "Model çalıştırılamadı: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veri Madenciliği Proje'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          if (_selectedImage != null)
      Image.memory(
      _selectedImage!,
      width: 200,
      height: 200,
    )
          else
            const Text('Henüz bir resim seçilmedi'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Resim Yükle'),
            ),
            const SizedBox(height: 20),
            Text('Sonuç: $_result'),
          ],
      ),
    );
  }
}

