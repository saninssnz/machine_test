import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:machine_test/Api.dart';
import 'package:machine_test/utils/Provider.dart';
import 'package:machine_test/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  bool isLoading = false;

  @override
  void initState() {

    getBusList(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Utils.secondaryColor,
        toolbarHeight: MediaQuery.of(context).size.height/7,
        title: SvgPicture.asset(
          "assets/images/logo.svg",
          height: MediaQuery.of(context).size.height/15,
          width:  MediaQuery.of(context).size.width-50,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/4,
                    width:  MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Utils.primaryColor,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bus", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30
                              ),),
                              Text("Manage your Bus", style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Image.asset("assets/images/bus.png",),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/4,
                    width:  MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Utils.secondaryColor,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Driver", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30
                              ),),
                              Text("Manage your Driver", style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset("assets/images/driver.png",))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getBusList(BuildContext context) async {

      var response;

      isLoading=true;
      setState(() {});

      String url = Api.BASE_URL + "BusListApi" + "/" + Provider.of<DataProvider>(context, listen: false).urlId + "/";
      response =
      await http.get(Uri.parse(url),headers: {
        "Authorization": "Bearer " + Provider.of<DataProvider>(context, listen: false).accessToken
      });

      isLoading = false;
      setState(() {

      });

      if (response.statusCode == 200) {
        String responseString = response.body;
        var data = jsonDecode(responseString);

      }
  }
}
