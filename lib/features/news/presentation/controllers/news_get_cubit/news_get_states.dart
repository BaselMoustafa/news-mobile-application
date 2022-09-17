import 'package:news_app/features/news/domain/entity/article_entity.dart';

abstract class GetNewsStates {}

class GetNewsInitialState extends GetNewsStates{}

class GetNewsSuccessState extends GetNewsStates{
  List<Article> generalNews;
  List<Article> businessNews;
  List<Article> healthNews;
  List<Article> intertamentNews;
  List<Article> scienceNews;
  List<Article> sportsNews;
  List<Article> technologyNews;

  GetNewsSuccessState({
    this.generalNews=const[],
    this.businessNews=const[],
    this.healthNews=const[],
    this.intertamentNews=const[],
    this.scienceNews=const[],
    this.sportsNews=const[],
    this.technologyNews=const[],

  });
  
  GetNewsSuccessState copyWith({
    List<Article>? generalNews ,
    List<Article>? businessNews,
    List<Article>? healthNews,
    List<Article>? intertamentNews,
    List<Article>? scienceNews,
    List<Article>? sportsNews,
    List<Article>? technologyNews,
  }){
    return GetNewsSuccessState(
      generalNews :generalNews??this.generalNews,
      businessNews:businessNews??this.businessNews,
      healthNews:healthNews??this.healthNews,
      intertamentNews:intertamentNews??this.intertamentNews,
      scienceNews:scienceNews??this.scienceNews,
      sportsNews:sportsNews??this.sportsNews,
      technologyNews:technologyNews??this.technologyNews,
    );
  }

}

class GetNewsFailedState extends GetNewsStates{
  final String message ;
  GetNewsFailedState({required this.message});
}
class GetNewsLoadingState extends GetNewsStates{}
