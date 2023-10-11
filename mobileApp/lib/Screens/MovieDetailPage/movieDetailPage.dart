import 'package:flutter/material.dart';
import 'package:mobile_app/Models/MovieDetailResponseModel/movieDetailResponseModel.dart';
import 'package:mobile_app/Models/MovieTrailersResponseModel/movieTrailersResponseModel.dart';
import 'package:mobile_app/Screens/MovieDetailPage/movieDetailPageUI.dart';
import 'package:mobile_app/Services/MovieDetailService/movieDetailService.dart';

import '../../AppTheme/colorConstants.dart';
import '../../Services/API/api_response.dart';
import '../../Widgets/appLoader.dart';

class MovieDetailPage extends StatefulWidget {
  final String? movieId;
  const MovieDetailPage({super.key, this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  Future<ApiResponse<MovieDetailResponseModel>>? getMovieDetail;
  Future<ApiResponse<MovieTrailersResponseModel>>? getMovieTrailers;
  late Future<List<ApiResponse<Object>>> _getDataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieDetail = MovieDetailService().getMovieDetails(context, widget.movieId!);
    getMovieTrailers = MovieDetailService().getMovieTrailer(context, widget.movieId!);
    _getDataList = Future.wait([getMovieDetail!, getMovieTrailers!]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.offWhite,
      body: FutureBuilder<List<ApiResponse<Object>>>(
          future: _getDataList,
          builder: (context, AsyncSnapshot<List<ApiResponse<Object>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: AppLoader());
            } else{
              return MovieDetailPageUI();
            }
          }),
    );
  }
}
