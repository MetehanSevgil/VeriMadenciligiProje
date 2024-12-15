import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class ImageProcessor {
  Interpreter? _interpreter;
  final List<String> classNames = [
    'acili_ezme',
    'ayran_corbasi',
    'baklava',
    'brokoli',
    'cacik',
    'cigkofte',
    'domates_corbasi',
    'doner',
    'etli_patates',
    'ezogelin_corbasi',
    'fasulye',
    'icecekler',
    'kanat',
    'kazandibi',
    'kofte',
    'kremali_mantar_corbasi',
    'makarna',
    'mantar_sote',
    'mercimek_corbasi',
    'musakka',
    'pilav',
    'salata',
    'su_boregi',
    'sutlac',
    'trilece',
    'tulumba',
    'tursu',
  ];

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
        'assets/models/model.tflite',
        options: InterpreterOptions(),
      );
      print('Model successfully loaded.');

      // Print input and output tensor shapes for verification
      print('Input Shape: ${_interpreter?.getInputTensor(0).shape}');
      print('Output Shape: ${_interpreter?.getOutputTensor(0).shape}');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<Map<String, dynamic>> runModel(Uint8List imageData) async {
    if (_interpreter == null) {
      throw Exception('Model not loaded. Call loadModel() first.');
    }

    var input = preprocess(imageData);

    // Create output tensor with the correct shape [1, number_of_classes]
    var output = List.generate(1, (_) => List.filled(68, 0.0));
    try {
      _interpreter?.run(input, output);

      // Process the output to get the top prediction
      int predictedIndex = _getTopPrediction(output[0]);
      String predictedClass = classNames[predictedIndex];
      double confidence = output[0][predictedIndex];

      return {
        'class': predictedClass,
        'confidence': confidence,
      };
    } catch (e) {
      print('Model run failed: $e');
      rethrow;
    }
  }

  // Helper method to preprocess the image
  List<List<List<List<double>>>> preprocess(Uint8List imageData) {
    final img.Image? image = img.decodeImage(imageData);

    if (image == null) {
      throw Exception("Invalid image format");
    }

    // Resize to exactly match model input dimensions
    final img.Image resizedImage = img.copyResize(image, width: 256, height: 256);

    // Create a 4D tensor [1, height, width, channels]
    final input = List.generate(
      1,
          (_) => List.generate(
        256,
            (y) => List.generate(
          3,
              (x) {
                final pixel = resizedImage.getPixel(x, y);
                final red = pixel.r / 255.0;
                final green = pixel.g / 255.0;
                final blue = pixel.b / 255.0;

            return [red, green, blue];
          },
        ),
      ),
    );

    return input;
  }

  // Helper method to get the index of the highest probability
  int _getTopPrediction(List<double> output) {
    double maxProbability = -1;
    int classIndex = -1;

    for (int i = 0; i < output.length; i++) {
      if (output[i] > maxProbability) {
        maxProbability = output[i];
        classIndex = i;
      }
    }

    return classIndex;
  }
}
