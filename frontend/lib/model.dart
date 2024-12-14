
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:tflite_flutter/tflite_flutter.dart';


// MODELİ ÇEVİRMEK İÇİN KOD
// tflite_convert --saved_model_dir=/path/to/saved_model --output_file=/path/to/output/model.tflite



class ImageProcessor {
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/models/model.tflite');
      print('Model successfully loaded.');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<List<dynamic>> runModel(Uint8List imageData) async {
    var input = preprocess(imageData);

    // Here, output should be a 1D list to match the model's output
    var output = List.filled(64, 0.0);  // Assuming your model has 64 output classes

    _interpreter?.run(input, output);

    // Process the output to get the top prediction
    List<dynamic> topPrediction = _getTopPrediction(output);
    return topPrediction;
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




  List<List<List<double>>> preprocess(Uint8List imageData) {
    final img.Image? image = img.decodeImage(imageData);

    if (image == null) {
      throw Exception("Geçersiz görüntü formatı");
    }




    final img.Image resizedImage = img.copyResize(image, width: 256, height: 256);

    final input = List.generate(
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
    );

    return input;
  }


}
