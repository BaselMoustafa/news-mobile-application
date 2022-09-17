import 'package:flutter/material.dart';
import 'package:news_app/features/news/domain/entity/article_entity.dart';
import 'package:news_app/features/news/presentation/screens/details_screen/details_screen.dart';

class SmallListViewWidget extends StatelessWidget {
  List articles =[];
  SmallListViewWidget({required this.articles});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: ((context, index) => _getItemDesign(articles[index],context)) ,
      itemCount: articles.length,
      );
  }

 

  InkWell _getItemDesign(Article article,context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,
        MaterialPageRoute(
          builder: ((context) => DetailsScreen(article: article)),
        ),
        );
      },
      child: Container(
      child: Row(
        
        children: [
          if(article.image==null)
          Container(
            height: 150,
            width: 150,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image(
              image: AssetImage("assets/no_image.png"),
              height: double.infinity,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          if(article.image!=null)
          Container(
            height: 150,
            width: 150,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image(
              image: NetworkImage(article.image!),
              height: double.infinity,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //SizedBox(height: 5,),
                Text(
                  article.title,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineLarge,  
                ),
                
                SizedBox(height: 20,),
                
                SizedBox(
                  height:20,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      article.date,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey
                      ),
                      ),
                  ),
    
                ),
                
                
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  
}