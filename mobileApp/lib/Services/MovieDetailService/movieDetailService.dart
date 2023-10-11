
import 'package:flutter/material.dart';
import 'package:mobile_app/Models/MovieDetailResponseModel/movieDetailResponseModel.dart';
import 'package:mobile_app/Models/MovieTrailersResponseModel/movieTrailersResponseModel.dart';
import 'package:mobile_app/Providers/MoviesListProvider/moviesListProvider.dart';
import 'package:provider/provider.dart';

import '../API/api.dart';
import '../API/api_response.dart';
import '../API/app_exceptions.dart';

class MovieDetailService {
  Future<ApiResponse<MovieDetailResponseModel>> getMovieDetails(BuildContext context, String movieId) async {
    try {
      var response = await Api.getRequestData("movie/$movieId?", context);

      MovieDetailResponseModel responseModel = MovieDetailResponseModel.fromJson(response);
      print("Movies Response: ${responseModel.toJson()}");
      Provider.of<MoviesListProvider>(context, listen: false).setMovieDetailResponse = responseModel;
      return ApiResponse.completed(responseModel);
    } on BadRequestException {
      return ApiResponse.error('Bad Request Exception');
    } on UnauthorisedException {
      return ApiResponse.error('The User is Un-authorized');
    } on RequestNotFoundException {
      return ApiResponse.error('Request Not Found');
    } on UnautorizationException {
      return ApiResponse.error('The User is Un-authorized');
    } on InternalServerException {
      return ApiResponse.error('Internal Server Error');
    } on ServerNotFoundException {
      return ApiResponse.error('Server Not Available');
    } on FetchDataException {
      return ApiResponse.error('An Error occurred while Fetching the Data');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<MovieTrailersResponseModel>> getMovieTrailer(BuildContext context, String movieId) async {
    try {
      var response = await Api.getRequestData("movie/$movieId/videos?", context);

      MovieTrailersResponseModel responseModel = MovieTrailersResponseModel.fromJson(response);
      print("Movies Response: ${responseModel.toJson()}");
      Provider.of<MoviesListProvider>(context, listen: false).setMovieTrailersResponse = responseModel;
      return ApiResponse.completed(responseModel);
    } on BadRequestException {
      return ApiResponse.error('Bad Request Exception');
    } on UnauthorisedException {
      return ApiResponse.error('The User is Un-authorized');
    } on RequestNotFoundException {
      return ApiResponse.error('Request Not Found');
    } on UnautorizationException {
      return ApiResponse.error('The User is Un-authorized');
    } on InternalServerException {
      return ApiResponse.error('Internal Server Error');
    } on ServerNotFoundException {
      return ApiResponse.error('Server Not Available');
    } on FetchDataException {
      return ApiResponse.error('An Error occurred while Fetching the Data');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
