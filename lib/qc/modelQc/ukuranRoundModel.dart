
// ignore_for_file: file_names, unnecessary_this

class UkuranRoundModel {
  final int idRound;
  final String ukuranRound;
  final String caratPcs;

  UkuranRoundModel({
    required this.idRound,
    required this.ukuranRound,
    required this.caratPcs,
  });

  factory UkuranRoundModel.fromJson(Map<String, dynamic> json) {
    return UkuranRoundModel(
      idRound: json["idRound"],
      ukuranRound: json["ukuranRound"] ?? 'null',
      caratPcs: json["caratPcs"].toString(),
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
