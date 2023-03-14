// To parse this JSON data, do
//
//     final driverModelFile = driverModelFileFromJson(jsonString);

import 'dart:convert';

BusModelFile busModelFileFromJson(String str) => BusModelFile.fromJson(json.decode(str));

String busModelFileToJson(BusModelFile data) => json.encode(data.toJson());

class BusModelFile {
  BusModelFile({
    this.id,
    this.name,
    this.shortName,
    this.driver,
    this.driverLicense,
    this.seatLayout,
  });

  int? id;
  String? name;
  String? shortName;
  String? driver;
  String? driverLicense;
  String? seatLayout;

  factory BusModelFile.fromJson(Map<String, dynamic> json) => BusModelFile(
    id: json["id"],
    name: json["name"],
    shortName: json["shortName"],
    driver: json["driver"],
    driverLicense: json["driverLicense"],
    seatLayout: json["seatLayout"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "shortName": shortName,
    "driver": driver,
    "driverLicense": driverLicense,
    "seatLayout": seatLayout,
  };
}
