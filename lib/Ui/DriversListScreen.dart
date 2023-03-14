import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/Api.dart';
import 'package:machine_test/Model/DriversModelFile.dart';
import 'package:machine_test/Ui/AddDriverScreen.dart';
import 'package:machine_test/utils/Provider.dart';
import 'package:machine_test/utils/Toast.dart';
import 'package:machine_test/utils/Utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DriversListScreen extends StatefulWidget {
  const DriversListScreen({Key? key}) : super(key: key);

  @override
  _DriversListScreenState createState() => _DriversListScreenState();
}

class _DriversListScreenState extends State<DriversListScreen> {

 bool isLoading=false;
 List<DriverModelFile> driversList = [];

 @override
  void initState() {

   getDriversList(context);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:
      Visibility(
        visible: !isLoading,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          AddDriverScreen())).then((value){
                getDriversList(context);
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Utils.primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                    child: Text(
                      "Add Driver",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Utils.secondaryColor,
        toolbarHeight: MediaQuery.of(context).size.height/8,
        title: Text("Driver List"),
        centerTitle: true,
      ),
      body: isLoading?
          Center(
            child: CircularProgressIndicator(
              color: Utils.primaryColor,
            ),
          ):
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(driversList.length.toString() + " Drivers Found",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500
                ),),

              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: driversList.length,
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
                                child: Image.asset("assets/images/driverimg.png"),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        driversList[position].name.toString(),
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Licn no: " + driversList[position].licenseNo.toString(),
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
                                    deleteDriver(context,driversList[position].id.toString()).then((value){
                                      getDriversList(context);
                                    });
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
        ),
      ),
    );
  }

  Future<void> getDriversList(BuildContext context) async {

    var response;

    isLoading=true;
    setState(() {});

    String url = Api.BASE_URL + "DriverApi" + "/" + Provider.of<DataProvider>(context, listen: false).urlId + "/";
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
      var resultData = data["driver_list"];

      driversList = List<DriverModelFile>.from(
          resultData.map((x) => DriverModelFile.fromJson(x)));

      setState(() {

      });

    }
  }

 Future<void> deleteDriver(BuildContext context, String driverId) async {

   var response;

   String url = Api.BASE_URL + "DriverApi" + "/" + Provider.of<DataProvider>(context, listen: false).urlId + "/";
   setState(() {

   });

   var body = {
     'driver_id': driverId,
   };


   response =
   await http.delete(Uri.parse(url), body: body,headers: {
     "Authorization": "Bearer " + Provider.of<DataProvider>(context, listen: false).accessToken
   });
   if (response.statusCode == 200) {
     String responseString = response.body;
     var data = jsonDecode(responseString);
     var msg = data["message"];

     Toast.show(msg, context);
   }
 }
}
