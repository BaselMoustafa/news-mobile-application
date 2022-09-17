import 'package:dio/dio.dart';
import 'package:news_app/core/network/remote/api_constants.dart';

abstract class DioHelper{
  Future<Response> getData({required String endPoint ,  required Map<String,dynamic> queries });
} 

class DioHelperImpl implements DioHelper{
  static late Dio dio;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,       
      ),
    );
  }

  Future<Response> getData({required String endPoint , required Map<String,dynamic> queries })async{
    
    Response response =await dio.get(
      endPoint,
      queryParameters: queries,
    );
    return response;
  }

 
}