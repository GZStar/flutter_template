import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/modules/travel/views/travel_item_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loading_container.dart';
import '../controllers/travel_page_controller.dart';

class TravelTabPageContainer extends StatefulWidget {
  final String travelUrl;
  final Map params;
  final String groupChannelCode;
  final String? tag;

  const TravelTabPageContainer({
    Key? key,
    required this.travelUrl,
    required this.params,
    required this.groupChannelCode,
    this.tag,
  }) : super(key: key);

  @override
  TravelTabPageContainerState createState() => TravelTabPageContainerState();
}

class TravelTabPageContainerState extends State<TravelTabPageContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Get.put(
      TravelPageController(
          travelUrl: widget.travelUrl,
          params: widget.params,
          groupChannelCode: widget.groupChannelCode,
          tag: widget.tag),
      tag: widget.tag ?? "",
    );
    return TravelTabPage(widget.tag);
  }

  @override
  bool get wantKeepAlive => true;
}

class TravelTabPage extends GetView<TravelPageController> {
  final String? tag;

  const TravelTabPage(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    print('travel page tag = {$tag}');
    return GetBuilder<TravelPageController>(
        tag: tag,
        builder: (controller) {
          return Scaffold(
            body: LoadingContainer(
              isLoading: controller.loading.value,
              child: RefreshIndicator(
                onRefresh: controller.handleRefresh,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: MasonryGridView.count(
                    controller: controller.scrollController,
                    crossAxisCount: 2,
                    itemCount: controller.travelItems.length,
                    itemBuilder: (BuildContext context, int index) =>
                        TravelItemView(
                      item: controller.travelItems[index],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
