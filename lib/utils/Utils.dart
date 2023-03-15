import 'dart:ui';

import 'package:machine_test/Model/BusModelFile.dart';

class Utils{
  static Color primaryColor = Color(0xfffc153b);
  static Color secondaryColor = Color(0xff2a2a2a);

  static List<BusModelFile> myList = [
    BusModelFile(
        name: 'Swift Scania P-Series',
        shortName: "KSRTC",
        driver: "San",
        driverLicense: "123",
        id: 123,
        seatLayout: "1x3"
    ),
    BusModelFile(
        name: 'Swift Scania K-Series',
        shortName: "KSRTC",
        driver: "Sanin",
        driverLicense: "12355",
        id: 456,
        seatLayout: "2x2"
    ),
    BusModelFile(
        name: 'Swift Scania J-Series',
        shortName: "KSRTC",
        driver: "S",
        driverLicense: "12312",
        id: 789,
        seatLayout: "1x3"
    ),
  ];


  static List<String> seatList = [
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
  ];

}