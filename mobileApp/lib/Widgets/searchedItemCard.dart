import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../AppTheme/colorConstants.dart';
import '../Screens/MovieDetailPage/movieDetailPage.dart';
import 'appLoader.dart';

class SearchedItemCard extends StatefulWidget {
  final String? title;
  final String? overview;
  final String? imageUrl;
  final String? movieId;
  const SearchedItemCard({super.key, this.title, this.imageUrl, this.overview, this.movieId});

  @override
  State<SearchedItemCard> createState() => _SearchedItemCardState();
}

class _SearchedItemCardState extends State<SearchedItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MovieDetailPage(
            movieId: widget.movieId,
          );
        }));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: Row(
          children: [
            Container(
              height: 100.sp,
              width: 130.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r)
              ),
              child:  CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                imageUrl: "https://image.tmdb.org/t/p/w500${widget.imageUrl}",
                placeholder: (_,__){
                  return AppLoader();
                },
              errorWidget: (_,__, ___){
                  return Icon(
                    CupertinoIcons.nosign, color: ColorConstants.black,
                  );
              },
              ),
            ),
            SizedBox(width: 8.w,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title!,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500,
                      color: ColorConstants.black,),
                  ),
                  Text(
                    widget.overview ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500,
                      color: ColorConstants.black.withOpacity(0.5),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
