import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:machine_test/Api.dart';

class DataProvider with ChangeNotifier{

  String accessToken = "";
  String urlId = "";

  setAccessToken(String token){
    this.accessToken=token;
    notifyListeners();
  }

  setUrlId(String urlId){
    this.urlId=urlId;
    notifyListeners();
  }


}