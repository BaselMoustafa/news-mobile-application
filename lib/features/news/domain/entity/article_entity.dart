import 'package:equatable/equatable.dart';

class Article extends Equatable{ 
  final String sourceName ; 
  final String title ; 
  final String? description ; 
  String? image ; 
  final String url ; 
  final String date ; 

  Article({
    required this.sourceName,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.date,
  });
  
  List<Object?> get props => [
    sourceName, 
    title, 
    description, 
    image, 
    url, 
    date,
  ];
}