import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/modules/travel/controllers/travel_controller.dart';

import 'package:get/get.dart';

import '../../../common/widgets/loading_container.dart';

class TravelTabView extends GetView<TravelController> {
  final String travelUrl;
  final Map params;
  final String groupChannelCode;

  const TravelTabView(
      {Key? key,
      required this.travelUrl,
      required this.params,
      required this.groupChannelCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: controller.loading.value,
        child: RefreshIndicator(
          onRefresh: controller.handleRefresh,
          child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: StaggeredGridView.countBuilder(
                      controller: _scrollController,
                      crossAxisCount: 4,
                      itemCount: travelItems?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) =>
                          _TravelItem(
                        index: index,
                        item: travelItems[index],
                      ),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(2),
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                    ),
                  ),
                  _loadMoreIndicator(_loadMore),
                ],
              )),
        ),
      ),
    );
  }
}
