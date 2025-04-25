import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_on_air_notifier.dart';
import 'package:ditonton/presentation/widgets/media_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-tv';

  @override
  _OnAirTvPagePageState createState() => _OnAirTvPagePageState();
}

class _OnAirTvPagePageState extends State<OnAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvOnAirNotifier>(context, listen: false).fetchOnAirTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ON AIR TV SHOWS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvOnAirNotifier>(
          builder: (context, data, child) {
            if (data.onAirTvState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.onAirTvState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.onAirTv[index];
                  return MediaCardList(item: tv);
                },
                itemCount: data.onAirTv.length,
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
