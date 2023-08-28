import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../utils/screen_utils.dart';

const Color _selColor = Colors.white;
const Color _otherColor = Colors.grey;

class PhotoBrowser extends StatefulWidget {
  const PhotoBrowser({
    Key? key,
    required this.imgDataArr,
    this.index = 0,
    this.onLongPress,
    this.controller,
    this.heroTag,
    this.isHiddenClose = false,
    this.isHiddenTitle = false,
    this.isAssetImage = false,
  }) : super(key: key);

  final List imgDataArr;
  final int index;
  final String? heroTag;
  final PageController? controller;
  final GestureTapCallback? onLongPress;
  final bool isHiddenClose;
  final bool isHiddenTitle;
  final bool isAssetImage;

  @override
  PhotoBrowserState createState() => PhotoBrowserState();
}

class PhotoBrowserState extends State<PhotoBrowser> {
  int _currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = widget.index;
    _controller =
        widget.controller ?? PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
              color: Colors.black,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                onLongPress: () {
                  if (widget.onLongPress != null) {
                    widget.onLongPress!();
                  }
                },
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    ImageProvider _picture;
                    if (widget.isAssetImage) {
                      var asset = widget.imgDataArr[index];
                      _picture = AssetEntityImageProvider(asset);
                    } else {
                      var _imgURL = widget.imgDataArr[index];
                      if (_imgURL.startsWith('http')) {
                        _picture = NetworkImage(_imgURL);
                      } else {
                        _picture = AssetImage(_imgURL);
                      }
                    }

                    return PhotoViewGalleryPageOptions(
                      imageProvider: _picture,
                      heroAttributes: widget.heroTag != null
                          ? PhotoViewHeroAttributes(tag: widget.heroTag!)
                          : null,
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    );
                  },
                  itemCount: widget.imgDataArr.length,
                  // loadingChild: Container(),
                  backgroundDecoration: null,
                  pageController: _controller,
                  enableRotation: false,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              )),
        ),
        Positioned(
          top: ScreenUtils.topSafeHeight + 20,
          left: 0,
          right: 0,
          height: 30,
          child: Offstage(
            offstage: widget.imgDataArr.length == 1 || widget.isHiddenTitle,
            child: Center(
              child: Text('${_currentIndex + 1}/${widget.imgDataArr.length}',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ),
        Positioned(
          top: ScreenUtils.topSafeHeight + 20,
          left: 15,
          height: 30,
          child: Offstage(
            offstage: widget.isHiddenClose,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: const Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: widget.imgDataArr.length == 1 ? 0 : 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imgDataArr.length,
                  (i) => GestureDetector(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.5),
                        child: CircleAvatar(
//                      foregroundColor: Theme.of(context).primaryColor,
                          radius: 3.5,
                          backgroundColor:
                              _currentIndex == i ? _selColor : _otherColor,
                        )),
                  ),
                ).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget? page;

  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
