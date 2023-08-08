// To parse this JSON data, do
//
//     final travelModel = travelModelFromJson(jsonString);

import 'dart:convert';

TravelModel travelModelFromJson(String str) =>
    TravelModel.fromJson(json.decode(str));

String travelModelToJson(TravelModel data) => json.encode(data.toJson());

class TravelModel {
  int totalCount;
  List<ResultList> resultList;

  TravelModel({
    required this.totalCount,
    required this.resultList,
  });

  factory TravelModel.fromJson(Map<String, dynamic> json) => TravelModel(
        totalCount: json["totalCount"],
        resultList: List<ResultList>.from(
            json["resultList"].map((x) => ResultList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "resultList": List<dynamic>.from(resultList.map((x) => x.toJson())),
      };
}

class ResultList {
  int type;
  Article article;

  ResultList({
    required this.type,
    required this.article,
  });

  factory ResultList.fromJson(Map<String, dynamic> json) => ResultList(
        type: json["type"],
        article: Article.fromJson(json["article"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "article": article.toJson(),
      };
}

class Article {
  int articleId;
  String? articleType;
  int productType;
  int? sourceType;
  String articleTitle;
  Author author;
  List<Images> images;
  List<Url> urls;
  bool hasVideo;
  int? readCount;
  int? likeCount;
  int? commentCount;
  String? publishTime;
  String? publishTimeDisplay;
  String? shootTime;
  String? shootTimeDisplay;
  int? level;
  String? distanceText;
  bool isLike;
  int? imageCounts;
  bool isCollected;
  int? collectCount;
  int? articleStatus;
  String? poiName;

  Article({
    required this.articleId,
    required this.articleType,
    required this.productType,
    required this.sourceType,
    required this.articleTitle,
    required this.author,
    required this.images,
    required this.urls,
    required this.hasVideo,
    required this.readCount,
    required this.likeCount,
    required this.commentCount,
    required this.publishTime,
    required this.publishTimeDisplay,
    required this.shootTime,
    required this.shootTimeDisplay,
    required this.level,
    required this.distanceText,
    required this.isLike,
    required this.imageCounts,
    required this.isCollected,
    required this.collectCount,
    required this.articleStatus,
    required this.poiName,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        articleId: json["articleId"],
        articleType: json["articleType"],
        productType: json["productType"],
        sourceType: json["sourceType"],
        articleTitle: json["articleTitle"],
        author: Author.fromJson(json["author"]),
        images:
            List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
        hasVideo: json["hasVideo"],
        readCount: json["readCount"],
        likeCount: json["likeCount"],
        commentCount: json["commentCount"],
        publishTime: json["publishTime"],
        publishTimeDisplay: json["publishTimeDisplay"],
        shootTime: json["shootTime"],
        shootTimeDisplay: json["shootTimeDisplay"],
        level: json["level"],
        distanceText: json["distanceText"],
        isLike: json["isLike"],
        imageCounts: json["imageCounts"],
        isCollected: json["isCollected"],
        collectCount: json["collectCount"],
        articleStatus: json["articleStatus"],
        poiName: json["poiName"],
      );

  Map<String, dynamic> toJson() => {
        "articleId": articleId,
        "articleType": articleType,
        "productType": productType,
        "sourceType": sourceType,
        "articleTitle": articleTitle,
        "author": author.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
        "hasVideo": hasVideo,
        "readCount": readCount,
        "likeCount": likeCount,
        "commentCount": commentCount,
        "publishTime": publishTime,
        "publishTimeDisplay": publishTimeDisplay,
        "shootTime": shootTime,
        "shootTimeDisplay": shootTimeDisplay,
        "level": level,
        "distanceText": distanceText,
        "isLike": isLike,
        "imageCounts": imageCounts,
        "isCollected": isCollected,
        "collectCount": collectCount,
        "articleStatus": articleStatus,
        "poiName": poiName,
      };
}

class Author {
  int? authorId;
  String nickName;
  String clientAuth;
  String jumpUrl;
  CoverImage coverImage;
  int identityType;
  String? tag;

  Author({
    required this.authorId,
    required this.nickName,
    required this.clientAuth,
    required this.jumpUrl,
    required this.coverImage,
    required this.identityType,
    required this.tag,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        authorId: json["authorId"],
        nickName: json["nickName"],
        clientAuth: json["clientAuth"],
        jumpUrl: json["jumpUrl"],
        coverImage: CoverImage.fromJson(json["coverImage"]),
        identityType: json["identityType"],
        tag: json["tag"],
      );

  Map<String, dynamic> toJson() => {
        "authorId": authorId,
        "nickName": nickName,
        "clientAuth": clientAuth,
        "jumpUrl": jumpUrl,
        "coverImage": coverImage.toJson(),
        "identityType": identityType,
        "tag": tag,
      };
}

class CoverImage {
  String dynamicUrl;
  String? originalUrl;

  CoverImage({
    required this.dynamicUrl,
    required this.originalUrl,
  });

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        dynamicUrl: json["dynamicUrl"],
        originalUrl: json["originalUrl"],
      );

  Map<String, dynamic> toJson() => {
        "dynamicUrl": dynamicUrl,
        "originalUrl": originalUrl,
      };
}

class Images {
  int? imageId;
  String dynamicUrl;
  String originalUrl;
  int? mediaType;
  int? isWaterMarked;

  Images({
    required this.imageId,
    required this.dynamicUrl,
    required this.originalUrl,
    required this.mediaType,
    required this.isWaterMarked,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        imageId: json["imageId"],
        dynamicUrl: json["dynamicUrl"],
        originalUrl: json["originalUrl"],
        mediaType: json["mediaType"],
        isWaterMarked: json["isWaterMarked"],
      );

  Map<String, dynamic> toJson() => {
        "imageId": imageId,
        "dynamicUrl": dynamicUrl,
        "originalUrl": originalUrl,
        "mediaType": mediaType,
        "isWaterMarked": isWaterMarked,
      };
}

class Pois {
  int? poiType;
  int? poiId;
  String poiName;
  int? districtId;
  String? districtName;
  int? source;
  int? isMain;
  bool? isInChina;
  PoiExt poiExt;

  Pois({
    required this.poiType,
    required this.poiId,
    required this.poiName,
    required this.districtId,
    required this.districtName,
    required this.source,
    required this.isMain,
    required this.isInChina,
    required this.poiExt,
  });

  factory Pois.fromJson(Map<String, dynamic> json) => Pois(
        poiType: json["poiType"],
        poiId: json["poiId"],
        poiName: json["poiName"],
        districtId: json["districtId"],
        districtName: json["districtName"],
        source: json["source"],
        isMain: json["isMain"],
        isInChina: json["isInChina"],
        poiExt: PoiExt.fromJson(json["poiExt"]),
      );

  Map<String, dynamic> toJson() => {
        "poiType": poiType,
        "poiId": poiId,
        "poiName": poiName,
        "districtId": districtId,
        "districtName": districtName,
        "source": source,
        "isMain": isMain,
        "isInChina": isInChina,
        "poiExt": poiExt.toJson(),
      };
}

class PoiExt {
  String h5Url;
  String appUrl;

  PoiExt({
    required this.h5Url,
    required this.appUrl,
  });

  factory PoiExt.fromJson(Map<String, dynamic> json) => PoiExt(
        h5Url: json["h5Url"],
        appUrl: json["appUrl"],
      );

  Map<String, dynamic> toJson() => {
        "h5Url": h5Url,
        "appUrl": appUrl,
      };
}

class Topic {
  int topicId;
  String topicName;
  String level;

  Topic({
    required this.topicId,
    required this.topicName,
    required this.level,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        topicId: json["topicId"],
        topicName: json["topicName"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "topicId": topicId,
        "topicName": topicName,
        "level": level,
      };
}

class Url {
  String version;
  String? appUrl;
  String? h5Url;
  String? wxUrl;

  Url({
    required this.version,
    required this.appUrl,
    required this.h5Url,
    required this.wxUrl,
  });

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        version: json["version"],
        appUrl: json["appUrl"],
        h5Url: json["h5Url"],
        wxUrl: json["wxUrl"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "appUrl": appUrl,
        "h5Url": h5Url,
        "wxUrl": wxUrl,
      };
}
