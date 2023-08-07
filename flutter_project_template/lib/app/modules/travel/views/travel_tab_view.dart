import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/modules/travel/controllers/travel_controller.dart';
import 'package:flutter_project_template/app/modules/travel/views/travel_item_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

import '../../../common/widgets/loading_container.dart';

class TravelTabView extends GetView<TravelController> {
  final String? travelUrl;
  final Map? params;
  final String groupChannelCode;

  const TravelTabView(
      {Key? key, this.travelUrl, this.params, required this.groupChannelCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => LoadingContainer(
            isLoading: controller.loading.value,
            child: RefreshIndicator(
              onRefresh: controller.handleRefresh,
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
