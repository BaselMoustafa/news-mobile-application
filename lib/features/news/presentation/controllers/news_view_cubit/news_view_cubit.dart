import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/remote/api_constants.dart';
import 'package:news_app/core/network/shared_preferencies/cache_helper.dart';
import 'package:news_app/core/network/shared_preferencies/cahceConstants.dart';
import 'package:news_app/core/style/color_manager.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_states.dart';


class NewsViewCubit extends Cubit<NewsViewCubitStates>{

  static NewsViewCubit get(context)=> BlocProvider.of(context);
  NewsViewCubit():super(NewsViewInitialState());
  int currentIndex=0;

  TextEditingController searchController= TextEditingController();

  List<String>namesOfCat=["General",'Business',"Intertament","Health","Science","Sports","Technology"];
  String currentCatrgoty ="General";

  List<String>namesOfCountries=["Egypt","Saudi Arabia","United States","France","Germany","Morocco","United Arab States"];

  void changeTheCurrentCategory(int index){
    currentIndex=index;
    currentCatrgoty=namesOfCat[currentIndex];
    emit(NewsViewRefreshState());
  }
  
  Color colorOfSearchIconAtTextFormField=ColorManager.grey;

  void changeColorOfSearchIconAtTextFormField(Color color){
    colorOfSearchIconAtTextFormField = color;
    emit(NewsViewRefreshState());
  }

  String? filterCategory=null;
  String?filterCategoryToApi=null;

  void changeFilterCategory(String? categoryName){
    filterCategory=categoryName;
    filterCategoryToApi=convertCategoryNameFromFilterTobBeSitableForApi(categoryName);
    emit(NewsViewRefreshState());
  }

  String? selectedCountry;
  void changeSelectedCountry(String country){
    selectedCountry =country;
    CacheHelper.setDataAtSharedPrefrence(Key:CacheConstants.countryToBeAtSettings ,value:country );
    emit(NewsViewRefreshState());
  }

  String? convertCategoryNameFromFilterTobBeSitableForApi(String? category){
    if(category=="General"){return ApiConstants.generalCategory;}
    else if(category=="Business"){return ApiConstants.businessCategory;}
    else if(category=="Intertament"){return ApiConstants.entertainmentCategory;}
    else if(category=="Health"){return ApiConstants.healthCategory;}
    else if(category=="Science"){return ApiConstants.scienceCategory;}
    else if(category=="Sports"){return ApiConstants.sportsCategory;}
    else if(category=="Technology"){return ApiConstants.technologyCategory;}
    else{return null;}
  } 

  String? filterCountry=null;
  String? filterCountryToApi=null;

  void changeFilterCounrty(String? countryName){
    filterCountry=countryName;
    filterCountryToApi=convertCountryNameFromFilterTobBeSitableForApi(countryName);
    emit(NewsViewRefreshState());
  }

  String? convertCountryNameFromFilterTobBeSitableForApi(String? county){
    if(county=="Egypt"){return ApiConstants.egypt;}
    else if(county=="Saudi Arabia"){return ApiConstants.saudia;}
    else if(county=="United States"){return ApiConstants.america;}
    else if(county=="France"){return ApiConstants.france;}
    else if(county=="Germany"){return ApiConstants.german;}
    else if(county=="Morocco"){return ApiConstants.moracoo;}
    else if(county=="United Arab States"){return ApiConstants.emarat;}
    else{return null;}
  } 
}