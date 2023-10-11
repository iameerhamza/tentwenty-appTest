
import 'package:flutter/material.dart';
import 'package:mobile_app/Models/UpcomingMoviesModel/upcomingMoviesModel.dart';
import 'package:mobile_app/Providers/MoviesListProvider/moviesListProvider.dart';
import 'package:provider/provider.dart';

import '../API/api.dart';
import '../API/api_response.dart';
import '../API/app_exceptions.dart';

class UpcomingMoviesService {
  Future<ApiResponse<UpcomingMoviesResponseModel>> getUpcomingMovies(BuildContext context) async {
    try {
      var response = await Api.getRequestData("movie/upcoming?", context);

      UpcomingMoviesResponseModel responseModel = UpcomingMoviesResponseModel.fromJson(response);
      // print("Movies Response: ${responseModel.toJson()}");
      Provider.of<MoviesListProvider>(context, listen: false).setUpcomingMoviesResponse = responseModel;
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
