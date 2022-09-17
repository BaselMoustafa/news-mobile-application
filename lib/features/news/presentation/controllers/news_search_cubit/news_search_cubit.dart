import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/domain/use_cases/quries_model.dart';
import 'package:news_app/features/news/domain/use_cases/search_use_case.dart';
import 'package:news_app/features/news/presentation/controllers/news_search_cubit/news_search_states.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_cubit.dart';

class NewsSearchCubit extends Cubit<NewsSearchCubitStates>{
  SearchUseCase searchUseCase;

  NewsSearchCubit({
    required this.searchUseCase,
  }):super(NewsSearchInitialState());

  static NewsSearchCubit get(context)=> BlocProvider.of(context);

  Future<void> searchForNews({required QueriesModel queriesModel})async{
    emit(NewsSearchLoadingState());
    Either<Failure,List<Article>> articleOrFailure = await searchUseCase.excute(queriesModel);
    articleOrFailure.fold(
      (failure){
        emit(
          NewsSearchFailedState(message: failure.message),
        );
      } , 
      (articles){
        emit(
          NewsSearchSuccessState(searhResults: articles),
        );
      } ,
    );
  }

  Future<void>search({required bool withFilter,required BuildContext context})async{
    NewsViewCubit _view =NewsViewCubit.get(context);
    if(withFilter){
      String? category =_view.filterCategoryToApi ;
      String? country =_view.filterCountryToApi;
      _view.changeFilterCategory(null);
      _view.changeFilterCounrty(null);
      await searchForNews(queriesModel: QueriesModel(q:_view.searchController.text,country: country,category: category));
    }else{
      await searchForNews(queriesModel: QueriesModel(q: _view.searchController.text));
    }
  }

  void leaveTheSearchScreen(context){
    NewsViewCubit _view =NewsViewCubit.get(context);
    _view.searchController.clear();
    emit(NewsSearchInitialState());
  }
}