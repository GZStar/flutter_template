///  description:  九宫格图片展示 4图处理 加载本地和网络图片

import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'photo_browser.dart';

const double _itemSpace = 5.0;
const double _space = 5.0; // 上下左右间距

class NinePicture extends StatelessWidget {
  const NinePicture(
      {Key? key,
      this.imgData,
      this.lRSpace = 0.0,
      this.onLongPress,
      this.isHandleFour = true,
      this.isAssetImage = false})
      : super(key: key);

  final List? imgData;
  final double lRSpace; // 外部设置的左右间距
  final GestureTapCallback? onLongPress;
  final bool isHandleFour;
  final bool isAssetImage;

  @override
  Widget build(BuildContext context) {
    var kScreenWidth = MediaQuery.of(context).size.width;

    var _ninePictureW = (kScreenWidth - _space * 2 - 2 * _itemSpace - lRSpace);
    var _itemWH = _ninePictureW / 3;
    int _columnCount = imgData!.length > 6
        ? 3
        : imgData!.length <= 3
            ? 1
            : 2;
    // print('九宫格宽 $_ninePictureW ');
    // print('item宽  $_itemWH ');

    bool _isHandleFour = isHandleFour && imgData!.length == 4;

    var _bgWidth = _isHandleFour
        ? (_space * 2 + _itemSpace + _itemWH * 2)
        : (kScreenWidth - lRSpace);
    var _bgHeight =
        _columnCount * _itemWH + _space * 2 + (_columnCount - 1) * _itemSpace;
    var _crossAxisCount = _isHandleFour ? 2 : 3;
    var _childAspectRatio = 1.0;

    if (imgData!.length == 1) {
      _bgWidth = (kScreenWidth - lRSpace) * 0.55;
      _bgHeight = (kScreenWidth - lRSpace) * 0.75;
      _crossAxisCount = 1;
      _childAspectRatio = 55.0 / 76.0;
    }

    return Offstage(
      offstage: imgData!.length == 0,
      child: Container(
        width: _bgWidth,
        height: _bgHeight,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // 可以直接指定每行（列）显示多少个Item
              crossAxisCount: _crossAxisCount, // 一行的Widget数量
              crossAxisSpacing: _itemSpace, // 水平间距
              mainAxisSpacing: _itemSpace, // 垂直间距
              childAspectRatio: _childAspectRatio, // 子Widget宽高比例
            ),
            // 禁用滚动事件
            physics: NeverScrollableScrollPhysics(),
            // GridView内边距
            padding: EdgeInsets.all(_space),
            itemCount: imgData!.length,
            itemBuilder: (context, index) {
              return _itemCell(context, index);
            }),
      ),
    );
  }

  _itemCell(context, index) {
    Widget? _picture;
    if (isAssetImage) {
      _picture = Image(
          image: AssetEntityImageProvider(imgData![index]), fit: BoxFit.cover);
    } else {
      var _img = imgData![index];
      _picture = _img.startsWith('http')
          ? Image.network(_img, fit: BoxFit.cover)
          : Image.asset(_img, fit: BoxFit.cover);
    }

    return GestureDetector(
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _picture,
      ),
      onTap: () => _clickItemCell(context, index),
    );
  }

  /// 点击cell，展示全图
  _clickItemCell(context, index) {
    // FadeRoute是自定义的切换过度动画（渐隐渐现） 如果不需要 可以使用默认的MaterialPageRoute
    Navigator.of(context).push(FadeRoute(
      page: PhotoBrowser(
        imgDataArr: imgData!,
        index: index,
        isAssetImage: isAssetImage,
        onLongPress: onLongPress!,
      ),
    ));
  }
}
