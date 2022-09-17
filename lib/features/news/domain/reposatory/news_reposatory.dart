import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/domain/use_cases/quries_model.dart';

abstract class NewsReposatory extends Equatable{
  Future<Either<Failure ,List<Article>>> SearchForNews(QueriesModel queries);
  Future<Either<Failure ,List<Article>>> getNewsByCategoryAndCounty({required String country , required String category});
}