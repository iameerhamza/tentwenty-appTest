import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/AppTheme/colorConstants.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../Providers/MoviesListProvider/moviesListProvider.dart';
import '../../Utils/Constants/globals.dart';

class GenresGridView extends StatefulWidget {
  const GenresGridView({super.key});

  @override
  State<GenresGridView> createState() => _GenresGridViewState();
}

class _GenresGridViewState extends State<GenresGridView> {

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
    return Consumer<MoviesListProvider>(builder: (context, moviesListProvider, child) {
      var genresList = moviesListProvider.genresResponseModel?.genres;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.0,
              crossAxisCount: 2,
              mainAxisExtent: 100.sp,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.sp),
            itemCount: genresList?.length ?? 0,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colors[index]
                ),
                child: Container(
                  color: ColorConstants.black.withOpacity(0.15),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Text(
                        genresList![index].name!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }, ),
      );
    });
  }
}
