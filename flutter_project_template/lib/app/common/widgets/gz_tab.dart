import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///chat页面表情tab切换
class EmojiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;

  const EmojiTab({
    Key? key,
    required this.tabs,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SizedBox(
      height: 96.h,
      child: TabBar(
          controller: controller,
          isScrollable: true,
          labelColor: themeData.colorScheme.primary,
          unselectedLabelColor: themeData.scaffoldBackgroundColor,
          unselectedLabelStyle:
              TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w500),
          labelStyle: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.w800),
          tabs: tabs),
    );
  }
}
