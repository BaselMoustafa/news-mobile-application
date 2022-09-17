import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/remote/api_constants.dart';
import 'package:news_app/core/network/remote/dio_helper.dart';
import 'package:news_app/core/service_locator/service_locator.dart';
import 'package:news_app/core/style/mode_cubit/mode_scbit.dart';
import 'package:news_app/core/style/mode_cubit/mode_states.dart';
import 'package:news_app/core/style/themeManager.dart';
import 'package:news_app/features/news/presentation/controllers/news_get_cubit/news_get_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_search_cubit/news_search_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_cubit.dart';
import 'package:news_app/features/news/presentation/screens/home_screen/home_screen.dart';
import 'package:news_app/features/news/presentation/screens/onBoarding_screen/onBoarding_screen.dart';

import 'core/network/shared_preferencies/cache_helper.dart';
import 'core/network/shared_preferencies/cahceConstants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  DioHelperImpl.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => NewsViewCubit()..changeTheCurrentCategory(0))),
        BlocProvider(create: ((context) =>getIt<GetNewsCubit>()..getArticles(
          country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), 
          category: ApiConstants.generalCategory,
        ))),
        BlocProvider(create: ((context) => getIt<NewsSearchCubit>()),),
        BlocProvider(create: ((context) => ModeCubit()),),
      ],   
      child: BlocBuilder<ModeCubit,ModeCubitStates>(
        builder: ((context, state) {
          return MaterialApp(
            home: _getTheCorrectStartPage(),
            theme: ThemeManager.getTheLightTheme(),
            darkTheme: ThemeManager.getTheDarkTheme(),
            themeMode: _getTheCorrectTheme(context),
            debugShowCheckedModeBanner: false,
          );
        }),
      ),
    );
  }

  ThemeMode _getTheCorrectTheme(context){
    if(CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.isLightWord)==null){
      CacheHelper.setDataAtSharedPrefrence(Key: CacheConstants.isLightWord, value: true);
      ModeCubit.get(context).setTheMode(isLight: true);
      return ThemeMode.light;
    }
    else{
      if(CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.isLightWord))
      {
        return ThemeMode.light;
      }else{
        return ThemeMode.dark;
      }
    }
    
  }

  Widget _getTheCorrectStartPage(){
    if(CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi)==null)
    {
      return OnBoardingScreen();
    }else{
      return HomeScreen();
    }

}
}