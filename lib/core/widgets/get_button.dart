import 'package:flutter/material.dart';

Container createButton({required String content, required VoidCallback fuction}) {
    return Container(
      height: 50,
      width: double.infinity,
      
      margin:EdgeInsets.symmetric(horizontal: 25,vertical: 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.deepPurple.withOpacity(0.8),
      ),
      child: InkWell(
        onTap:fuction,
        child: Center(
          child: Text(
            content,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }