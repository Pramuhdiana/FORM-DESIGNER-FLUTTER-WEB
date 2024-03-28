// ignore_for_file: depend_on_referenced_packages

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static var dio = Dio();

  static Future<String> uploadFile(
      List<int> file, String fileName, String id) async {
    FormData formData = FormData.fromMap({
      "imageUrl": MultipartFile.fromBytes(
        file,
        filename: id + fileName,
        contentType: MediaType("image", "png"),
      )
    });
    var response = await dio.post("${ApiConstants.baseUrl}spk/all_image.php",
        data: formData);
    return response.data;
  }

  // static Future<void> uploadFileExcel(List<int> file, String fileName) async {
  //   FormData formData = FormData.fromMap({
  //     "file": MultipartFile.fromBytes(
  //       file,
  //       filename: fileName,
  //     )
  //   });
  //   var response = await dio.post(
  //       "${ApiConstants.baseUrl}${ApiConstants.importExcel}",
  //       data: formData);
  //   return response.data;
  // }

  // Fungsi untuk mengunggah file Excel
  static Future<void> uploadExcel(
      List<int> excelBytes, String fileName, context) async {
    var url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.importExcel}'); // Ganti dengan URL endpoint Anda
    var request = http.MultipartRequest('POST', url);
    request.files.add(
      http.MultipartFile.fromBytes('file', excelBytes,
          filename:
              fileName), // Ganti 'excel_file.xlsx' dengan nama file yang sesuai
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      showCustomDialog(
        context: context,
        dialogType: DialogType.success,
        title: 'SUCCESS',
        description: 'File berhasil diunggah.',
      );
    } else {
      showCustomDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'ERROR code',
          description: '${response.statusCode}',
          dissmiss: false);
    }
  }
}
