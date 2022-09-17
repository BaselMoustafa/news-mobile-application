import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/style/color_manager.dart';
import 'package:news_app/core/style/mode_cubit/mode_scbit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  String urlOfTheArticle;
  WebViewScreen({required this.urlOfTheArticle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      
      body: WebView(
        initialUrl: urlOfTheArticle,
        backgroundColor:ModeCubit.get(context).isLight?ColorManager.white:ColorManager.black,
      ),
    );
  }
}
