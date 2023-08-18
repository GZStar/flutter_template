import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/trave_model.dart';
import '../../../routes/main_routes.dart';

class TravelItemView extends StatelessWidget {
  final ResultList item;

  const TravelItemView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.article.urls.length > 1) {
          var dic = item.article.urls[1];
          print('on travel item h5Url click ${dic.h5Url}');
          print('on travel item wxUrl click ${dic.wxUrl}');

          print('on travel item appUrl click ${dic.appUrl}');
          Get.toNamed(MainRoutes.webBrowser, arguments: {'url': dic.h5Url});
          // launchUrl(Uri.parse(dic.h5Url.toString()));
        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _itemImage(context),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.article.articleTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText()
            ],
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    return Stack(
      children: <Widget>[
        FadeInImage.assetNetwork(
            placeholder: "assets/images/swiper/swiper_gif5.gif",
            image: item.article.images[0].dynamicUrl),
        // Image.network(item.article.images[0].dynamicUrl),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: <Widget>[
                  const Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 12,
                      )),
                  LimitedBox(
                    maxWidth: MediaQuery.of(context).size.width / 2 - 66,
                    child: Text(
                      _poiName(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  String _poiName() {
    return item.article.pois == null ? '未知' : item.article.pois![0].poiName;
  }

  _infoText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article.author.coverImage.dynamicUrl,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 80,
                child: Text(
                  item.article.author.nickName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              const Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  item.article.likeCount.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
