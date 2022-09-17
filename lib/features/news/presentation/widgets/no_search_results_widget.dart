import 'package:flutter/material.dart';

Widget noSearchResultsWidget(context)=>Center(
  child: SingleChildScrollView(
    child: Column(
      children: [
        Container(
          width: 300,
          height: 400,
          child: Image(
            image: AssetImage("assets/empty_search.png"),
          ),
        ),
        Text(
          "We have no results for you , Please try to specify country or category",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  ),
);