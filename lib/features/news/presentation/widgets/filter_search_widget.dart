import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/controllers/news_search_cubit/news_search_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_states.dart';

SingleChildScrollView getFilterWidget(context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Filter results by : ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: ()async{
                  Navigator.pop(context);
                  await NewsSearchCubit.get(context).search(withFilter: true, context: context);
                }, 
                child: Text(
                  "Apply",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurple.withOpacity(0.8),
                    fontWeight: FontWeight.w900
                  ),
                ),
                ),
        
            ],
          ),
          SizedBox(height: 20,),
          Text(
            "Category",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.deepPurple.withOpacity(0.8),
            ),
          ),
          SizedBox(height:10),
          BlocBuilder<NewsViewCubit,NewsViewCubitStates>(
            builder: (context,state){
              return Wrap(
            children: [
              for(int i=0 ; i <NewsViewCubit.get(context).namesOfCat.length;i++)
                _buildFilterCategoryItem(NewsViewCubit.get(context).namesOfCat[i],context),
                ],
              );
            },
          ),
          SizedBox(height: 20,),
          Text(
            "Country",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.deepPurple.withOpacity(0.8),
            ),
          ),
          SizedBox(height:10),
          BlocBuilder<NewsViewCubit,NewsViewCubitStates>(
            builder: (context,state){
              return Wrap(
                children: [
                  for(int i=0 ; i <NewsViewCubit.get(context).namesOfCountries.length;i++)
                    _buildFilterCountryItem(NewsViewCubit.get(context).namesOfCountries[i],context),
                    ],
              );
            },
          ),
        ],
      ),
    ),
  );

  InkWell _buildFilterCountryItem(String countryName,context){
    bool _thisIsTheSelectedCountry= countryName==NewsViewCubit.get(context).filterCountry;
    return InkWell(
      onTap: (){
        NewsViewCubit.get(context).changeFilterCounrty(countryName);
        _thisIsTheSelectedCountry= countryName==NewsViewCubit.get(context).filterCountry;
      },
      child: Container(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            margin: EdgeInsets.only(right: 5,bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _thisIsTheSelectedCountry?Colors.deepPurple.withOpacity(0.8):Colors.transparent,
            ),
            child: Text(
              countryName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color:_thisIsTheSelectedCountry?Colors.white:Colors.black,
              ),
            ),
          ),
        
      

    );
  }

  InkWell _buildFilterCategoryItem(String categoryName,context){
    bool _thisIsTheSelectedCategory= categoryName==NewsViewCubit.get(context).filterCategory;
    return InkWell(
      onTap: (){
        NewsViewCubit.get(context).changeFilterCategory(categoryName);
        _thisIsTheSelectedCategory= categoryName==NewsViewCubit.get(context).filterCategory;
      },
      child: Container(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            margin: EdgeInsets.only(right: 5,bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _thisIsTheSelectedCategory?Colors.deepPurple.withOpacity(0.8):Colors.transparent,
            ),
            child: Text(
              categoryName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color:_thisIsTheSelectedCategory?Colors.white:Colors.black,
              ),
            ),
          ),
        
      

    );
  }