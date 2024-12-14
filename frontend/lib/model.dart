import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class ImageProcessor {
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
          'assets/models/model.tflite',
          options: InterpreterOptions()
      );
      print('Model successfully loaded.');

      // Print input and output tensor shapes for verification
      print('Input Shape: ${_interpreter?.getInputTensor(0).shape}');
      print('Output Shape: ${_interpreter?.getOutputTensor(0).shape}');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  // Manual reshaping method
  List reshapeList(List input, List<int> shape) {
    if (shape.isEmpty) return input;

    dynamic reshapeRecursive(dynamic input, List<int> remainingShape) {
      if (remainingShape.length == 1) {
        return input;
      }

      int currentDimension = remainingShape[0];
      List<int> nextShape = remainingShape.sublist(1);

      return List.generate(
        currentDimension,
            (i) => reshapeRecursive(input[i], nextShape),
      );
    }

    return reshapeRecursive(input, shape);
  }

  Future<List<dynamic>> runModel(Uint8List imageData) async {
    if (_interpreter == null) {
      throw Exception('Model not loaded. Call loadModel() first.');
    }

    var input = preprocess(imageData);

    // Manually reshape input
    var inputTensor = reshapeList(input, [1, 224, 224, 3]);

    // Create output tensor with the correct shape [1, 68]
    var output = List.generate(1, (_) => List.filled(68, 0.0));

    try {
      _interpreter?.run(inputTensor, output);

      // Process the output to get the top prediction
      List<dynamic> topPrediction = _getTopPrediction(output[0]);
      return topPrediction;
    } catch (e) {
      print('Model run failed: $e');
      rethrow;
    }
  }

  // Function to process and return the top prediction
  List<dynamic> _getTopPrediction(List<double> output) {
    double maxProbability = -1;
    int classIndex = -1;

    // Iterate through the output to find the highest probability
    for (int i = 0; i < output.length; i++) {
      if (output[i] > maxProbability) {
        maxProbability = output[i];
        classIndex = i;
      }
    }

    return [classIndex, maxProbability];
  }

  List<List<List<List<double>>>> preprocess(Uint8List imageData) {
    final img.Image? image = img.decodeImage(imageData);

    if (image == null) {
      throw Exception("Invalid image format");
    }

    // Resize to exactly match model input dimensions
    final img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

    // Create a 4D tensor [1, height, width, channels]
    final input = List.generate(
      1,
          (_) => List.generate(
        224,
            (y) => List.generate(
          224,
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
}