// To parse this JSON data, do
//
//     final travelParamsModel = travelParamsModelFromJson(jsonString);

import 'dart:convert';

TravelParamsModel travelParamsModelFromJson(String str) =>
    TravelParamsModel.fromJson(json.decode(str));

String travelParamsModelToJson(TravelParamsModel data) =>
    json.encode(data.toJson());

class TravelParamsModel {
  Map params;
  String url;
  TravelTab tabs;

  TravelParamsModel({
    required this.params,
    required this.url,
    required this.tabs,
  });

  factory TravelParamsModel.fromJson(Map<String, dynamic> json) =>
      TravelParamsModel(
        url: json["url"],
        params: json['params'],
        tabs: TravelTab.fromJson(json["tabs"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "tabs": tabs.toJson(),
      };
}

class TravelTab {
  String labelName;
  String groupChannelCode;
  List<Group> groups;

  TravelTab({
    required this.labelName,
    required this.groupChannelCode,
    required this.groups,
  });

  factory TravelTab.fromJson(Map<String, dynamic> json) => TravelTab(
        labelName: json["labelName"],
        groupChannelCode: json["groupChannelCode"],
        groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "labelName": labelName,
        "groupChannelCode": groupChannelCode,
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
      };
}

class Group {
  int type;
  String code;
  String name;
  String note;

  Group({
    required this.type,
    required this.code,
    required this.name,
    required this.note,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
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
