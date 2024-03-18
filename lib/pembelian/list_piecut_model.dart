// ignore_for_file: non_constant_idPieCutentifier_names, unnecessary_this

class ListPieCutModel {
  final int idPieCut;
  final String? nama;
  String? berat;
  String? resultPieCut;

  ListPieCutModel({
    required this.idPieCut,
    required this.nama,
    this.berat,
    this.resultPieCut,
  });

  factory ListPieCutModel.fromJson(Map<String, dynamic> json) {
    return ListPieCutModel(
      idPieCut: json["idPieCut"],
      nama: json["nama"] ?? '',
      berat: (json["berat"] ?? '0').toString(),
      resultPieCut: json["resultPieCut"] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPieCut'] = idPieCut;
    data['nama'] = nama;
    data['berat'] = berat;
    data['resultPieCut'] = resultPieCut;

    return data;
  }
}
