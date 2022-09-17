import 'package:news_app/features/news/domain/entity/article_entity.dart';

abstract class NewsSearchCubitStates {}

class NewsSearchInitialState extends NewsSearchCubitStates{}

class NewsSearchSuccessState extends NewsSearchCubitStates{
  List<Article> searhResults =[];
  NewsSearchSuccessState({required this.searhResults});
}

class NewsSearchFailedState extends NewsSearchCubitStates{
  final String message;
  NewsSearchFailedState({required this.message});
}

class NewsSearchLoadingState extends NewsSearchCubitStates{}
