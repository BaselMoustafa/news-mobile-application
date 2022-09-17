import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/style/color_manager.dart';
import 'package:news_app/core/style/mode_cubit/mode_scbit.dart';
import 'package:news_app/features/news/presentation/controllers/news_get_cubit/news_get_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_states.dart';
import 'package:news_app/features/news/presentation/screens/search_screen/search_screen.dart';
import 'package:news_app/features/news/presentation/screens/settings_screen/settings_screen.dart';
import 'package:news_app/features/news/presentation/widgets/listViewWidget.dart';
class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    NewsViewCubit _newsViewCubit = NewsViewCubit.get(context);
    return DefaultTabController(
      length: _newsViewCubit.namesOfCat.length,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _getAppBar(context),
          body:_getBody(context, _newsViewCubit),
          floatingActionButton:_getFloatingActionButton(context),
        ),
      
    );
  }

  FloatingActionButton _getFloatingActionButton(context) => FloatingActionButton(
    onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => SettingsScreen()),
          ),
        );
      },
    backgroundColor: ColorManager.primaryColor,
    child: Icon(
      Icons.settings,
      
    ),
    );

  SafeArea _getBody(BuildContext context, NewsViewCubit _newsViewCubit)  {
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            _getTabsOfTheTabBar(context, _newsViewCubit),
            _getPagesOfTabBar(context),
          ],
        ),
      ),
    );
  }

  Expanded _getPagesOfTabBar(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            for(int i = 0 ; i < NewsViewCubit.get(context).namesOfCat.length;i++)
              BuildListView(categoryName:NewsViewCubit.get(context).namesOfCat[i] )
          ],
        ),
      ),
    );
  }

  BlocBuilder _getTabsOfTheTabBar(BuildContext context, NewsViewCubit _newsViewCubit)  {
    return BlocBuilder<NewsViewCubit , NewsViewCubitStates>(
      builder: ((context, state) {
        return TabBar(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            
          ),
          physics: BouncingScrollPhysics(),
          isScrollable: true,
          indicatorColor: ColorManager.primaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 3,
          unselectedLabelColor: ColorManager.grey,
          labelColor: ColorManager.black,
          onTap: (value)async{
            NewsViewCubit.get(context).changeTheCurrentCategory(value);
            await GetNewsCubit.get(context).ensureTheListIsLoaded(context);
          },
          tabs: [
            for(int i =0 ; i<_newsViewCubit.namesOfCat.length;i++)
            _getOneTab(
              name: _newsViewCubit.namesOfCat[i],
              index:i,
              context: context,
              ),
          ],
        );
      }),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorManager.transparent,
      
      actions: [
        _getDesignOfSearch(context),  
      ],
      
    );
  }

  Expanded _getDesignOfSearch(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => SearchScreen())
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          
          decoration: BoxDecoration(
            color: ColorManager.lightGrey,
            borderRadius: BorderRadius.circular(8),
                    
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 25,
                  color: ModeCubit.get(context).isLight?ColorManager.black:ColorManager.white,
                  ),
                SizedBox(width: 15,),
                Text(
                  "Search",
                  style: Theme.of(context).textTheme.displayLarge,
                  ),
              ],
            ),
          ),
          
        ),
      ),
    );
  }

  
  
  Container _getOneTab({required String name , required int index,required BuildContext context}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        name,
        style:NewsViewCubit.get(context).currentIndex==index ?Theme.of(context).textTheme.displayLarge :Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

}


