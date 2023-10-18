import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String id;
  final String name;
  final String image;
  final String date;
  final String description;

  const NewsEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.date,
    required this.description,
  });


  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    image,
    date,
    description,
  ];
}
