import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/core/network/remote/api_constants.dart';
import 'package:news_app/core/network/shared_preferencies/cache_helper.dart';
import 'package:news_app/core/network/shared_preferencies/cahceConstants.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/domain/use_cases/get_articles_by_category_and_country_usecase.dart';
import 'package:news_app/features/news/presentation/controllers/news_get_cubit/news_get_states.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_cubit.dart';

class GetNewsCubit extends Cubit<GetNewsStates>{
   GetNewsByCategoryAndCountyUseCase getNewsByCategoryAndCountyUseCase;
  
  static GetNewsCubit get(context)=>BlocProvider.of(context);

  GetNewsCubit({
    required this.getNewsByCategoryAndCountyUseCase,
  }):super(GetNewsInitialState());

  GetNewsSuccessState _getNewsSuccessState=GetNewsSuccessState();

  Future<void> getArticles({required String country , required String category})async{
    emit(GetNewsLoadingState());

    Either<Failure,List<Article>> articlesOrFailure = await getNewsByCategoryAndCountyUseCase.excute(
      category: category, country: country
      );
    articlesOrFailure.fold(
      (failure) {
        emit(GetNewsFailedState(
          message: failure.message,
        ));
      }, 
      (articles) {
        if(category==ApiConstants.generalCategory)
          _getNewsSuccessState= _getNewsSuccessState.copyWith(generalNews: articles);
        if(category==ApiConstants.businessCategory)
          _getNewsSuccessState= _getNewsSuccessState.copyWith(businessNews: articles);
        if(category==ApiConstants.entertainmentCategory)
          _getNewsSuccessState= _getNewsSuccessState.copyWith(intertamentNews: articles);
        if(category==ApiConstants.healthCategory)
          _getNewsSuccessState= _getNewsSuccessState.copyWith(healthNews: articles);
        if(category==ApiConstants.scienceCategory)
          _getNewsSuccessState= _getNewsSuccessState.copyWith(scienceNews: articles);
        if(category==ApiConstants.sportsCategory)
          _getNewsSuccessState= _getNewsSuccessState.copyWith(sportsNews: articles);
        if(category==ApiConstants.technologyCategory)
          _getNewsSuccessState= _getNewsSuccessState.copyWith(technologyNews: articles);
          
        emit(_getNewsSuccessState);
      },
    );

  }


  Future<void> ensureTheListIsLoaded(context)async{
    NewsViewCubit _view = NewsViewCubit.get(context);

    if(_view.currentCatrgoty=="General"&&_getNewsSuccessState.generalNews.length==0)
      {await getArticles(country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), category: ApiConstants.generalCategory);}

    else if(_view.currentCatrgoty=="Business"&&_getNewsSuccessState.businessNews.length==0)
      {await getArticles(country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), category: ApiConstants.businessCategory);}


    else if(_view.currentCatrgoty=="Intertament"&&_getNewsSuccessState.intertamentNews.length==0)
      {await getArticles(country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), category: ApiConstants.entertainmentCategory);}

    else if(_view.currentCatrgoty=="Health"&&_getNewsSuccessState.healthNews.length==0)
      {await getArticles(country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), category: ApiConstants.healthCategory);}

    else if(_view.currentCatrgoty=="Science"&&_getNewsSuccessState.scienceNews.length==0)
      {await getArticles(country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), category: ApiConstants.scienceCategory);}

    else if(_view.currentCatrgoty=="Sports"&&_getNewsSuccessState.sportsNews.length==0)
      {await getArticles(country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), category: ApiConstants.sportsCategory);}

    else
      {await getArticles(country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), category: ApiConstants.technologyCategory);}
  }
}


