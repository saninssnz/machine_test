// To parse this JSON data, do
//
//     final driverModelFile = driverModelFileFromJson(jsonString);

import 'dart:convert';

DriverModelFile driverModelFileFromJson(String str) => DriverModelFile.fromJson(json.decode(str));

String driverModelFileToJson(DriverModelFile data) => json.encode(data.toJson());

class DriverModelFile {
  DriverModelFile({
    this.id,
    this.name,
    this.mobile,
    this.licenseNo,
  });

  int? id;
  String? name;
  String? mobile;
  String? licenseNo;

  factory DriverModelFile.fromJson(Map<String, dynamic> json) => DriverModelFile(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    licenseNo: json["license_no"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "license_no": licenseNo,
  };
}
