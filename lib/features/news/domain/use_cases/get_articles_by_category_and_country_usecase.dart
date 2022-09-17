import 'dart:core';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/domain/reposatory/news_reposatory.dart';

class GetNewsByCategoryAndCountyUseCase extends Equatable{
  NewsReposatory newsReposatory;
  GetNewsByCategoryAndCountyUseCase({required this.newsReposatory});
  
  Future<Either<Failure,List<Article>>> excute({required String category , required String country})async{
    return await newsReposatory.getNewsByCategoryAndCounty(country: country, category: category) ;
  }
  List<Object?> get props => [newsReposatory];
}