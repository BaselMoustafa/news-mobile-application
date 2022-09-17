import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/domain/reposatory/news_reposatory.dart';
import 'package:news_app/features/news/domain/use_cases/quries_model.dart';

class SearchUseCase extends Equatable{
  NewsReposatory newsReposatory;

  SearchUseCase({required this.newsReposatory});

  Future<Either<Failure , List<Article>>> excute(QueriesModel queriesModel)=>
    newsReposatory.SearchForNews(queriesModel);
    
    List<Object?> get props => [newsReposatory];


}