import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/AppTheme/colorConstants.dart';
import 'package:mobile_app/Screens/HomeScreen/moviesListView.dart';
import 'package:mobile_app/Screens/HomeScreen/moviesSearchView.dart';
import 'package:mobile_app/Utils/Constants/assetConstants.dart';
import 'package:websafe_svg/websafe_svg.dart';


class HomeScreenUI extends StatefulWidget {
  const HomeScreenUI({super.key});

  @override
  State<HomeScreenUI> createState() => _HomeScreenUIState();
}

class _HomeScreenUIState extends State<HomeScreenUI> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: ColorConstants.offWhite,
        appBar: AppBar(
            title: isSearching
                ? _buildSearchBar(size)
                : Text(
                    "Watch",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: ColorConstants.black),
                  ),
            backgroundColor: ColorConstants.white,
            elevation: 0,
            toolbarHeight: 64.21.sp,
            titleSpacing: 20.w,
            actions: _buildActions()),
        bottomNavigationBar: Container(
          height: 75.sp,
          decoration: BoxDecoration(
              color: ColorConstants.navBar,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(27.r), topRight: Radius.circular(27.r))),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: BottomNavigationBar(
              currentIndex: 1,
              backgroundColor: ColorConstants.navBar,
              type: BottomNavigationBarType.fixed,
              useLegacyColorScheme: false,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.sp, color: ColorConstants.white),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 10.sp, color: ColorConstants.white),
              items: [
                BottomNavigationBarItem(
                    label: "Dashboard", icon: navBarIcon(AssetConstants.dashboardIcon, ColorConstants.navBarFadedIcons)),
                BottomNavigationBarItem(label: "Watch", icon: navBarIcon(AssetConstants.watchIcon, ColorConstants.white)),
                BottomNavigationBarItem(
                    label: "Media Library", icon: navBarIcon(AssetConstants.mediaLibraryIcon, ColorConstants.navBarFadedIcons)),
                BottomNavigationBarItem(
                    label: "More", icon: navBarIcon(AssetConstants.moreIcon, ColorConstants.navBarFadedIcons)),
              ]),
        ),
        body: isSearching ? MoviesSearchView(query: searchController.text) : MoviesListView());
  }

  List<Widget> _buildActions() {
    if (isSearching) {
      return <Widget>[
      ];
    } else {
      return <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: InkWell(
            onTap: () {
              setState(() {
                isSearching = true;
              });
            },
            child: SizedBox(
                width: 36.sp,
                height: 36.sp,
                child: Icon(
                  CupertinoIcons.search,
                  color: ColorConstants.black,
                )),
          ),
        )
      ];
    }
  }

  TextEditingController searchController = TextEditingController();

  Widget _buildSearchBar(Size size) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: size.width,
      height: 52.sp,
      decoration: BoxDecoration(color: ColorConstants.offWhite, borderRadius: BorderRadius.circular(30.r)),
      child: SizedBox(
        // width: size.width * 0.6,
        child: Center(
          child: TextField(
            controller: searchController,
            onSubmitted: (value){
              setState(() {
                searchController.text = value;
              });

            },
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
            ),
            // The style of the input field
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'TV shows, movies and more',
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: SizedBox(
                    width: 36.sp,
                    height: 36.sp,child: Icon(CupertinoIcons.search, color: ColorConstants.black,)),
              ), // Edit icon
              // The style of the hint text
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 14.sp,
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      searchController.clear();
                      isSearching = false;
                    });
                  },
                  child: SizedBox(
                      width: 36.sp,
                      height: 36.sp,
                      child: Icon(
                        CupertinoIcons.clear,
                        color: ColorConstants.black,
                      )),
                ),
              )
            ),
            // The controller of the input box
          ),
        ),
      ),
    );
  }
}

Widget navBarIcon(String asset, Color? svgColor) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0.sp),
    child: WebsafeSvg.asset(
      asset,
      width: 18.sp,
      height: 18.sp,
      alignment: Alignment.center,
      colorFilter: ColorFilter.mode(
        svgColor!,
        BlendMode.srcIn,
      ),
    ),
  );
}
