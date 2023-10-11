import 'package:flutter/material.dart';
import 'package:mobile_app/Models/GenresResponseModel/genresResponseModel.dart';
import 'package:mobile_app/Models/MovieDetailResponseModel/movieDetailResponseModel.dart';
import 'package:mobile_app/Models/MovieTrailersResponseModel/movieTrailersResponseModel.dart';
import 'package:mobile_app/Models/UpcomingMoviesModel/searchedMoviesResponseModel.dart';
import 'package:mobile_app/Models/UpcomingMoviesModel/upcomingMoviesModel.dart';

class MoviesListProvider extends ChangeNotifier{
  UpcomingMoviesResponseModel? _upcomingMoviesResponseModel;
  SearchedMoviesResponseModel? _searchedMoviesResponseModel;
  MovieDetailResponseModel? _movieDetailResponseModel;
  MovieTrailersResponseModel? _movieTrailersResponseModel;
  GenresResponseModel?_genresResponseModel;
  UpcomingMoviesResponseModel? get upcomingMoviesModel => _upcomingMoviesResponseModel;
  MovieDetailResponseModel? get movieDetailResponseModel => _movieDetailResponseModel;
  MovieTrailersResponseModel? get movieTrailersResponseModel => _movieTrailersResponseModel;
  GenresResponseModel? get genresResponseModel => _genresResponseModel;
  SearchedMoviesResponseModel? get searchedMoviesResponseModel => _searchedMoviesResponseModel;

  set setUpcomingMoviesResponse(UpcomingMoviesResponseModel responseModel) {
    _upcomingMoviesResponseModel = responseModel;
    notifyListeners();
  }

  set setSearchedMoviesResponse(SearchedMoviesResponseModel responseModel) {
    _searchedMoviesResponseModel = responseModel;
    notifyListeners();
  }

  set setMovieDetailResponse(MovieDetailResponseModel responseModel) {
    _movieDetailResponseModel = responseModel;
    notifyListeners();
  }

  set setMovieTrailersResponse(MovieTrailersResponseModel responseModel) {
    _movieTrailersResponseModel = responseModel;
    notifyListeners();
  }

  set setGenresResponse(GenresResponseModel value){
    _genresResponseModel = value;
    notifyListeners();
  }
}