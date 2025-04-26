import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_top_rated_bloc/tv_top_rated_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_top_rated_bloc/tv_top_rated_state.dart';
import 'package:ditonton/presentation/widgets/media_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvTopRatedBloc>().add(FetchTvTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TOP RATED TV SHOWS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
          builder: (context, state) {
            if (state is TvTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvs[index];
                  return MediaCardList(item: tv);
                },
                itemCount: state.tvs.length,
              );
            } else if (state is TvTopRatedError) {
              return Center(child: Text(state.message));
            } else {
              return Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
