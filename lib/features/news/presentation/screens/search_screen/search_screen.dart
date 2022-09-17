
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/style/color_manager.dart';
import 'package:news_app/core/style/mode_cubit/mode_scbit.dart';
import 'package:news_app/core/widgets/circular_progress_indicator.dart';
import 'package:news_app/core/widgets/small_list_view.dart';
import 'package:news_app/features/news/presentation/controllers/news_search_cubit/news_search_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_search_cubit/news_search_states.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_states.dart';
import 'package:news_app/features/news/presentation/widgets/filter_search_widget.dart';
import 'package:news_app/features/news/presentation/widgets/no_search_results_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey=GlobalKey<FormState>();
    return Scaffold(
      appBar: _getAppBar(context),
      body:_getBody(formKey,context),
    );
  }

  AppBar _getAppBar(context) {
    return AppBar(
      title: Text("Search"),
      backgroundColor:Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
          NewsSearchCubit.get(context).leaveTheSearchScreen(context);
        },
      ),
    );
  }

  Form _getBody(GlobalKey<FormState> formKey,context) {
    return Form(
      key: formKey,
      child:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [
                SizedBox(height:10),
                _getTextFormField(formKey,context),
                SizedBox(height: 10,),
                _getSearchList(),
              ],
            ),
        ),
      ),
      
    );
  }

  Row _getTextFormField(GlobalKey<FormState> formKey,context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onTap: (){
              NewsViewCubit.get(context).changeColorOfSearchIconAtTextFormField(ColorManager.primaryColor);
            },
            
            controller: NewsViewCubit.get(context).searchController,
            onChanged: (value)async{
              await NewsSearchCubit.get(context).search(withFilter: false, context: context);
            },
            validator: (value){
              if(value==null || value.trim().length==0){
                NewsViewCubit.get(context).changeColorOfSearchIconAtTextFormField(ColorManager.red);
                return "This field is requierd";
              }else{
                if(ModeCubit.get(context).isLight){
                  NewsViewCubit.get(context).changeColorOfSearchIconAtTextFormField(ColorManager.grey);
                }else{
                  NewsViewCubit.get(context).changeColorOfSearchIconAtTextFormField(ColorManager.white);
                }
              }
            },
            onFieldSubmitted: (_){
              formKey.currentState!.validate();
              
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Search for news ...", 
              hintStyle: Theme.of(context).textTheme.headlineMedium,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.primaryColor,
                  width: 3,
                ),
              ),  
              enabledBorder: OutlineInputBorder(
                borderSide:ModeCubit.get(context).isLight? BorderSide(
                  color: ColorManager.grey,
                  width: 3,
                ): BorderSide(
                  color: ColorManager.white,
                  width: 3,
                ),
              ),
              prefixIcon: BlocBuilder<NewsViewCubit,NewsViewCubitStates>(
                builder: ((context, state) {
                 
                  return Icon(
                    Icons.search,
                    color: NewsViewCubit.get(context).colorOfSearchIconAtTextFormField,
                    );  
                }),
              ),            
            ),
            cursorColor: ColorManager.primaryColor,
            
          ),
        ),
        BlocBuilder<NewsSearchCubit,NewsSearchCubitStates>(
          builder: (context,state){
            if(state is NewsSearchSuccessState || state is NewsSearchLoadingState){
              return IconButton(
                icon: Icon(Icons.format_list_bulleted_sharp,size: 25,color: ColorManager.primaryColor,),
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context){
                      return getFilterWidget(context);
                    }
                  );
                },
              );
            }else{
              return SizedBox(height:10);
            }
          },
        )
      ],
    );
  }

  Widget _getSearchList() {
    return BlocBuilder<NewsSearchCubit,NewsSearchCubitStates>(
        builder: (context,state){
          if(state is NewsSearchSuccessState){
            if(state.searhResults.isEmpty){
              return noSearchResultsWidget(context);
            }else{
              return SmallListViewWidget(articles: state.searhResults);
            }
          }
          else if(state is NewsSearchLoadingState){
            return getCircularIndecator();
          }
          else if (state is NewsSearchFailedState){
            return Column(
              children: [
                Center(
                  child: Container(
                    child: Image.asset("assets/empty_search.png"),
                    
                  ),
                ),
              ],
            );
          }
          else{
            return _getNoSearchYetWidget();
          }
        },
      );
    
  }

  Center _getNoSearchYetWidget() => Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search,size: 120,color: ColorManager.grey,),
          SizedBox(height: 20,),
          Text(
            "Search now and see all news",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: ColorManager.grey,
            ),
          ),
    
        ],
      ),
    ),
  );
}