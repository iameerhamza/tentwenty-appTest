import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/AppTheme/colorConstants.dart';
import 'package:mobile_app/Providers/MoviesListProvider/moviesListProvider.dart';
import 'package:mobile_app/Widgets/searchedItemCard.dart';
import 'package:provider/provider.dart';

class SearchedMoviesPage extends StatefulWidget {
  const SearchedMoviesPage({super.key});

  @override
  State<SearchedMoviesPage> createState() => _SearchedMoviesPageState();
}

class _SearchedMoviesPageState extends State<SearchedMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesListProvider>(builder: (context, moviesProvider, child) {
      var searchedData = moviesProvider.searchedMoviesResponseModel?.results;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top Results",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500,
                color: ColorConstants.black,),
            ),
            Divider(
              color: ColorConstants.black,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: searchedData?.length ?? 0,
                  itemBuilder: (_, index) {
                    return SearchedItemCard(
                      movieId: searchedData?[index].id.toString(),
                      title: searchedData?[index].title,
                      overview: searchedData?[index].overview,
                      imageUrl: searchedData?[index].backdropPath ?? searchedData?[index].posterPath,
                    );
                  }),
            ),
          ],
        ),
      );
    });
  }
}
