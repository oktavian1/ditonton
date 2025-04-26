import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_state.dart';
import 'package:ditonton/presentation/widgets/media_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvsPageState createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<PopularTvsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvPopularBloc>().add(FetchTvPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV SHOWS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          builder: (context, state) {
            if (state is TvPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvs[index];
                  return MediaCardList(item: tv);
                },
                itemCount: state.tvs.length,
              );
            } else if (state is TvPopularError) {
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
