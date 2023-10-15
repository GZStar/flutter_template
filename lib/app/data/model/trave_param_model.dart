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
  List<TravelTab> tabs;

  TravelParamsModel({
    required this.params,
    required this.url,
    required this.tabs,
  });

  factory TravelParamsModel.fromJson(Map<String, dynamic> json) =>
      TravelParamsModel(
        url: json["url"],
        params: json['params'],
        tabs: List<TravelTab>.from(
            json["tabs"].map((x) => TravelTab.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "tabs": List<dynamic>.from(tabs.map((x) => x.toJson())),
      };
}

class TravelTab {
  String labelName;
  String groupChannelCode;

  TravelTab({
    required this.labelName,
    required this.groupChannelCode,
  });

  factory TravelTab.fromJson(Map<String, dynamic> json) => TravelTab(
        labelName: json["labelName"],
        groupChannelCode: json["groupChannelCode"],
      );

  Map<String, dynamic> toJson() => {
        "labelName": labelName,
        "groupChannelCode": groupChannelCode,
      };
}
