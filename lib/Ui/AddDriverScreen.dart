import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/Api.dart';
import 'package:machine_test/Ui/DriversListScreen.dart';
import 'package:machine_test/utils/Provider.dart';
import 'package:machine_test/utils/Toast.dart';
import 'package:machine_test/utils/Utils.dart';
import 'package:provider/provider.dart';

class AddDriverScreen extends StatefulWidget {
  const AddDriverScreen({Key? key}) : super(key: key);

  @override
  _AddDriverScreenState createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController licenseNoController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();

  bool isAddDriver = false;

  FocusNode nameNode = new FocusNode();
  FocusNode licenseNode = new FocusNode();
  FocusNode mobileNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: InkWell(
          onTap: () {

            nameNode.unfocus();
            mobileNode.unfocus();
            licenseNode.unfocus();

            if(nameController.text.isEmpty){
              Toast.show("Enter name", context);
            }
            else if(mobileController.text.isEmpty){
              Toast.show("Enter Mobile Number", context);
            }
            else if(licenseNoController.text.isEmpty){
              Toast.show("Enter License Number", context);
            }
            else{
              addDriver(context, nameController.text, mobileController.text, licenseNoController.text).then((value){
               Navigator.of(context).pop();
              });
            }
          },
          child: isAddDriver?
              Center(
                  child: CircularProgressIndicator(
                    color: Utils.primaryColor,)):
          Padding(
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
                    "Save",
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Utils.secondaryColor,
        toolbarHeight: MediaQuery.of(context).size.height/8,
        title: Text("Add Driver"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 25.0, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0XffE4E4E4),
              ),
              child: TextField(
                controller: nameController,
                focusNode: nameNode,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                  // Added this
                  contentPadding: EdgeInsets.all(15),
                  hintStyle: TextStyle(color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  hintText: "Enter Name",
                ),
                cursorColor: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 25.0, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0XffE4E4E4),
              ),
              child: TextField(
                controller: mobileController,
                focusNode: mobileNode,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                  // Added this
                  contentPadding: EdgeInsets.all(15),
                  hintStyle: TextStyle(color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  hintText: "Enter Mobile Number",
                ),
                cursorColor: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 25.0, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0XffE4E4E4),
              ),
              child: TextField(
                controller: licenseNoController,
                focusNode: licenseNode,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                  // Added this
                  contentPadding: EdgeInsets.all(15),
                  hintStyle: TextStyle(color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  hintText: "Enter License Number",
                ),
                cursorColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addDriver(BuildContext context, String name,mobile,licenseNo) async {

    var response;

    isAddDriver=true;
    setState(() {});

    String url = Api.BASE_URL + "DriverApi" + "/" + Provider.of<DataProvider>(context, listen: false).urlId + "/";

    var body = {
      'name': name,
      'mobile': mobile,
      'license_no': licenseNo,
    };


    response =
    await http.post(Uri.parse(url), body: body,headers: {
      "Authorization": "Bearer " + Provider.of<DataProvider>(context, listen: false).accessToken
    });

    isAddDriver = false;
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
