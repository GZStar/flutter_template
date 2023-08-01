// To parse this JSON data, do
//
//     final travelModel = travelModelFromJson(jsonString);

import 'dart:convert';

TravelModel travelModelFromJson(String str) =>
    TravelModel.fromJson(json.decode(str));

String travelModelToJson(TravelModel data) => json.encode(data.toJson());

class TravelModel {
  int totalCount;
  ResultList resultList;

  TravelModel({
    required this.totalCount,
    required this.resultList,
  });

  factory TravelModel.fromJson(Map<String, dynamic> json) => TravelModel(
        totalCount: json["totalCount"],
        resultList: ResultList.fromJson(json["resultList"]),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "resultList": resultList.toJson(),
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
  String articleType;
  int productType;
  int sourceType;
  String articleTitle;
  Author author;
  Images images;
  Urls urls;
  int hasVideo;
  int readCount;
  int likeCount;
  int commentCount;
  String publishTime;
  String publishTimeDisplay;
  String shootTime;
  String shootTimeDisplay;
  int level;
  String distanceText;
  String isLike;
  int imageCounts;
  String isCollected;
  int collectCount;
  int articleStatus;
  String poiName;

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
        images: Images.fromJson(json["images"]),
        urls: Urls.fromJson(json["urls"]),
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
        "images": images.toJson(),
        "urls": urls.toJson(),
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
  int authorId;
  String nickName;
  String clientAuth;
  String jumpUrl;
  CoverImage coverImage;
  int identityType;
  String tag;

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
  String originalUrl;

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
  int imageId;
  String dynamicUrl;
  String originalUrl;
  int mediaType;
  int isWaterMarked;

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

class Urls {
  String version;
  String appUrl;
  String h5Url;
  String wxUrl;

  Urls({
    required this.version,
    required this.appUrl,
    required this.h5Url,
    required this.wxUrl,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
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
