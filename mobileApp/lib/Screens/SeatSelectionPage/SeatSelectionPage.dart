import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/AppTheme/colorConstants.dart';
import 'package:mobile_app/Widgets/CustomFilledButton.dart';

class SeatSelectionPage extends StatefulWidget {
  final String? movieTitle;
  final String? releaseDate;
  const SeatSelectionPage({super.key, this.movieTitle, this.releaseDate});

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {

  List<String> items= [];
  List<CinemaDetails> cinemaDetails = [];
  int selected = -1;
  int selectedCinema = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final today = DateTime.now();
    items = List.generate(7, (index) {
      final date = today.add(Duration(days: index));
      return DateFormat('d MMM').format(date);
    });
    cinemaDetails = [
      CinemaDetails(time: "12:30", hallNumber: 1, price: "50\$", bonus: "2500"),
      CinemaDetails(time: "13:30", hallNumber: 2, price: "75\$", bonus: "3000"),
    ];

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ColorConstants.offWhite,
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: ColorConstants.black, size: 18.sp,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 76.21.sp,
        centerTitle: true,
        title: Column(
          children: [
            Text(widget.movieTitle ?? '', style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: ColorConstants.black
            ),),
            Text("In Theaters ${widget.releaseDate}", style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: ColorConstants.bluePrimary
            ),),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 20.sp,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Date", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: ColorConstants.black),),
                SizedBox(
                  height: 60.sp,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (_, index){
                        return Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: UnconstrainedBox(
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  selected = index;
                                });
                              },
                              child: Container(
                                height: 32.sp,
                                decoration: BoxDecoration(
                                  color: selected == index ? ColorConstants.bluePrimary : Color.fromRGBO(166, 166, 166, 0.1),
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: selected == index ? [
                                    BoxShadow(
                                      color: ColorConstants.bluePrimary.withOpacity(0.27), // Shadow color
                                      offset: Offset(0, 0), // Shadow position
                                      blurRadius: 21, // Shadow blur radius
                                      spreadRadius: 0, // Shadow spread radius
                                    ),
                                  ]: []
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Center(
                                  child: Text(
                                    items[index],
                                    style: TextStyle(
                                      color: selected == index ? ColorConstants.white : ColorConstants.black
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 200.sp,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: cinemaDetails.length,
                      itemBuilder: (_, index){
                        return Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: UnconstrainedBox(
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  selectedCinema = index;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cinemaDetails[index].time!,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstants.black
                                        ),
                                      ),
                                      SizedBox(width: 9.w,),
                                      Text(
                                        "Cinetech + Hall ${cinemaDetails[index].hallNumber}",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstants.black.withOpacity(0.5)
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5.sp),
                                    child: Container(
                                      width: 249.w,
                                      height: 145.sp,
                                      decoration: BoxDecoration(
                                          color: ColorConstants.offWhite,
                                          borderRadius: BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color: selectedCinema == index ? ColorConstants.bluePrimary : ColorConstants.black.withOpacity(0.2)
                                          ),
                                          boxShadow: selectedCinema == index ? [
                                            BoxShadow(
                                              color: ColorConstants.grey.withOpacity(0.27), // Shadow color
                                              offset: Offset(0, 0), // Shadow position
                                              blurRadius: 21, // Shadow blur radius
                                              spreadRadius: 0, // Shadow spread radius
                                            ),
                                          ]: []
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                                      child: Center(
                                        child: cinemaDetails[index].child
                                      ),
                                    ),
                                  ),
                                  RichText(text: TextSpan(
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: ColorConstants.black.withOpacity(0.5),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "From "
                                      ),
                                      TextSpan(
                                          text: cinemaDetails[index].price,
                                        style: TextStyle(color: ColorConstants.black, fontWeight: FontWeight.w700)
                                      ),
                                      TextSpan(
                                          text: " or "
                                      ),
                                      TextSpan(
                                          text: "${cinemaDetails[index].bonus} bonus",
                                          style: TextStyle(color: ColorConstants.black, fontWeight: FontWeight.w700)
                                      ),
                                    ]
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          CustomFilledButton(
            width: size.width * 0.9,
            height: 50.sp,
            title: "Select Seats",
            btnColor: ColorConstants.bluePrimary,
            btnRadius: 10.r,
            onPressed: (){

            },
          ),
        ],
      ),
    );
  }
}

class CinemaDetails{
  String? time;
  int? hallNumber;
  Widget? child;
  String? price;
  String? bonus;

  CinemaDetails({this.time, this.hallNumber, this.child, this.price, this.bonus});
}
