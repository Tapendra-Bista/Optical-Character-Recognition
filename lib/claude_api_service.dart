import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class OcrSpaceService {
  final Dio _dio = Dio();

  static const String _apiKey = 'K85123497188957';
  static const String _url = 'https://api.ocr.space/parse/image';

  Future<String> extractTextFromImage(File imageFile) async {
    // Read bytes ONLY (no decoding)
    final bytes = await imageFile.readAsBytes();

    // Safety check (optional but recommended)
    if (bytes.length > 1024 * 1024) {
      return 'Image is too large. Please select a smaller image.';
    }

    final base64Image = 'data:image/jpeg;base64,${base64Encode(bytes)}';

    final formData = FormData.fromMap({
      'apikey': _apiKey,
      'language': 'eng',
      'isOverlayRequired': 'false',
      'base64Image': base64Image,
    });

    try {
      final response = await _dio.post(_url, data: formData);

      final parsedResults = response.data['ParsedResults'];

      if (parsedResults != null && parsedResults.isNotEmpty) {
        final text = parsedResults[0]['ParsedText'] ?? '';
        return text.trim().isEmpty ? 'No text found in the image.' : text;
      }

      return 'No text found in the image.';
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['ErrorMessage'] ?? 'OCR request failed',
      );
    }
  }
}
