import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/Model/DriversModelFile.dart';
import 'package:machine_test/Ui/DriversListScreen.dart';
import 'package:machine_test/utils/Provider.dart';
import 'package:machine_test/utils/Utils.dart';
import 'package:provider/provider.dart';

class BusLayoutScreen extends StatefulWidget {
  String busName,busShortName,driver,license,seatLayout;
  BusLayoutScreen(this.busName,this.busShortName,this.driver,this.license,this.seatLayout);


  @override
  State<BusLayoutScreen> createState() => _BusLayoutScreenState();
}

class _BusLayoutScreenState extends State<BusLayoutScreen> {

  bool isAssign = true;
  DriverModelFile assignedDriver = new DriverModelFile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        DriversListScreen(isAssign))).then((value) {
                          if(Provider.of<DataProvider>(context, listen: false).status == true){
                            assignedDriver = value;
                            widget.driver = assignedDriver.name.toString();
                            widget.license = assignedDriver.licenseNo.toString();
                            setState(() {

                            });
                          }
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
                    "Assign Driver",
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
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height / 8,
        title: Text(widget.busShortName + " " + widget.busName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Utils.secondaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.driver, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 30
                          ),),
                          Text("License No: " + widget.license, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12
                          ),),
                        ],
                      ),
                      Image.asset("assets/images/driver.png")
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25,),
                    Align(
                      alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 22.0),
                          child: Image.asset("assets/images/dseat.png"),
                        )),
                    SizedBox(height: 25,),

                widget.seatLayout == "2x2"?
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ( Utils.seatList.length / 4).ceil(),
                  itemBuilder: (BuildContext context, int index) {
                    int i = index * 4;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (i <  Utils.seatList.length)
                            Image.asset("assets/images/pseat.png"),
                          if (i + 1 <  Utils.seatList.length)
                            Image.asset("assets/images/pseat.png"),
                          SizedBox(width: 32.0),
                          if (i + 2 <  Utils.seatList.length)
                            Image.asset("assets/images/pseat.png"),
                          if (i + 3 <  Utils.seatList.length)
                            Image.asset("assets/images/pseat.png"),
                        ],
                      ),
                    );
                  },
                ):
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ( Utils.seatList.length / 4).ceil(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.0,left: 15,right: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/images/pseat.png"),
                          SizedBox(width: 32.0),
                          Image.asset("assets/images/pseat.png"),
                          Image.asset("assets/images/pseat.png"),
                          Image.asset("assets/images/pseat.png"),
                        ],
                      ),
                    );
                  },
                ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        )
      ),
    );
  }
}

class Seat extends StatelessWidget {
  final String seatCode;

  Seat({required this.seatCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(seatCode),
      ),
    );
  }
}
