import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/Api.dart';
import 'package:machine_test/Model/BusModelFile.dart';
import 'package:machine_test/Model/DriversModelFile.dart';
import 'package:machine_test/Ui/MainScreen.dart';
import 'package:machine_test/utils/Utils.dart';
import 'package:provider/provider.dart';
import 'Toast.dart';

class DataProvider with ChangeNotifier {
  String accessToken = "";
  String urlId = "";
  String busId = "";
  var status;
  bool isLoading = false;
  bool isBusLoading = false;
  bool isDriverLoading = false;
  bool isDeleting = false;
  bool isAssigning = false;
  bool isAddDriver = false;

  List<DriverModelFile> driversList = [];

  setAccessToken(String token) {
    this.accessToken = token;
    notifyListeners();
  }

  setUrlId(String urlId) {
    this.urlId = urlId;
    notifyListeners();
  }

  setBusId(String busId) {
    this.busId = busId;
    notifyListeners();
  }

  Future<void> login(BuildContext context, String username, password) async {
    var response;
    String url = Api.BASE_URL + "LoginApi";

    var body = {
      'username': username,
      'password': password,
    };

    isLoading = true;

    response = await http.post(Uri.parse(url), body: body);
    isLoading = false;

    if (response.statusCode == 200) {
      String responseString = response.body;

      var accessToken = jsonDecode(responseString)["access"];
      var msg = jsonDecode(responseString)["message"];
      var urlId = jsonDecode(responseString)["url_id"];
      var name = jsonDecode(responseString)["name"];
      var status = jsonDecode(responseString)["status"];
      if (status == true) {
        Provider.of<DataProvider>(context, listen: false)
            .setAccessToken(accessToken);
        Provider.of<DataProvider>(context, listen: false).setUrlId(urlId);

        Toast.show(msg, context,
            backgroundColor: Utils.primaryColor,
            textStyle: TextStyle(color: Colors.white));

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainScreen()));
      }
    }
  }

  Future<void> getDriversList(BuildContext context) async {
    var response;

    isDriverLoading = true;

    String url = Api.BASE_URL +
        "DriverApi" +
        "/" +
        Provider.of<DataProvider>(context, listen: false).urlId +
        "/";
    response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer " +
          Provider.of<DataProvider>(context, listen: false).accessToken
    });

    isDriverLoading = false;

    if (response.statusCode == 200) {
      String responseString = response.body;
      var data = jsonDecode(responseString);
      var resultData = data["driver_list"];

      driversList = List<DriverModelFile>.from(
          resultData.map((x) => DriverModelFile.fromJson(x)));

      notifyListeners();
    }
  }

  Future<void> getBusList(BuildContext context) async {
    var response;

    isBusLoading = true;

    String url = Api.BASE_URL +
        "BusListApi" +
        "/" +
        Provider.of<DataProvider>(context, listen: false).urlId +
        "/";
    response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer " +
          Provider.of<DataProvider>(context, listen: false).accessToken
    });

    isBusLoading = false;

    if (response.statusCode == 200) {
      String responseString = response.body;
      var data = jsonDecode(responseString);
    }
  }

  Future<void> addDriver(
      BuildContext context, String name, mobile, licenseNo) async {
    var response;

    isAddDriver = true;

    String url = Api.BASE_URL +
        "DriverApi" +
        "/" +
        Provider.of<DataProvider>(context, listen: false).urlId +
        "/";

    var body = {
      'name': name,
      'mobile': mobile,
      'license_no': licenseNo,
    };

    response = await http.post(Uri.parse(url), body: body, headers: {
      "Authorization": "Bearer " +
          Provider.of<DataProvider>(context, listen: false).accessToken
    });

    isAddDriver = false;

    if (response.statusCode == 200) {
      String responseString = response.body;
      var data = jsonDecode(responseString);
    }
  }

  Future<void> deleteDriver(BuildContext context, String driverId) async {
    var response;

    isDeleting = true;

    String url = Api.BASE_URL +
        "DriverApi" +
        "/" +
        Provider.of<DataProvider>(context, listen: false).urlId +
        "/";

    var body = {
      'driver_id': driverId,
    };

    response = await http.delete(Uri.parse(url), body: body, headers: {
      "Authorization": "Bearer " +
          Provider.of<DataProvider>(context, listen: false).accessToken
    });

    isDeleting = false;

    if (response.statusCode == 200) {
      String responseString = response.body;
      var data = jsonDecode(responseString);
      var msg = data["message"];
      var status = data["status"];
      if (status == true) {
        Toast.show(msg, context,
            backgroundColor: Utils.primaryColor,
            textStyle: TextStyle(color: Colors.white));
      }
    }
  }

  Future<void> assignDriver(
      BuildContext context, String driverId, busId) async {
    var response;

    isAssigning = true;

    String url = Api.BASE_URL +
        "AssignDriverApi" +
        "/" +
        Provider.of<DataProvider>(context, listen: false).urlId +
        "/";

    var body = {
      'bus_id': busId,
      'driver_id': driverId,
    };

    response = await http.patch(Uri.parse(url), body: body, headers: {
      "Authorization": "Bearer " +
          Provider.of<DataProvider>(context, listen: false).accessToken
    });

    isAssigning = false;

    if (response.statusCode == 200) {
      String responseString = response.body;
      var data = jsonDecode(responseString);
      var msg = data["message"];
      status = data["status"];
      Toast.show(msg, context,
          backgroundColor: Utils.primaryColor,
          textStyle: TextStyle(color: Colors.white));
    }
  }
}
