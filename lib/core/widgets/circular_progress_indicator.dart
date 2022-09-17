import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/style/color_manager.dart';

Widget getCircularIndecator(){
  return Center(
    child: CircularProgressIndicator(
      color: ColorManager.primaryColor,
    ),
  );
}