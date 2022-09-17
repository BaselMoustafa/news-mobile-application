import 'package:flutter/material.dart';
import 'package:news_app/core/network/shared_preferencies/cache_helper.dart';
import 'package:news_app/core/network/shared_preferencies/cahceConstants.dart';
import 'package:news_app/features/news/presentation/controllers/news_get_cubit/news_get_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_cubit.dart';

Widget failedAtGetNewsWidget(context,{required String msg , required Image imageToBeDisplayed})=>Center(
  child: RefreshIndicator(
    onRefresh: ()async{
      await GetNewsCubit.get(context).getArticles(
          country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), 
          category: NewsViewCubit.get(context).convertCategoryNameFromFilterTobBeSitableForApi(NewsViewCubit.get(context).currentCatrgoty)!,
          );
    },
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 300,
            height: 400,
            child: imageToBeDisplayed,
          ),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 300,),
        ],
      ),
    ),
  ),
);