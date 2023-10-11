import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../AppTheme/colorConstants.dart';

class CustomOutlineButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final double? width;
  final Color? borderColor;
  final double? height;
  final double? fontSize;
  final bool isTitleUpperCase;
  final Color? fontColor;
  final double textColorOpacity;
  final IconData? buttonIcon;
  final Color? buttonIconColor;
  final double? buttonIconSize;

  CustomOutlineButton(
      {this.title,
      this.onPressed,
      this.isTitleUpperCase = true,
      this.width,
      this.height,
      this.borderColor,
      this.fontSize,
      this.fontColor,
      this.textColorOpacity = 1, this.buttonIcon, this.buttonIconColor, this.buttonIconSize});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double shortestSide = size.shortestSide;
    final bool isMobile = shortestSide < 600.0;
    return Container(
      width: width ?? double.infinity,
      height: height ?? 40.h,
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      child: Center(
        child: buttonIcon == null ? ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ColorConstants.transparent,
            side: BorderSide(color: borderColor!),
            elevation: 0,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            minimumSize: Size(width ?? double.infinity, height ?? 40.h),
          ),
          onPressed: onPressed ?? () {},
          child: Padding(
            padding: kIsWeb
                ? isMobile
                    ? EdgeInsets.only(top: 3)
                    : EdgeInsets.zero
                : EdgeInsets.zero,
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.25,
                  color: fontColor,
                  fontSize: fontSize ?? 14.sp,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ): ElevatedButton.icon(style: ElevatedButton.styleFrom(
          primary: ColorConstants.transparent,
          side: BorderSide(color: borderColor!),
          elevation: 0,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          minimumSize: Size(width ?? double.infinity, height ?? 40.h),
        ),
          onPressed: onPressed ?? () {},
          icon: Icon(
            buttonIcon,
            color: buttonIconColor,
            size: buttonIconSize,
          ),
          label: Padding(
            padding: kIsWeb
                ? isMobile
                ? EdgeInsets.only(top: 3)
                : EdgeInsets.zero
                : EdgeInsets.zero,
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.25,
                  color: fontColor,
                  fontSize: fontSize ?? 14.sp,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),),
      ),
    );
  }
}
