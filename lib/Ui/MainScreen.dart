import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:machine_test/Api.dart';
import 'package:machine_test/Model/BusModelFile.dart';
import 'package:machine_test/Ui/DriversListScreen.dart';
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
        toolbarHeight: MediaQuery.of(context).size.height/8,
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
                  child: InkWell(
                    onTap: (){
                      getBusList(context);
                    },
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  DriversListScreen()));
                    },
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
              ),
            ],
          ),
          SizedBox(height:20),
          Text(myList.length.toString() + " Drivers Found",
            style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500
            ),),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: myList.length,
              itemBuilder: (BuildContext context, int position) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Card(
                      elevation: 2,
                      color:Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                topLeft: Radius.circular(8),
                              ),
                              color: Colors.grey[300],
                            ),
                            height: 70,
                            child:  Image.asset("assets/images/bus2.png")
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myList[position].shortName.toString(),
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                   myList[position].name.toString(),
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: InkWell(
                              onTap: (){
                                // deleteDriver(context,driversList[position].id.toString()).then((value){
                                //   getDriversList(context);
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Utils.primaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {

                  },
                );
              },
            ),
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
        setState(() {

        });

      }
  }
}
