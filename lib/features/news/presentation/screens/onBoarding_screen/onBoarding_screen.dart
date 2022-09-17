import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:news_app/core/network/remote/api_constants.dart';
import 'package:news_app/core/network/shared_preferencies/cache_helper.dart';
import 'package:news_app/core/network/shared_preferencies/cahceConstants.dart';
import 'package:news_app/core/style/color_manager.dart';
import 'package:news_app/core/widgets/get_button.dart';
import 'package:news_app/features/news/presentation/controllers/news_get_cubit/news_get_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_cubit.dart';
import 'package:news_app/features/news/presentation/screens/home_screen/home_screen.dart';


class OnBoardingScreen extends StatelessWidget {
  List<String> _pathOfAssets=[
    "assets/egypt.jpg",
    "assets/united_arab_states.jpg",
    "assets/america.jpg",
    "assets/saudi_arabia.jpg",
    "assets/morocco.jpg",
    "assets/france.jpg",
    "assets/germany.jpg"
  ];
  List<String>_countriesNames=[
    "Egypt",
    "United Arab Emirates",
    "United States",
    "Saudi Arabia",
    "Morocco",
    "France",
    "Germany",
  ];

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text("Select your country and see all news",style: TextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20,),
              for(int i=0 ; i <_countriesNames.length;i++ )
                _buildOneCard(i,context),
              
            ],
          ),
        ),
      ),
    );
  }
  InkWell _buildOneCard(int index,context){
    return InkWell(
      onTap: ()async{
        await _getTapActions( index,context);
      },
      child: Container(
        margin:EdgeInsets.only(bottom: 10,left: 10,right: 10),
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: AssetImage(_pathOfAssets[index]),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: ColorManager.meduimBlack,
            ),
            Text(
              _countriesNames[index],
              style: TextStyle(
                fontSize: 32,
                color: ColorManager.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void>_getTapActions(index, context)async{
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder:(context) =>HomeScreen(),
      ),
      (route){
        return false;
      },
    );
    
    await CacheHelper.setDataAtSharedPrefrence(
      Key: CacheConstants.countryToApi, 
      value: NewsViewCubit.get(context).convertCountryNameFromFilterTobBeSitableForApi(
        _countriesNames[index],
      ),
      );
    await CacheHelper.setDataAtSharedPrefrence(
      Key: CacheConstants.countryToBeAtSettings, 
      value:_countriesNames[index],
      );

    await GetNewsCubit.get(context).getArticles(
      country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi) , 
      category: ApiConstants.generalCategory,
      );
  }
  
}



@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Select your country and see all news",style: TextStyle(
                color: ColorManager.primaryColor,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
              ),
            ),
            for(int i =0 ; i<NewsViewCubit.get(context).namesOfCountries.length ; i++)
              createButton(
                content:NewsViewCubit.get(context).namesOfCountries[i],
                fuction: ()async{
                  
                  
                  
                  
                },
              ),
          ],
        ),
      ),
    );
  }