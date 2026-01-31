class AboutResponseModel {
  final String title;
  final String description;
  final String? image;

  AboutResponseModel({
    required this.title,
    required this.description,
    this.image,
  });

  factory AboutResponseModel.fromMap(Map<String, dynamic> json) {
    return AboutResponseModel(
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}
