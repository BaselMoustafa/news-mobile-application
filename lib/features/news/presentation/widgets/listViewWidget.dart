import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/shared_preferencies/cache_helper.dart';
import 'package:news_app/core/network/shared_preferencies/cahceConstants.dart';
import 'package:news_app/core/style/color_manager.dart';
import 'package:news_app/core/widgets/circular_progress_indicator.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/presentation/controllers/news_get_cubit/news_get_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/news_get_cubit/news_get_states.dart';
import 'package:news_app/features/news/presentation/controllers/news_view_cubit/news_view_cubit.dart';
import 'package:news_app/features/news/presentation/screens/details_screen/details_screen.dart';
import 'package:news_app/features/news/presentation/widgets/fail_at_get_news_widget.dart.dart';

class BuildListView extends StatelessWidget {
  String categoryName ;
 BuildListView({
  required this.categoryName,
 });
  Widget build(BuildContext context) {
    return BlocBuilder<GetNewsCubit,GetNewsStates>(
      builder: (context , state){
        if(state is GetNewsSuccessState){
            return _getTheCorrectList(context: context, state: state);
          }
        else if(state is GetNewsFailedState){
          return failedAtGetNewsWidget(
            context,
            msg: state.message ,
            imageToBeDisplayed:Image.asset("assets/no_internet.png") ,
          );
        }
        else{
          return getCircularIndecator();
        }
      }
    );
  }
  
  RefreshIndicator _getTheCorrectList({required BuildContext context , required GetNewsSuccessState state}){
    NewsViewCubit _newsViewCubit =NewsViewCubit.get(context);
    if(_newsViewCubit.currentCatrgoty=="General")
      return _buildTheList(context: context, articles: state.generalNews);
    else if(_newsViewCubit.currentCatrgoty=="Business")
      return _buildTheList(context: context, articles:state.businessNews );
    else if(_newsViewCubit.currentCatrgoty=="Intertament")
      return _buildTheList(context: context, articles:state.intertamentNews );
    else if(_newsViewCubit.currentCatrgoty=="Health")
      return _buildTheList(context: context, articles:state.healthNews );
    else if(_newsViewCubit.currentCatrgoty=="Science")
      return _buildTheList(context: context, articles:state.scienceNews );
    else if(_newsViewCubit.currentCatrgoty=="Sports")
      return _buildTheList(context: context, articles:state.sportsNews );
    else
      {return _buildTheList(context: context, articles:state.technologyNews );}
  }

  RefreshIndicator _buildTheList({required BuildContext context , required List<Article> articles}){
    return RefreshIndicator(
      color: ColorManager.primaryColor,
      onRefresh: () async{
        await GetNewsCubit.get(context).getArticles(
          country: CacheHelper.getDataFromSharedPrefrences(key: CacheConstants.countryToApi), 
          category: NewsViewCubit.get(context).convertCategoryNameFromFilterTobBeSitableForApi(NewsViewCubit.get(context).currentCatrgoty)!,
          );
      },
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context,index)=>_getOneItem(context: context, article: articles[index]),
      ),
    );
  }
  InkWell _getOneItem({
    required BuildContext context,
    required Article article,
  }){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailsScreen(article: article,))
          ),
        );
      },
      child: Container(
        height: 350,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        
        child: Stack(
          children: [
            if(article.image!=null)
            Image.network(
              article.image!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            if(article.image==null)
            Image.asset(
              "assets/no_image.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: Colors.black.withOpacity(0.25),
            ),
            Align(
              alignment: Alignment(0,0.8),
              
              child: Container(
                
                clipBehavior: Clip.antiAliasWithSaveLayer,
                constraints: BoxConstraints(
                  minHeight: 50,
                  maxHeight: 150,
                ),
                width: 350,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  article.title,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600
    
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1,
                ),
              ),
            ),
          ],
        ),
      
      ),
    );
  }
}