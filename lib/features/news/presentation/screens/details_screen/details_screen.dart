



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/style/color_manager.dart';
import 'package:news_app/core/style/mode_cubit/mode_scbit.dart';
import 'package:news_app/core/widgets/get_button.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/presentation/screens/web_view_screen/web_view_screen.dart';

class DetailsScreen extends StatelessWidget {
  Article article;
  DetailsScreen({required this.article});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      extendBodyBehindAppBar: true,

      body: _getBody(context),
    );
  }

  Stack _getBody(context) {
    return Stack(
      children: [
        if(article.image==null)
        Image(
          image: AssetImage("assets/no_image.png"),
          width: double.infinity,
          height: 600,
          fit: BoxFit.cover,
        ),
        if(article.image!=null)
        Image(
          image: NetworkImage(article.image!),
          width: double.infinity,
          height: 600,
          fit: BoxFit.cover,
        ),
        _getTheArticleView(context),
      ],
    );
  }

  Align _getTheArticleView(context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          constraints: BoxConstraints(
            maxHeight: 450,
            minHeight:350,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: ModeCubit.get(context).isLight?ColorManager.white:ColorManager.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child:SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                _getOneDrtailForArtcle(title: "Source", content: article.sourceName,context:context),
                _getOneDrtailForArtcle(title: "Title", content: article.title,context:context),
                _getOneDrtailForArtcle(title: "Published At", content: article.date,context:context),
                if(article.description !=null)
                _getOneDrtailForArtcle(title: "Description", content: article.description!,context:context),
                SizedBox(height: 30,),
                createButton(
                  content: "See the article in web view",
                  fuction: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => WebViewScreen(urlOfTheArticle: article.url))
                      )
                    );
                  },
                ),
                SizedBox(height: 15,),
                
              ],
            ),
          ),
        ),
      );
  }

  

  Column _getOneDrtailForArtcle({required String title , required String content , required context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height:20),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 5,),
          Text(
            content,
            style: Theme.of(context).textTheme.displayLarge,
          ),
      ],
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      
    );
  }
}