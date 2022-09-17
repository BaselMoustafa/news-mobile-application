import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failure_messages.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/core/network/remote/network_connection_info.dart';
import 'package:news_app/features/news/data/data_source/remote_data_source.dart';
import 'package:news_app/features/news/domain/reposatory/news_reposatory.dart';
import 'package:news_app/features/news/domain/use_cases/quries_model.dart';

import '../../domain/entity/article_entity.dart';

class NewsReposatoryImpl extends NewsReposatory{
  RemoteDataSource remoteDataSource;
  NetworkConnectionInfo networkConnectionInfo;
  NewsReposatoryImpl({required this.remoteDataSource , required this.networkConnectionInfo});
  Future<Either<Failure ,List<Article>>> SearchForNews(QueriesModel queries)async{
    return await _fixedInstructions(
      callFromGet: false,
      queries: queries,
      );
  }
  
  Future<Either<Failure ,List<Article>>> getNewsByCategoryAndCounty({required String country , required String category})async{
    return await _fixedInstructions(
      callFromGet: true,
      country: country,
      category: category,
    );
  }
  Future<Either<Failure ,List<Article>>> _fixedInstructions({
    required bool callFromGet,
    QueriesModel? queries,
    String? country , 
    String? category,
  })async{
    if(await networkConnectionInfo.isConnected){
      try{
        if(callFromGet){
          QueriesModel queriesModel=QueriesModel();
          List<Article> articles=await remoteDataSource.getData(
            queries:queriesModel.toMapForGetNews(category: category!, country: country!) 
            );
          return Right(
            articles,
          );
        }else{
          List<Article> articles=await remoteDataSource.getData(queries: queries!.toMapForSearch());
          return Right(
            articles,
          );
        }
      } on ServerException catch(err){
        return Left(
          ServerFailure(
            message: err.errorApiModel.message,
          ),
        );
      }
    }else{
      return Left(
        OfflineFailure(
          message: FailureMessages.offlineFailureMessage,
        ),
      );
    }
  }
  List<Object?> get props => [remoteDataSource,networkConnectionInfo];
}