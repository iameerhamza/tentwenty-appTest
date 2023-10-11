import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/MoviesListProvider/moviesListProvider.dart';
import '../../Widgets/movieItemCard.dart';
import '../MovieDetailPage/movieDetailPage.dart';

class MoviesListView extends StatefulWidget {
  const MoviesListView({super.key});

  @override
  State<MoviesListView> createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesListProvider>(builder: (context, moviesListProvider, child) {
      var moviesList = moviesListProvider.upcomingMoviesModel?.results;
      return ListView.builder(
          itemCount: moviesList?.length ?? 0,
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            return MovieItemCard(
              imageUrl: moviesList?[index].posterPath,
              title: moviesList?[index].title,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return MovieDetailPage(
                    movieId: moviesList?[index].id.toString(),
                  );
                }));
              },
            );
          });
    });
  }
}
