import 'package:sibcode/features/domain/entities/news_entitiy.dart';

class NewsModel extends NewsEntity {
  const NewsModel({
    required super.id,
    required super.name,
    required super.image,
    required super.date,
    required super.description,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      date: json['date'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['date'] = date;
    data['description'] = description;
    return data;
  }
}
