import 'package:flutter/material.dart';
import 'package:shop_app/layers/singn_in_and_sign_up/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';

String ? token='';
void signOut(context){
    CacheHelper.removeData(key: 'token').then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    });
}
void printAllText(String text){

  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

