import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_popular_notifer.dart';
import 'package:ditonton/presentation/widgets/media_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvsPageState createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<PopularTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvPopularNotifer>(context, listen: false)
        .fetchTvPopularTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV SHOWS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvPopularNotifer>(
          builder: (context, data, child) {
            if (data.popularTvState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.popularTvState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.popularTv[index];
                  return MediaCardList(item: tv);
                },
                itemCount: data.popularTv.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
