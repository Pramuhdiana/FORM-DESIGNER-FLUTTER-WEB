// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:http_parser/http_parser.dart';

class ApiClient {
  static var dio = Dio();

  static Future<String> uploadFile(List<int> file, String fileName) async {
    FormData formData = FormData.fromMap({
      "imageUrl": MultipartFile.fromBytes(
        file,
        filename: fileName,
        contentType: MediaType("image", "png"),
      )
    });
    var response = await dio.post("${ApiConstants.baseUrl}spk/all_image.php",
        data: formData);
    return response.data;
  }

  static Future<String> uploadFileExcel(List<int> file, String fileName) async {
    FormData formData = FormData.fromMap({
      "imageUrl": MultipartFile.fromBytes(
        file,
        filename: fileName,
      )
    });
    var response = await dio.post("${ApiConstants.baseUrl}spk/all_image.php",
        data: formData);
    return response.data;
  }
}
