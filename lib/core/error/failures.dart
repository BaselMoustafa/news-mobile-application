import 'package:equatable/equatable.dart';

class Failure extends Equatable{
  final String message;
  Failure({required this.message});
  
 
  List<Object?> get props => [message];
  
}

class OfflineFailure extends Failure{
  OfflineFailure({required super.message});
  
}

class ServerFailure extends Failure{
  ServerFailure({required super.message});
}

class AddArticleFailure extends Failure{
  AddArticleFailure({required super.message});
}

class DeleteArticleFailure extends Failure{
  DeleteArticleFailure({required super.message});
}

class EmptyDataBaseFailure extends Failure{
  EmptyDataBaseFailure({required super.message});
}