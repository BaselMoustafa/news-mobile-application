import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/style/color_manager.dart';

abstract class ThemeManager{
  static ThemeData getTheLightTheme(){
    return ThemeData(
      fontFamily: GoogleFonts.openSans().fontFamily,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: ColorManager.primaryColor),
        titleTextStyle: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 20,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        
      ),
      scaffoldBackgroundColor: ColorManager.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      
      textTheme: const TextTheme(
        //FOR THE SELECTED TAB AND FOR SEARCH WORD AT HOME
        displayLarge:TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        //FOR NOT SELECTED TAB
        bodyLarge:TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),

        //FOR TITTLE AT THE SEARCH LIST
        headlineLarge:TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ), 
        //FOR SEARCH FOR NEWS AT SEARCH SCREEN
        headlineMedium:TextStyle(
          fontSize: 18,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          ), 
        //TEXT OF SCREEN WHEN IT WILL BE EMPTY
        titleMedium:TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Colors.grey,
        ), 
        
        //FOR THE TITLE AT FILTER WIDGET
        bodySmall:TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
  static ThemeData getTheDarkTheme(){
    
    return ThemeData(
      fontFamily: GoogleFonts.openSans().fontFamily,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: ColorManager.primaryColor),
        titleTextStyle: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 20,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
      ),
      
      scaffoldBackgroundColor: ColorManager.lightBlack,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: const TextTheme(
        //FOR THE SELECTED TAB AND FOR SEARCH WORD AT HOME
        displayLarge:TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        //FOR NOT SELECTED TAB
        bodyLarge:TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
        //FOR TITTLE AT THE SEARCH LIST
        headlineLarge:TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ), 
        //FOR SEARCH FOR NEWS AT SEARCH SCREEN
        headlineMedium:TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          ), 
        //TEXT OF SCREEN WHEN IT WILL BE EMPTY
        titleMedium:TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ), 
        //FOR TITLE AT THE FILTER WIDGET SCREEN
        bodySmall:TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}