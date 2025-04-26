import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_state.dart';
import 'package:ditonton/presentation/widgets/media_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-tv';

  @override
  _OnAirTvPagePageState createState() => _OnAirTvPagePageState();
}

class _OnAirTvPagePageState extends State<OnAirTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvOnAirBloc>().add(FetchTvOnAir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ON AIR TV SHOWS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvOnAirBloc, TvOnAirState>(
          builder: (context, state) {
            if (state is TvOnAirLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvOnAirHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvs[index];
                  return MediaCardList(item: tv);
                },
                itemCount: state.tvs.length,
              );
            } else if (state is TvOnAirError) {
              return Center(
                  child: Text(key: Key('error_message'), state.message));
            } else {
              return Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
