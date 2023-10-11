import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/Providers/MoviesListProvider/moviesListProvider.dart';
import 'package:mobile_app/Screens/SeatSelectionPage/SeatSelectionPage.dart';
import 'package:mobile_app/Screens/VideoPlayerPage/videoPlayerPage.dart';
import 'package:mobile_app/Utils/HelperFunctions/helperFunctions.dart';
import 'package:mobile_app/Widgets/CustomFilledButton.dart';
import 'package:mobile_app/Widgets/OutlinedButton.dart';
import 'package:provider/provider.dart';

import '../../AppTheme/colorConstants.dart';
import '../../Utils/Constants/globals.dart';
import '../../Widgets/GradientTopBottom.dart';
import '../../Widgets/appLoader.dart';
import 'dart:math' as math;

class MovieDetailPageUI extends StatefulWidget {
  const MovieDetailPageUI({super.key});

  @override
  State<MovieDetailPageUI> createState() => _MovieDetailPageUIState();
}

class _MovieDetailPageUIState extends State<MovieDetailPageUI> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 20; i++) {
      colors.add(Colors.primaries[(i + math.Random().nextInt(100)) % Colors.accents.length]);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MoviesListProvider>(builder: (context, moviesProvider, child) {
      var movieDetailData = moviesProvider.movieDetailResponseModel;
      var movieTrailer =
          moviesProvider.movieTrailersResponseModel?.movieTrailerData?.where((element) => element.type == "Trailer").first ??
              moviesProvider.movieTrailersResponseModel?.movieTrailerData?.first;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 470.sp,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  useOldImageOnUrlChange: false,
                  // alignment: Alignment.topCenter,
                  imageUrl: "https://image.tmdb.org/t/p/w500${movieDetailData?.posterPath}",
                  placeholder: (_, __) {
                    return AppLoader();
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GradientTopBottom(
                    isBottom: true,
                    height: 302.sp,
                    color: ColorConstants.black,
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 30.sp),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 30.sp,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 15.sp,
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                "Watch",
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: ColorConstants.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "In Theaters ${HelperFunctions().convertDate(movieDetailData?.releaseDate)}",
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        CustomFilledButton(
                          width: 243.w,
                          height: 50.sp,
                          title: "Get Tickets",
                          btnColor: ColorConstants.bluePrimary,
                          btnRadius: 10.r,
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return SeatSelectionPage(
                                movieTitle: movieDetailData?.title,
                                releaseDate: HelperFunctions().convertDate(movieDetailData?.releaseDate),
                              );
                            }));
                          },
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        CustomOutlineButton(
                          width: 243.w,
                          height: 50.sp,
                          title: "Watch Trailer",
                          buttonIcon: Icons.play_arrow,
                          buttonIconColor: ColorConstants.white,
                          buttonIconSize: 16.sp,
                          borderColor: ColorConstants.bluePrimary,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return VideoPlayerPage(
                                movieTrailerData: movieTrailer,
                              );
                            }));
                          },
                        ),
                        SizedBox(
                          height: 34.sp,
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 27.sp),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Genres",
                  style: TextStyle(color: ColorConstants.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 14.sp, 0.w, 22.sp),
                  child: SizedBox(
                    height: 24.sp,
                    child: ListView.builder(
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: movieDetailData?.genres?.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: Container(
                              height: 24.sp,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(color: colors[index], borderRadius: BorderRadius.circular(16.r)),
                              child: Center(
                                child: Text(
                                  movieDetailData!.genres![index].name!,
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Divider(
                  color: ColorConstants.black,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  "Overview",
                  style: TextStyle(color: ColorConstants.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  movieDetailData?.overview ?? "",
                  // maxLines: 6,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ColorConstants.black.withOpacity(0.7), fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ))
        ],
      );
    });
  }
}
