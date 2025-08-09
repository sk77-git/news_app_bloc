class NewsModel {
  final String title;
  final String description;

  NewsModel({required this.title, required this.description});

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    title: json['title'] ?? '',
    description: json['description'] ?? '',
  );
}
