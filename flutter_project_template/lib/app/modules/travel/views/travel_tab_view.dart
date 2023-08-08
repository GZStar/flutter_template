import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/modules/travel/views/travel_item_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

import '../../../common/widgets/loading_container.dart';
import '../controllers/travel_page_controller.dart';

class TravelPageView extends GetView<TravelPageController> {
  final String? travelUrl;
  final Map? params;
  final String groupChannelCode;

  const TravelPageView(
      {Key? key, this.travelUrl, this.params, required this.groupChannelCode})
      : super(key: key);

  Future<void> handleRefresh() async {
    controller.loadData(travelUrl, groupChannelCode, params);
    return;
  }

  @override
  Widget build(BuildContext context) {
    final pageController = Get.put(TravelPageController());

    pageController.travelUrl = travelUrl;
    pageController.params = params;
    pageController.groupChannelCode = groupChannelCode;

    print('222222222222222');
    print(pageController.travelUrl);

    return Scaffold(
      body: Obx(() => LoadingContainer(
            isLoading: controller.loading.value,
            child: RefreshIndicator(
              onRefresh: handleRefresh,
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: MasonryGridView.count(
                          crossAxisCount: 2,
                          itemCount: controller.travelItems.length,
                          itemBuilder: (BuildContext context, int index) =>
                              TravelItemView(
                            item: controller.travelItems[index],
                          ),
                        ),
                      ),
                      // _loadMoreIndicator(_loadMore),
                    ],
                  )),
            ),
          )),
    );
  }
}
