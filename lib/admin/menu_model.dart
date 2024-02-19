class MenuModel {
  int? idMenu;
  String? nama;
  int? isActive;

  MenuModel({this.idMenu, this.nama, this.isActive});

  MenuModel.fromJson(Map<String, dynamic> json) {
    idMenu = json['idMenu'];
    nama = json['nama'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMenu'] = idMenu;
    data['nama'] = nama;
    data['isActive'] = isActive;
    return data;
  }
}
