import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/core/network/remote/dio_helper.dart';
import 'package:news_app/core/network/remote/network_connection_info.dart';
import 'package:news_app/features/news/data/data_source/remote_data_source.dart';
import 'package:news_app/features/news/data/reposatory_impl/news_reposatory_implementation.dart';
import 'package:news_app/features/news/domain/reposatory/news_reposatory.dart';
import 'package:news_app/features/news/domain/use_cases/get_articles_by_category_and_country_usecase.dart';
import 'package:news_app/features/news/domain/use_cases/search_use_case.dart';
import 'package:news_app/features/news/presentation/controllers/news_get_cubit/news_get_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_search_cubit/news_search_cubit.dart';

final getIt = GetIt.instance;
class ServiceLocator {
  
  void init(){

    //CUBITS
    getIt.registerFactory(() => GetNewsCubit(getNewsByCategoryAndCountyUseCase: getIt(), ));
    getIt.registerFactory(() => NewsSearchCubit(searchUseCase: getIt(),));
    
    
    //USECASES
    getIt.registerLazySingleton(() => GetNewsByCategoryAndCountyUseCase(newsReposatory: getIt()));
    getIt.registerLazySingleton(() => SearchUseCase(newsReposatory: getIt()));
    
    
    //REPOSITORY
    getIt.registerLazySingleton<NewsReposatory>(() => NewsReposatoryImpl( 
      remoteDataSource: getIt(),
      networkConnectionInfo: getIt(),
     ) );
    

    //DATA SOURCE
    getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(dioHelper:getIt()));

    //HELPERS
    getIt.registerLazySingleton<DioHelper>(() => DioHelperImpl());

    //NETWORK INFO
    getIt.registerLazySingleton<NetworkConnectionInfo>(() => NetworkConnectionInfoImple(internetConnectionChecker: getIt()));

    //CONNECTION CHECKER
    getIt.registerLazySingleton(() => InternetConnectionChecker());
  }

}

