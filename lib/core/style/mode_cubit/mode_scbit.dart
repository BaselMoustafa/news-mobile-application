import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/shared_preferencies/cache_helper.dart';
import 'package:news_app/core/network/shared_preferencies/cahceConstants.dart';
import 'package:news_app/core/style/mode_cubit/mode_states.dart';

class ModeCubit extends Cubit<ModeCubitStates>{
  ModeCubit():super(ModeCubitInitialState());
  
  static ModeCubit get (context)=> BlocProvider.of(context);
  bool isLight=CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.isLightWord)==null?true:CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.isLightWord);

  void toggleTheMode(){
    isLight = !isLight;
    CacheHelper.setDataAtSharedPrefrence(Key:CacheConstants.isLightWord ,value:isLight );
    emit(ModeCubitRefreshState());
  }
  void setTheMode({required bool isLight}){
    isLight=isLight;
    CacheHelper.setDataAtSharedPrefrence(Key:CacheConstants.isLightWord ,value:isLight );
    emit(ModeCubitRefreshState());
  }

}