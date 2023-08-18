import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/modules/travel/views/travel_item_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../common/widgets/loading_container.dart';
import '../../../common/widgets/toast.dart';
import '../../../data/apis/travel.dart';
import '../../../data/model/trave_model.dart';
import '../../../data/network/error_handle.dart';

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final Map params;
  final String groupChannelCode;

  const TravelTabPage({
    Key? key,
    required this.travelUrl,
    required this.params,
    required this.groupChannelCode,
  }) : super(key: key);

  @override
  TravelTabPageState createState() => TravelTabPageState();
}

class TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = ScrollController();

  List<ResultList> travelItems = [];
  int pageIndex = 1;
  var loading = true;

  // 缓存页面
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadData(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('travel page build');
    super.build(context); // 必须调用
    return Scaffold(
      body: LoadingContainer(
        isLoading: loading,
        child: RefreshIndicator(
          onRefresh: handleRefresh,
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: MasonryGridView.count(
              controller: scrollController,
              crossAxisCount: 2,
              itemCount: travelItems.length,
              itemBuilder: (BuildContext context, int index) => TravelItemView(
                item: travelItems[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }

    try {
      TravelModel travelModel = await TravelAPI.fetchTravelList(
          widget.travelUrl, widget.params, widget.groupChannelCode, pageIndex);

      if (mounted) {
        setState(() {
          if (loadMore) {
            var tempList = travelModel.resultList;
            travelItems.addAll(tempList);
          } else {
            var tempList = travelModel.resultList;
            travelItems.clear();
            travelItems.addAll(tempList);
          }
        });
      }

      loading = false;
    } on NetError catch (e) {
      loading = false;
      showWarnToast(e.msg);
    } catch (e) {
      print('other');
    }
  }

  Future<void> handleRefresh() async {
    loadData();
    return;
  }
}
