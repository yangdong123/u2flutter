import 'package:flutter/material.dart';
import '../../utils/store.dart';
import 'LoadingPageState.dart';
import '../widgets/VideoGridWidget.dart';
import '../../api/index.dart';

class SearchPageDelegate extends SearchDelegate<Map> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {})];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: IconButton(
            icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        )),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    var q = query;
    if (q.isEmpty) {
      query = "";
      return Container();
    }
    addQueryHistory(q);
    return ResultPage(q);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SuggestionPage(query, (q) {
      query = q;
      showResults(context);
    }, (q) {
      query = q;
    });
  }
}

class SuggestionPage extends StatelessWidget {
  final String query;
  final Function onShowResult;
  final Function onQuery;

  SuggestionPage(this.query, this.onShowResult, this.onQuery);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (c, snap) {
      return Container(
        color: Colors.grey,
      );
    });
  }
}

class ResultPage extends StatefulWidget {
  final String query;

  ResultPage(this.query);

  @override
  State createState() => ResultPageState();
}

class ResultPageState extends LoadingPageState<ResultPage> {
  @override
  Future<List> fetchData(int page)async {
      var res = await Api.search(q:widget.query);
      return res["items"];
  }

  @override
  Widget buildItem(BuildContext context, int index, dynamic item) {
    print(item);
    return buildIndexVideoItem(context,item);
  }

  Widget tagText(String s) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Chip(
//      labelPadding: EdgeInsets.all(2),
//      padding: EdgeInsets.all(5),
        label: Text(s),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

final String store_key = "query_history";

addQueryHistory(String q) {
  Set qSet = Set<String>();
  qSet.add(q);
  qSet.addAll(getQueryHistory());
  Store.set(store_key, qSet);
}

delQueryHistory(String q) {
  var data = getQueryHistory();
  data.remove(q);
  Store.set(store_key, data);
}

clearQueryHistory() {
  Store.remove(store_key);
}

Set<String> getQueryHistory() {
  var v = Store.get(store_key);
  if (v is Set) {
    return v;
  }
  return Set<String>();
}