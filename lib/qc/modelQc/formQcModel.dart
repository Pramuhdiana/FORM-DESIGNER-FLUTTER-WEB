
// ignore_for_file: file_names

class QcModel {
  final int id;
  String? noQc;

  QcModel({
    required this.id,
    required this.noQc,
  });

  factory QcModel.fromJson(Map<String, dynamic> json) {
    return QcModel(
      id: json["id"] ?? 0,
      noQc: json["noQc"] ?? '',
    );
  }
}
