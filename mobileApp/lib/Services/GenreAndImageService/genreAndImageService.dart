
import 'package:flutter/material.dart';
import 'package:mobile_app/Models/GenresResponseModel/genresResponseModel.dart';
import 'package:provider/provider.dart';

import '../../Providers/MoviesListProvider/moviesListProvider.dart';
import '../API/api.dart';
import '../API/api_response.dart';
import '../API/app_exceptions.dart';


class GenreAndImageService{
  Future<ApiResponse<GenresResponseModel>> getGenres(BuildContext context) async {
    try {
      var response = await Api.getRequestData("genre/movie/list?", context);

      GenresResponseModel responseModel = GenresResponseModel.fromJson(response);
      print("Movies Response: ${responseModel.toJson()}");
      Provider.of<MoviesListProvider>(context, listen: false).setGenresResponse = responseModel;
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