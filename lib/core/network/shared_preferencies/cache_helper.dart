import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;

  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  
static Future setDataAtSharedPrefrence ({required String Key , required value})async
{
  if(value is bool) return await sharedPreferences!.setBool(Key, value);
  if(value is int) return await sharedPreferences!.setInt(Key, value);
  if(value is String) return await sharedPreferences!.setString(Key, value);
  if(value is double) return await sharedPreferences!.setDouble(Key, value);
}

static getDataFromSharedPrefrences({required String key})
{
  return sharedPreferences!.get(key);
}

static removeDataAtSharedPrefrence({required String key}){
  return sharedPreferences?.remove(key);
}

}