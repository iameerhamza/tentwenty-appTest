import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/AppTheme/colorConstants.dart';
import 'package:mobile_app/Models/UpcomingMoviesModel/upcomingMoviesModel.dart';
import 'package:mobile_app/Providers/MoviesListProvider/moviesListProvider.dart';
import 'package:mobile_app/Screens/HomeScreen/homeScreenUI.dart';
import 'package:mobile_app/Services/GenreAndImageService/genreAndImageService.dart';
import 'package:mobile_app/Services/UpcomingMoviesService/upcomingMoviesService.dart';
import 'package:mobile_app/Utils/Constants/assetConstants.dart';
import 'package:provider/provider.dart';

import '../Services/API/api_response.dart';
import '../Widgets/appLoader.dart';

class SplashUI extends StatefulWidget {
  const SplashUI({super.key});

  @override
  State<SplashUI> createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {

  Future<ApiResponse<UpcomingMoviesResponseModel>>? getUpcomingMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpcomingMovies = UpcomingMoviesService().getUpcomingMovies(context);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ColorConstants.offWhite,
      body: FutureBuilder<ApiResponse<UpcomingMoviesResponseModel>>(
          future: getUpcomingMovies,
          builder: (context, AsyncSnapshot<ApiResponse<UpcomingMoviesResponseModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: size.width * 0.5,
                      child: Image.asset(AssetConstants.logo)),
                  SizedBox(height: 10.sp,),
                  AppLoader(),
                ],
              ));
            } else{
              return HomeScreenUI();
            }
          }),
    );
  }
}
