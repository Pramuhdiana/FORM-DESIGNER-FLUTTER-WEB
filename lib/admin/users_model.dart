class UsersModel {
  int? id;
  String? email;
  String? password;
  int? level;
  String? nama;
  int? status; //? 1 active
  String? divisi;
  int? role;
  String? listMenu;
  String? notif;
  String? token;

  UsersModel(
      {this.id,
      this.email,
      this.password,
      this.level,
      this.nama,
      this.status,
      this.divisi,
      this.role,
      this.listMenu,
      this.notif,
      this.token});

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    level = json['level'];
    nama = json['nama'];
    status = json['status'];
    divisi = json['divisi'];
    role = json['role'];
    listMenu = json['listMenu'] ?? '';
    notif = json['notif'] ?? 'off';
    token = json['token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['level'] = level;
    data['nama'] = nama;
    data['status'] = status;
    data['divisi'] = divisi;
    data['role'] = role;
    data['listMenu'] = listMenu;
    data['notif'] = notif;
    data['token'] = token;
    return data;
  }
}
