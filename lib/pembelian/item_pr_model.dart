// ignore_for_file: file_names

class ItemPrModel {
  int? id;
  String? item;
  String? kodeItem;

  ItemPrModel({this.id, this.item, this.kodeItem});

  ItemPrModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    kodeItem = json['kodeItem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item'] = item;
    data['kodeItem'] = kodeItem;
    return data;
  }
}
