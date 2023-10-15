// To parse this JSON data, do
//
//     final travelTabModel = travelTabModelFromJson(jsonString);

import 'dart:convert';

TravelTabModel travelTabModelFromJson(String str) =>
    TravelTabModel.fromJson(json.decode(str));

String travelTabModelToJson(TravelTabModel data) => json.encode(data.toJson());

class TravelTabModel {
  String currentTime;
  District district;

  TravelTabModel({
    required this.currentTime,
    required this.district,
  });

  factory TravelTabModel.fromJson(Map<String, dynamic> json) => TravelTabModel(
        currentTime: json["currentTime"],
        district: District.fromJson(json["district"]),
      );

  Map<String, dynamic> toJson() => {
        "currentTime": currentTime,
        "district": district.toJson(),
      };
}

class District {
  int districtId;
  String districtName;
  List<TabGroups> groups;

  District({
    required this.districtId,
    required this.districtName,
    required this.groups,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        districtId: json["districtId"],
        districtName: json["districtName"],
        groups: List<TabGroups>.from(
            json["groups"].map((x) => TabGroups.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "districtId": districtId,
        "districtName": districtName,
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
      };
}

class TabGroups {
  int? type;
  String code;
  String name;
  String note;

  TabGroups({
    this.type,
    required this.code,
    required this.name,
    required this.note,
  });

  factory TabGroups.fromJson(Map<String, dynamic> json) => TabGroups(
        type: json["type"],
        code: json["code"],
        name: json["name"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "name": name,
        "note": note,
      };
}
