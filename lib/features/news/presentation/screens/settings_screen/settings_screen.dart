import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/remote/api_constants.dart';
import 'package:news_app/core/network/shared_preferencies/cache_helper.dart';
import 'package:news_app/core/network/shared_preferencies/cahceConstants.dart';
import 'package:news_app/core/style/color_manager.dart';
import 'package:news_app/core/style/mode_cubit/mode_scbit.dart';
import 'package:news_app/features/news/presentation/controllers/news_get_cubit/news_get_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_states.dart';


class SettingsScreen extends StatefulWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool checkBoxIsTaped=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorManager.primaryColor),
          onPressed: ()async{
            NewsViewCubit _view=NewsViewCubit.get(context);
            Navigator.pop(context);
            await CacheHelper.setDataAtSharedPrefrence(
              Key: CacheConstants.countryToApi, 
              value: _view.convertCountryNameFromFilterTobBeSitableForApi(
                _view.selectedCountry,
                ),
              );
            await GetNewsCubit.get(context).getArticles(
              country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), 
              category: NewsViewCubit.get(context).convertCategoryNameFromFilterTobBeSitableForApi(
                NewsViewCubit.get(context).currentCatrgoty
              )!,
              );
            
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text("Dark mode",style: Theme.of(context).textTheme.displayLarge,),
                Spacer(),
                Switch(
                  value: ! ModeCubit.get(context).isLight, 
                  onChanged:(bool isactivated){
                    ModeCubit.get(context).toggleTheMode();
                  },
                  activeColor: ColorManager.primaryColor,
                  inactiveTrackColor: Colors.grey.withOpacity(0.4),
                  inactiveThumbColor: ColorManager.primaryColor,
                  
                  ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Country",style: Theme.of(context).textTheme.displayLarge,),
                Spacer(),
                BlocBuilder<NewsViewCubit,NewsViewCubitStates>(
                  builder: (context,state){
                    return DropdownButton(
                      
                      dropdownColor: ColorManager.primaryColor,
                      value:CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToBeAtSettings) ,
                      items: NewsViewCubit.get(context).namesOfCountries
                      .map((element) => DropdownMenuItem(
                        value: element,
                        child: Text(
                        element,
                        style: Theme.of(context).textTheme.displayLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ))).toList(),
                      onChanged: (item){
                        NewsViewCubit.get(context).changeSelectedCountry(item as String);

                      }
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}