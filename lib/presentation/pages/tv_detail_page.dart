import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/tv_detail_view.dart'; // kamu bisa pisahkan UI-nya

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-detail';
  final int id;

  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    print('ini string ${widget.id}');
    super.initState();
    Future.microtask(() => Provider.of<TvDetailNotifier>(context, listen: false)
        .fetchTvDetail(widget.id));
    Future.microtask(() => Provider.of<TvDetailNotifier>(context, listen: false)
        .loadWatchlistStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, data, child) {
          final state = data.tvState;
          if (state == RequestState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state == RequestState.Loaded) {
            return TvDetailView(tv: data.tv); // pisahkan ke widget biar clean
          } else if (state == RequestState.Error) {
            return Center(child: Text(data.message));
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
