class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? image;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      image: json['image'],
    );
  }

  String? get imageUrl {
    if (image == null) return null;
    return 'http://192.168.1.13:8000/storage/$image';
  }
}
