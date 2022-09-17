
import 'package:news_app/core/error/api_error_model.dart';

class OfflineException implements Exception{}

class ServerException implements Exception{
  final ErrorApiModel errorApiModel;

  ServerException({required this.errorApiModel}); 
}

class AddArticleException implements Exception{}
class DeleteArticleException implements Exception{}
class EmptyDataBaseException implements Exception{}