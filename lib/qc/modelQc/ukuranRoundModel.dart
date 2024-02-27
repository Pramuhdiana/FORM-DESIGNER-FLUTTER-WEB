// ignore_for_file: file_names, unnecessary_this

class UkuranRoundModel {
  final int idRound;
  final String ukuranRound;
  final String jenisRound;
  final String caratPcs;
  final String kodeMdbc;
  final String lot;

  UkuranRoundModel({
    required this.idRound,
    required this.ukuranRound,
    required this.jenisRound,
    required this.caratPcs,
    required this.kodeMdbc,
    required this.lot,
  });

  factory UkuranRoundModel.fromJson(Map<String, dynamic> json) {
    return UkuranRoundModel(
      idRound: json["idRound"],
      ukuranRound: json["ukuranRound"] ?? 'null',
      jenisRound: json["jenisRound"] ?? 'null',
      caratPcs: json["caratPcs"].toString(),
      kodeMdbc: json["kodeMdbc"] ?? 'null',
      lot: json["lot"] ?? 'null',
    );
  }

  static List<UkuranRoundModel> fromJsonList(List list) {
    return list.map((item) => UkuranRoundModel.fromJson(item)).toList();
  }

  ///this method will prevent the overridRounde of toString
  String userAsString() {
    return '#${this.idRound} ${this.ukuranRound}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(UkuranRoundModel model) {
    return this.idRound == model.idRound;
  }

  @override
  String toString() => ukuranRound;
  String toidRound() => idRound.toString();
}
