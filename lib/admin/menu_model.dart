class MenuModel {
  int? idMenu;
  String? menu;
  int? isActive;

  MenuModel({this.idMenu, this.menu, this.isActive});

  MenuModel.fromJson(Map<String, dynamic> json) {
    idMenu = json['idMenu'];
    menu = json['menu'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMenu'] = idMenu;
    data['menu'] = menu;
    data['isActive'] = isActive;
    return data;
  }
}
