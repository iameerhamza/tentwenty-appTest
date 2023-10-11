import 'package:flutter/material.dart';
import 'package:mobile_app/Models/GenresResponseModel/genresResponseModel.dart';
import 'package:mobile_app/Models/UpcomingMoviesModel/searchedMoviesResponseModel.dart';
import 'package:mobile_app/Screens/HomeScreen/genresGridView.dart';
import 'package:mobile_app/Screens/SearchedMoviesPage/searchedMoviesPage.dart';
import 'package:mobile_app/Services/GenreAndImageService/genreAndImageService.dart';
import 'package:mobile_app/Services/SearchMovieServices/searchMovieService.dart';

import '../../Services/API/api_response.dart';
import '../../Widgets/appLoader.dart';

class MoviesSearchView extends StatefulWidget {
  final String? query;
  const MoviesSearchView({super.key, this.query});

  @override
  State<MoviesSearchView> createState() => _MoviesSearchViewState();
}

class _MoviesSearchViewState extends State<MoviesSearchView> {
  Future<ApiResponse<GenresResponseModel>>? getGenres;
  Future<ApiResponse<SearchedMoviesResponseModel>>? _search;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGenres = GenreAndImageService().getGenres(context);
    _search = SearchMovieService().searchMovie(context, widget.query!);
  }


  @override
  void didUpdateWidget(covariant MoviesSearchView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(oldWidget.query != widget.query){
      _search = SearchMovieService().searchMovie(context, widget.query!);
    }
  }


  @override
  Widget build(BuildContext context) {
    return widget.query!.isEmpty ? FutureBuilder<ApiResponse<GenresResponseModel>>(
        future: getGenres,
        builder: (context, AsyncSnapshot<ApiResponse<GenresResponseModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: AppLoader());
          } else{
            return GenresGridView();
          }
        }): FutureBuilder<ApiResponse<SearchedMoviesResponseModel>>(
        future: _search,
        builder: (context, AsyncSnapshot<ApiResponse<SearchedMoviesResponseModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: AppLoader());
          } else{
            return SearchedMoviesPage();
          }
        });
  }
}
