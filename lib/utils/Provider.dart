import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:machine_test/Api.dart';

class DataProvider with ChangeNotifier{

  String accessToken = "";

  setAccessToken(String token){
    this.accessToken=token;
    notifyListeners();
  }


}