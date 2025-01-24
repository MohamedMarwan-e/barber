class UserModel {
  final int id;
  final String name;
  final String phone;
  final String avatar;
  final String? email;
  final String gender;
  final int cityId;
  final String cityName;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.avatar,
    required this.gender,
    required this.cityId,
    required this.cityName,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'] as String,
      email: json['email'] as String?,
      gender: json['gender'] as String,
      cityId: json['city_id'] as int,
      cityName: json['city_name'] as String,
    );
  }

  static Map<String, dynamic> toJson({
    required String name,
    required int cityId,
    required String gender,
    String? email,
  }) {
    final Map<String, dynamic> data = {
      'name': name,
      'city_id': cityId,
      'gender': gender,
    };

    if (email != null) {
      data['email'] = email;
    }

    return data;
  }
}