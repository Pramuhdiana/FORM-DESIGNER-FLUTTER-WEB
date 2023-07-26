// ignore_for_file: non_constant_identifier_names, unnecessary_this

class UserModel {
  final int id;
  final String name;
  final int? role;
  final String? alamat;
  final String? phone;
  final String? user_id;
  final String? type_customer;
  final String? diskon_customer;
  final int? customer_brand;

  UserModel({
    required this.id,
    required this.name,
    this.role,
    this.alamat,
    this.phone,
    this.user_id,
    this.type_customer,
    this.diskon_customer,
    this.customer_brand,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"] ?? 'null',
      role: json["role"],
      alamat: json["alamat"],
      phone: json["phone"],
      user_id: json["user_id"],
      type_customer: json["type_customer"] ?? '999',
      diskon_customer: json["diskon_customer"] ?? '999',
      customer_brand: json["customer_brand"] ?? 999,
    );
  }

  static List<UserModel> fromJsonList(List list) {
    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => name;
  String toId() => id.toString();
}
