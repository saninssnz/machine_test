import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/Api.dart';
import 'package:machine_test/Model/BusModelFile.dart';
import 'package:machine_test/Model/DriversModelFile.dart';
import 'package:machine_test/Ui/MainScreen.dart';
import 'package:provider/provider.dart';
import 'Toast.dart';

class DataProvider with ChangeNotifier{

  String accessToken = "";
  String urlId = "";

  bool isLoading = false;
  bool isBusLoading = false;
  bool isDriverLoading=false;
  bool isDeleting=false;

  List<DriverModelFile> driversList = [];

  setAccessToken(String token){
    this.accessToken=token;
    notifyListeners();
  }

  setUrlId(String urlId){
    this.urlId=urlId;
    notifyListeners();
  }


  Future<void> login(BuildContext context,String username, password) async {
    var response;
    String url = Api.BASE_URL + "LoginApi";

    var body = {
      'username': username,
      'password': password,
    };

    isLoading=true;


    response = await http.post(Uri.parse(url), body: body);
    isLoading = false;


    if (response.statusCode == 200) {
      String responseString = response.body;

      var accessToken = jsonDecode(responseString)["access"];
      var msg = jsonDecode(responseString)["message"];
      var urlId = jsonDecode(responseString)["url_id"];
      var name = jsonDecode(responseString)["name"];
      var status = jsonDecode(responseString)["status"];
      if(status == true){

        Provider.of<DataProvider>(context, listen: false).setAccessToken(accessToken);
        Provider.of<DataProvider>(context, listen: false).setUrlId(urlId);

        Toast.show(msg, context);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>
                    MainScreen()));
      }
    }
  }

  Future<void> getDriversList(BuildContext context) async {

    var response;

    isDriverLoading=true;

    String url = Api.BASE_URL + "DriverApi" + "/" + Provider.of<DataProvider>(context, listen: false).urlId + "/";
    response =
    await http.get(Uri.parse(url),headers: {
      "Authorization": "Bearer " + Provider.of<DataProvider>(context, listen: false).accessToken
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

    isBusLoading=true;


    String url = Api.BASE_URL + "BusListApi" + "/" + Provider.of<DataProvider>(context, listen: false).urlId + "/";
    response =
    await http.get(Uri.parse(url),headers: {
      "Authorization": "Bearer " + Provider.of<DataProvider>(context, listen: false).accessToken
    });

    isBusLoading = false;


    if (response.statusCode == 200) {
      String responseString = response.body;
      var data = jsonDecode(responseString);


    }
  }

  Future<void> deleteDriver(BuildContext context, String driverId) async {

    var response;

    isDeleting=true;

    String url = Api.BASE_URL + "DriverApi" + "/" + Provider.of<DataProvider>(context, listen: false).urlId + "/";

    var body = {
      'driver_id': driverId,
    };


    response =
    await http.delete(Uri.parse(url), body: body,headers: {
      "Authorization": "Bearer " + Provider.of<DataProvider>(context, listen: false).accessToken
    });

    isDeleting=false;


    if (response.statusCode == 200) {
      String responseString = response.body;
      var data = jsonDecode(responseString);
      var msg = data["message"];

      Toast.show(msg, context);

    }
  }


  List<BusModelFile> myList = [
    BusModelFile(
        name: 'Swift Scania P-Series',
        shortName: "KSRTC",
        driver: "San",
        driverLicense: "123",
        id: 123,
        seatLayout: "1x3"
    ),
    BusModelFile(
        name: 'Swift Scania P-Series',
        shortName: "KSRTC",
        driver: "Sanin",
        driverLicense: "12355",
        id: 123,
        seatLayout: "2x2"
    ),
    BusModelFile(
        name: 'Swift Scania P-Series',
        shortName: "KSRTC",
        driver: "S",
        driverLicense: "12312",
        id: 123,
        seatLayout: "1x3"
    ),
  ];


  List<String> seatList = [
    '1A', '1B',
    '2A', '2B',
    '3A', '3B',
    '4A', '4B',
    '5A', '5B',
    '6A', '6B',
    '7A', '7B',
    '8A', '8B',
    '9A', '9B',
    '10A', '10B',
    '11A', '11B',
    '12A', '12B',
    '13A', '13B',
    '14A', '14B',
    '14A', '14B',
    '14A', '14B',
    '14A', '14B',
    '14A', '14B',
    '14A', '14B',
    '14A', '14B',
    '14A', '14B',
    '14A', '14B',
    '14A', '14B',
    '14A', '14B',
  ];

}