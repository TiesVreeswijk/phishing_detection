import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/analysis_result.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  static Future<AnalysisResult> analyzeScreenshot(File imageFile) async {
    print('Sending file: ${imageFile.path}');

    final uri = Uri.parse('$baseUrl/api/analyze');

    final request = http.MultipartRequest('POST', uri);
    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Analysis failed (${response.statusCode}): ${response.body}');
    }

    final Map<String, dynamic> jsonMap =
    jsonDecode(response.body) as Map<String, dynamic>;

    return AnalysisResult.fromJson(jsonMap);
  }
}