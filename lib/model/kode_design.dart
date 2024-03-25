// ignore_for_file: file_names, unnecessary_this

class KodeDesignModel {
  final int id;
  final String kodeDesign;
  final String kodeMarketing;

  KodeDesignModel({
    required this.id,
    required this.kodeDesign,
    required this.kodeMarketing,
  });

  factory KodeDesignModel.fromJson(Map<String, dynamic> json) {
    return KodeDesignModel(
      id: json["id"],
      kodeDesign: json["kodeDesignMdbc"] ?? 'null',
      kodeMarketing: json["kodeMarketing"] ?? 'null',
    );
  }

  static List<KodeDesignModel> fromJsonList(List list) {
    return list.map((item) => KodeDesignModel.fromJson(item)).toList();
  }

  ///this method will prevent the overridRounde of toString
  String userAsString() {
    return '#${this.id} ${this.kodeDesign}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(KodeDesignModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => kodeDesign;
  String toidRound() => id.toString();
}
