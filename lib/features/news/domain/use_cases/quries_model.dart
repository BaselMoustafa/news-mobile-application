

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/network/remote/api_constants.dart';

class QueriesModel extends Equatable{
  String? q;
  String? country;
  String? category ;
  String _apiKey=ApiConstants.apiKey;
  QueriesModel({ this.q ,  this.country ,  this.category});

  Map<String , dynamic> toMapForSearch (){
    if(this.country==null && this.category==null)
    return {
      ApiConstants.searchWord:this.q,
      ApiConstants.keyWord:_apiKey,
    }; 
    else if(this.country==null && this.category!=null)
      return {
        ApiConstants.searchWord:this.q,
        ApiConstants.categoryWord:this.category,
        ApiConstants.keyWord:_apiKey,
        
      };
    else if( this.country!=null && this.category==null)
      return {
        ApiConstants.searchWord:this.q,
        ApiConstants.countryWord:this.country,
        ApiConstants.keyWord:_apiKey,
      };
    else
      return {
        ApiConstants.searchWord:this.q,
        ApiConstants.countryWord:this.country,
        ApiConstants.categoryWord:this.category,
        ApiConstants.keyWord:_apiKey,
      };
  }

  Map<String , dynamic> toMapForGetNews ({required String category , required String country})=>{
    

    ApiConstants.categoryWord: category,
    ApiConstants.countryWord : country,
    ApiConstants.keyWord:_apiKey,
  };
  
  
  List<Object?> get props => [
    q,
    category,
    country,
  ];
  
}