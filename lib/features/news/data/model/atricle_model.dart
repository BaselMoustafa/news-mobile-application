 import 'package:news_app/core/network/remote/api_constants.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';

class ArticleModel extends Article{
  ArticleModel({
    required super.sourceName, 
    required super.title, 
    required super.description, 
    super.image,
    required super.url, 
    required super.date,
    });

  factory ArticleModel.fromJson(Map<String,dynamic> json){
    String myDate="";
    for(int i =0  ; i < 10 ; i++){
      myDate+=json[ApiConstants.publishedAtWord][i];
    }
    return ArticleModel(
      sourceName: json[ApiConstants.sourceWord][ApiConstants.nameWord], 
      title: json[ApiConstants.titleWord], 
      description: json[ApiConstants.descriptionWord], 
      image: json[ApiConstants.urlToImageWord], 
      url: json[ApiConstants.urlWord], 
      date: myDate,
      );

  }

}