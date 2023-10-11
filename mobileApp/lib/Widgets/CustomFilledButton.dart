import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../AppTheme/colorConstants.dart';

class CustomFilledButton extends StatelessWidget {
  final String? title;
  final Gradient? buttonGradients;
  final double? width, height, btnRadius, textColorOpacity, fontSize, buttonIconSize;
  final Color? textColor, buttonIconColor, btnColor, borderColor;
  final VoidCallback? onPressed;
  final bool isTitleUpperCase;
  IconData? buttonIcon;
  final Widget? child;

  CustomFilledButton(
      {this.title,
      this.onPressed,
      this.width,
      this.buttonIcon,
      this.isTitleUpperCase = true,
      this.height,
      this.buttonIconSize,
      this.textColor,
      this.buttonIconColor,
      this.textColorOpacity = 1,
      this.btnColor,
      this.borderColor,
      this.btnRadius,
      this.buttonGradients,
      this.fontSize,
      this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double shortestSide = size.shortestSide;
    final bool isMobile = shortestSide < 600.0;
    return Container(
        width: width ?? double.infinity,
        height: height ?? 40.h,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.all(Radius.circular(btnRadius ?? 30))),
        child: buttonIcon == null
            ? ElevatedButton(
          style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  primary: btnColor ?? ColorConstants.transparent,
                  side: BorderSide(color: borderColor ?? ColorConstants.transparent),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(btnRadius ?? 30)),
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
                        color: textColor,
                        fontSize: fontSize ?? 14.sp,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              )
            : ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: btnColor ?? ColorConstants.transparent,
                  side: BorderSide(color: borderColor ?? ColorConstants.transparent),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(btnRadius ?? 30)),
                  minimumSize: Size(width ?? double.infinity, height ?? 40.h),
                ),
                onPressed: onPressed ?? () {},
                icon: Icon(
                  buttonIcon,
                  color: buttonIconColor,
                  size: buttonIconSize,
                ),
                label: Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.25,
                        color: textColor,
                        fontSize: fontSize ?? 14.sp,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ));
  }
}
