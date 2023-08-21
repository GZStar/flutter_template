import 'dart:math' as math;

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/widgets/toast.dart';
import 'package:flutter_project_template/app/routes/mine_routes.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({Key? key}) : super(key: key);

  static const _imgHeight = 80.0;
  static const _expandedHeight = 120.0;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: EasyRefresh(
        header: BuilderHeader(
          clamping: false,
          position: IndicatorPosition.locator,
          triggerOffset: 100000,
          notifyWhenInvisible: true,
          builder: (context, state) {
            const expandedExtent = _expandedHeight - kToolbarHeight;
            final pixels = state.notifier.position.pixels;
            final height = state.offset + _imgHeight;
            final clipEndHeight = pixels < expandedExtent
                ? _imgHeight
                : math.max(0.0, _imgHeight - pixels + expandedExtent);
            final imgHeight = pixels < expandedExtent
                ? _imgHeight
                : math.max(0.0, _imgHeight - (pixels - expandedExtent));
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: _TrapezoidClipper(
                    height: height,
                    clipStartHeight: 0.0,
                    clipEndHeight: clipEndHeight,
                  ),
                  child: Container(
                    height: height,
                    width: double.infinity,
                    color: themeData.colorScheme.primary,
                  ),
                ),
                Positioned(
                  top: -1,
                  left: 0,
                  right: 0,
                  child: ClipPath(
                    clipper: _FillLineClipper(imgHeight),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: themeData.colorScheme.primary,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/other/lufei.png',
                      height: imgHeight,
                      width: imgHeight,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        onRefresh: () {},
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: themeData.colorScheme.primary,
              foregroundColor: themeData.colorScheme.onPrimary,
              expandedHeight: _expandedHeight,
              pinned: true,
              leading: BackButton(
                color: themeData.colorScheme.onPrimary,
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  '路飞',
                  style: TextStyle(color: themeData.colorScheme.onPrimary),
                ),
                centerTitle: true,
              ),
            ),
            const HeaderLocator.sliver(paintExtent: 80),
            SliverToBoxAdapter(
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Align(
                          widthFactor: 1.0,
                          alignment: Alignment.center,
                          child: Icon(Icons.qr_code)),
                      title: Text('我的二维码'.tr),
                      // subtitle: const Text('123456'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      onTap: () {
                        Get.toNamed(MineRoutes.userQrCode);
                      },
                    ),
                    ListTile(
                      leading: const Align(
                          widthFactor: 1.0,
                          alignment: Alignment.center,
                          child: Icon(Icons.language)),
                      title: const Text('Github'),
                      subtitle: const Text('https://github.com/flutter'),
                      onTap: () {
                        launchUrl(Uri.parse('https://github.com/flutter'));
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Align(
                          widthFactor: 1.0,
                          alignment: Alignment.center,
                          child: Icon(Icons.person)),
                      title: Text('Name'.tr),
                      subtitle: const Text('Lufei'),
                    ),
                    ListTile(
                      leading: const Align(
                          widthFactor: 1.0,
                          alignment: Alignment.center,
                          child: Icon(Icons.face)),
                      title: Text('Age'.tr),
                      subtitle: Text('22'.tr),
                    ),
                    ListTile(
                      leading: const Align(
                          widthFactor: 1.0,
                          alignment: Alignment.center,
                          child: Icon(Icons.location_city)),
                      title: Text('City'.tr),
                      subtitle: Text('China - Shenzhen'.tr),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Align(
                          widthFactor: 1.0,
                          alignment: Alignment.center,
                          child: Icon(Icons.phone)),
                      title: Text('Phone'.tr),
                      subtitle: const Text('188888888888'),
                    ),
                    ListTile(
                      leading: const Align(
                          widthFactor: 1.0,
                          alignment: Alignment.center,
                          child: Icon(Icons.email)),
                      title: Text('Mail'.tr),
                      subtitle: const Text('lufei@qq.com'),
                      onTap: () {
                        launchUrl(Uri.parse(
                            'mailto:lufei@foxmail.com?subject=HelloWorld&body=I found a bug'));
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverList.list(children: const [
              SizedBox(
                height: 90,
              )
            ]),
          ],
        ),
      ),
    );
  }
}

class _TrapezoidClipper extends CustomClipper<Path> {
  final double height;
  final double clipStartHeight;
  final double clipEndHeight;

  _TrapezoidClipper({
    required this.height,
    required this.clipStartHeight,
    required this.clipEndHeight,
  });

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height - clipEndHeight);
    path.lineTo(0, height - clipStartHeight);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_TrapezoidClipper oldClipper) {
    return oldClipper.height != height ||
        oldClipper.clipStartHeight != clipStartHeight ||
        oldClipper.clipEndHeight != clipEndHeight;
  }
}

class _FillLineClipper extends CustomClipper<Path> {
  final double imgHeight;

  _FillLineClipper(this.imgHeight);

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height / 2);
    path.lineTo(0, height / 2 + imgHeight / 2);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _FillLineClipper oldClipper) {
    return oldClipper.imgHeight != imgHeight;
  }
}
