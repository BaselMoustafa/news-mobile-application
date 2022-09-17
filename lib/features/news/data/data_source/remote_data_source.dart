import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/error/api_error_model.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/network/remote/api_constants.dart';
import 'package:news_app/core/network/remote/dio_helper.dart';
import 'package:news_app/features/news/data/model/atricle_model.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';

abstract class RemoteDataSource extends Equatable{
  Future<List<Article>> getData({required Map<String,dynamic> queries});
  List<Object?> get props => [];
}

class RemoteDataSourceImpl extends RemoteDataSource{
  DioHelper dioHelper;
  RemoteDataSourceImpl({required this.dioHelper});
  Future<List<Article>> getData({required Map<String,dynamic> queries}) async{
    Response response= await dioHelper.getData(
      endPoint:ApiConstants.endPoint, 
      queries: queries,
      );
    if(response.statusCode==200){
      List<Article> articels=[];
      response.data[ApiConstants.articlesWord].forEach(
        (element){
          articels.add(ArticleModel.fromJson(element as Map<String,dynamic>));
        }
      );
      return articels;
    }else{
      ErrorApiModel errorResponse=ErrorApiModel.fromJson(response.data);
      throw ServerException(errorApiModel: errorResponse);
    }
   } 
}