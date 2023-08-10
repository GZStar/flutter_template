import 'dart:async';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const MAX_COUNT = 0x7fffffff;

///
/// Item的点击事件
///
// typedef void OnBannerItemClick(int position, BannerItem entity, type);
typedef OnBannerItemClick = void Function(
    int position, BannerItem entity, String type);

typedef OnPageChangedBlock = void Function(int position);

///
/// 自定义ViewPager的每个页面显示
///
typedef CustomBuild = Widget Function(int position, BannerItem entity);
// typedef Widget CustomBuild(int position, BannerItem entity);

// ignore: must_be_immutable
class BannerWidget extends StatefulWidget {
  final double height;
  final List<BannerItem> datas;
  int duration;
  double pointRadius;
  Color selectedColor;
  Color unSelectedColor;
  Color textBackgroundColor;
  bool isHorizontal;
  bool isAutoScroll;
  bool isCycle; // isAutoScoll 为true时 isCycle也必须为true
  bool isShowCircle;

  OnBannerItemClick? bannerPress;
  CustomBuild? build;
  OnPageChangedBlock? pageChanged;

  BannerWidget(this.height, this.datas,
      {Key? key,
      this.duration = 3000,
      this.pointRadius = 3.0,
      this.selectedColor = Colors.white,
      this.unSelectedColor = Colors.white54,
      this.textBackgroundColor = const Color(0x33000000),
      this.isHorizontal = true,
      this.isAutoScroll = true,
      this.isCycle = true,
      this.isShowCircle = true,
      this.bannerPress,
      this.build,
      this.pageChanged})
      : super(key: key);

  @override
  BannerState createState() {
    return BannerState();
  }
}

class BannerState extends State<BannerWidget>
    with AutomaticKeepAliveClientMixin {
  Timer? timer;
  int selectedIndex = 0;
  late PageController controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // isAutoScoll 为true时 isCycle也必须为true
    widget.isCycle = widget.isAutoScroll ? true : widget.isCycle;

    double current = widget.datas.isNotEmpty
        ? (MAX_COUNT / 2) - ((MAX_COUNT / 2) % widget.datas.length)
        : 0.0;

    var startPage = 0;
    if (widget.isCycle) {
      startPage = current.toInt();
    }
    controller = PageController(initialPage: startPage);

    _initPageAutoScroll();
    super.initState();
  }

  _initPageAutoScroll() {
    start();
  }

  @override
  void didUpdateWidget(BannerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  start() {
    if (widget.isAutoScroll) {
      stop();
      timer = Timer.periodic(Duration(milliseconds: widget.duration), (timer) {
        if (widget.datas.isNotEmpty && controller.page != null) {
          controller.animateToPage(controller.page!.toInt() + 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        }
      });
    }
  }

  stop() {
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: widget.height,
      color: Colors.black12,
      child: Stack(
        children: <Widget>[
          getViewPager(),
          Align(
            alignment: Alignment.bottomCenter,
            child: IntrinsicHeight(
              child: Container(
                child: getBannerTextInfoWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getViewPager() {
    int count = widget.isCycle
        ? (widget.datas.isNotEmpty ? MAX_COUNT : 0)
        : widget.datas.length;
    return PageView.builder(
      physics: const ClampingScrollPhysics(),
      scrollDirection: widget.isHorizontal ? Axis.horizontal : Axis.vertical,
      itemCount: count,
      controller: controller,
      onPageChanged: onPageChanged,
      allowImplicitScrolling: true,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              if (widget.bannerPress != null) {
                widget.bannerPress!(selectedIndex, widget.datas[selectedIndex],
                    widget.datas[index % widget.datas.length].type);
              }
            },
            child: widget.build == null
                ? widget.datas[index % widget.datas.length].type == 'local'
                    ? Image.asset(
                        widget.datas[index % widget.datas.length].itemImagePath,
                        fit: BoxFit.cover)
                    : Image.network(
                        widget.datas[index % widget.datas.length].itemImagePath,
                        fit: BoxFit.cover)
                : getOtherBuildWidget(index));
      },
    );
  }

  Widget getOtherBuildWidget(index) {
    return Center(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.build!(index, widget.datas[index % widget.datas.length])
      ],
    ));
  }

  Widget getSelectedIndexTextWidget() {
    return widget.datas.isNotEmpty && selectedIndex < widget.datas.length
        ? widget.datas[selectedIndex].itemText
        : const Text('');
  }

  Widget getBannerTextInfoWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.isShowCircle ? circle() : [],
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          // color: widget.textBackgroundColor,
          child: getSelectedIndexTextWidget(),
        ),
      ],
    );
  }

  List<Widget> circle() {
    List<Widget> circle = [];
    for (var i = 0; i < widget.datas.length; i++) {
      circle.add(Container(
        margin: const EdgeInsets.all(2.0),
        width: widget.pointRadius * 2,
        height: widget.pointRadius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedIndex == i
              ? widget.selectedColor
              : widget.unSelectedColor,
        ),
      ));
    }
    return circle;
  }

  onPageChanged(index) {
    selectedIndex = index % widget.datas.length;
    setState(() {});
    if (widget.pageChanged != null) {
      widget.pageChanged!(selectedIndex);
    }
  }
}

class BannerItem {
  late String itemImagePath;
  late Widget itemText;
  late String type;

  static BannerItem defaultBannerItem(
    String image,
    String text,
    String type,
  ) {
    BannerItem item = BannerItem();
    item.itemImagePath = image;
    Text textWidget = Text(
      text,
      softWrap: true,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          color: Colors.white, fontSize: 12.0, decoration: TextDecoration.none),
    );

    item.itemText = textWidget;
    item.type = type;

    return item;
  }
}
