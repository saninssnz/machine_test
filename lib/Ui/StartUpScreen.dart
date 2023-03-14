import 'package:flutter/material.dart';
import 'package:machine_test/Ui/LoginScreen.dart';
import 'package:machine_test/utils/Utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartUpScreen extends StatelessWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Utils.primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10),
            SvgPicture.asset(
            "assets/images/logo.svg",
              height: MediaQuery.of(context).size.height/10,
              width:  MediaQuery.of(context).size.width-50,
        ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                            color: Utils.primaryColor,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
