import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:machine_test/Api.dart';
import 'package:machine_test/Ui/MainScreen.dart';
import 'package:machine_test/utils/Provider.dart';
import 'package:machine_test/utils/Toast.dart';
import 'package:machine_test/utils/Utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading = false;

  FocusNode usernameNode = new FocusNode();
  FocusNode passwordNode = new FocusNode();


  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return Scaffold(
        bottomSheet: isLoading ?
        Center(
          child: CircularProgressIndicator(
            color: Utils.primaryColor,
          ),
        ) :
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: InkWell(
            onTap: () {

              usernameNode.unfocus();
              passwordNode.unfocus();

              if (usernameController.text.isEmpty) {
                Toast.show("Enter Username", context);
              }
              else if (passwordController.text.isEmpty) {
                Toast.show("Enter password", context);
              }
              else {
                FocusNode().unfocus();

                login(context,usernameController.text, passwordController.text);

              }
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
                      "Login",
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Utils.secondaryColor,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: SvgPicture.asset(
                      "assets/images/Polygon.svg",
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 3,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height / 5.5),
                        Text("Welcome", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 50
                        ),),
                        Text("Manage your Bus and Drivers", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0XffE4E4E4),
                    ),
                    child: TextField(
                      focusNode: usernameNode,
                      controller: usernameController,
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
                        hintText: "Enter Username",
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
                      focusNode: passwordNode,
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      obscureText: true,
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
                        hintText: "Enter Password",
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    );
  }

  Future<void> login(BuildContext context,String username, password) async {
    var response;
    String url = Api.BASE_URL + "LoginApi";

    var body = {
      'username': username,
      'password': password,
    };

    isLoading=true;
    setState(() {});

    response = await http.post(Uri.parse(url), body: body);
    isLoading = false;
    setState(() {

    });

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
}
