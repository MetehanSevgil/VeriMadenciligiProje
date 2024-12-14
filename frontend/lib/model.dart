
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:tflite_flutter/tflite_flutter.dart';


// MODELİ ÇEVİRMEK İÇİN KOD
// tflite_convert --saved_model_dir=/path/to/saved_model --output_file=/path/to/output/model.tflite



class ImageProcessor {
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('BOSSSS');
  }

  Future<List<dynamic>> runModel(Uint8List imageData) async {
    var input = preprocess(imageData);

    var output = List.filled(1 * 1, 0.0).reshape([1, 1]);

    _interpreter?.run(input, output);

    return output;
  }


  List<List<List<double>>> preprocess(Uint8List imageData) {
    final img.Image? image = img.decodeImage(imageData);

    if (image == null) {
      throw Exception("Geçersiz görüntü formatı");
    }




    final img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

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
