import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/config/config.dart';
import 'package:gsy_github_app_flutter/widget/gsy_pull_new_load_widget.dart';

/**
 * Created by guoshuyu
 * on 2019/3/23.
 */
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

abstract class BlocListBase extends BlocBase {

  int _page = 1;

  final GSYPullLoadWidgetControl pullLoadWidgetControl = new GSYPullLoadWidgetControl();

  @mustCallSuper
  @override
  void dispose() {
    pullLoadWidgetControl.dispose();
  }

  @protected
  pageReset() {
    _page = 1;
  }

  @protected
  pageUp() {
    _page++;
  }

  @protected
  getLoadMoreStatus(res) {
    return (res != null && res.data != null && res.data.length == Config.PAGE_SIZE);
  }

  int get page => _page;


  ///列表数据长度
  int getDataLength() {
    return pullLoadWidgetControl.dataList.length;
  }

  ///修改加载更多
  changeLoadMoreStatus(bool needLoadMore) {
    pullLoadWidgetControl.needLoadMore = needLoadMore;
  }

  ///是否需要头部
  changeNeedHeaderStatus(bool needHeader) {
    pullLoadWidgetControl.needHeader = needHeader;
  }

  ///列表数据
  get dataList => pullLoadWidgetControl.dataList;

  ///刷新列表数据
  refreshData(List listData) {
    if (pullLoadWidgetControl.dataList != null) {
      pullLoadWidgetControl.dataList = listData;
    }
  }

  ///加载更多数据
  loadMoreData(List listData) {
    if (listData != null) {
      pullLoadWidgetControl.addList(listData);
    }
  }

  ///清理数据
  clearData() {
    refreshData([]);
  }
}

abstract class BlocBase {
  void dispose();
}