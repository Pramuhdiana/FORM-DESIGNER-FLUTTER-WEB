// ignore_for_file: non_constant_idRoundentifier_names, unnecessary_this

class UkuranRoundModel {
  final int idRound;
  final String ukuranRound;

  UkuranRoundModel({
    required this.idRound,
    required this.ukuranRound,
  });

  factory UkuranRoundModel.fromJson(Map<String, dynamic> json) {
    return UkuranRoundModel(
      idRound: json["idRound"],
      ukuranRound: json["ukuranRound"] ?? 'null',
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
