import 'package:equatable/equatable.dart';
import 'package:news_app/core/network/remote/api_constants.dart';

class ErrorApiModel extends Equatable{
  final String status;
  final String code;
  final String message;

  ErrorApiModel({
    required this.status,
    required this.code,
    required this.message,
  });
  
  factory ErrorApiModel.fromJson(Map<String , dynamic> json){
    return ErrorApiModel(
      status: ApiConstants.statusWord, 
      code: ApiConstants.codeWord, 
      message: ApiConstants.messageWord,
      );
  }

  @override
  List<Object?> get props => [
    status,
    code,
    message,
  ];
}