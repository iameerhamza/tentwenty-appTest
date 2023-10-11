import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/AppTheme/colorConstants.dart';
import 'package:mobile_app/Widgets/GradientTopBottom.dart';
import 'package:mobile_app/Widgets/appLoader.dart';

class MovieItemCard extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final Function()? onTap;

  const MovieItemCard({super.key, this.imageUrl, this.title, this.onTap});

  @override
  State<MovieItemCard> createState() => _MovieItemCardState();
}

class _MovieItemCardState extends State<MovieItemCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.sp),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: size.width * 0.9,
          height: 180.sp,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  imageUrl: "https://image.tmdb.org/t/p/w500${widget.imageUrl!}",
              placeholder: (_,__){
                    return AppLoader();
              },),
              Align(
                alignment: Alignment.bottomCenter,
                child: GradientTopBottom(
                  isBottom: true,
                  height: 70.sp,
                  color: ColorConstants.black,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.sp),
                  child: Text(widget.title!, style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.white
                  ),),
                )
              )

            ],
          ),
        ),
      ),
    );
  }
}
