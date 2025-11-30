

import 'package:flutter/material.dart';
import 'package:kids_learn_app/core/size_config.dart';
import 'app_colors.dart';
import 'font_family.dart';
import 'font_size.dart';
import 'font_weight_manager.dart';


// see change color & FontSize (if needed)
abstract class AppStyle
{
  //Regular
  static  TextStyle styleRegular14(BuildContext context)=>TextStyle(
    // put the most color used
    // color:AppColors.blackColor,
    fontSize: getResponsiveFontSize(fontSize: FontSize.fontSize14,context),
    fontWeight:FontWeightManger.normalRegularPlain,
    fontFamily: FontFamily.montserratFont,

  );
  static  TextStyle styleRegular16(BuildContext context)=>TextStyle(
    // put the most color used
    // color:AppColors.blackColor,
    fontSize: getResponsiveFontSize(fontSize: FontSize.fontSize16,context),
    fontWeight:FontWeightManger.normalRegularPlain,
    fontFamily: FontFamily.montserratFont,

  );

  //Medium

  static  TextStyle styleMedium10(BuildContext context)=>TextStyle(
    // put the most color used
    color:Colors.black54,
    fontSize: getResponsiveFontSize(fontSize: FontSize.fontSize18,context),
    fontWeight:FontWeightManger.medium,
    fontFamily: FontFamily.montserratFont,

  );
  //Bold

  static  TextStyle styleBold16(BuildContext context)=>TextStyle(
    // put the most color used
    color:AppColors.blackColor,
    fontSize: getResponsiveFontSize(fontSize: FontSize.fontSize16,context),
    fontWeight:FontWeightManger.bold,
    fontFamily: FontFamily.montserratFont,

  );
  static  TextStyle styleBold20(BuildContext context)=>TextStyle(
    // put the most color used
    // color:AppColors.blackColor,
    fontSize: getResponsiveFontSize(fontSize: FontSize.fontSize20,context),
    fontWeight:FontWeightManger.bold,
    fontFamily: FontFamily.montserratFont,

  );

  static  TextStyle styleBold22(BuildContext context)=>TextStyle(
    // put the most color used
    // color:AppColors.blackColor,
    fontSize: getResponsiveFontSize(fontSize: FontSize.fontSize22,context),
    fontWeight:FontWeightManger.bold,
    fontFamily: FontFamily.montserratFont,

  );
  static  TextStyle styleBold28(BuildContext context)=>TextStyle(
    // put the most color used
    // color:AppColors.blackColor,
    fontSize: getResponsiveFontSize(fontSize: FontSize.fontSize38,context),
    fontWeight:FontWeightManger.mostThick,
    fontFamily: FontFamily.montserratFont,

  );

  //SemiBold

  static  TextStyle styleSemiBold16(BuildContext context)=>TextStyle(
    // put the most color used
    color:AppColors.blackColor,
    fontSize: getResponsiveFontSize(fontSize: FontSize.fontSize16,context),
    fontWeight:FontWeightManger.semiBold,
    fontFamily: FontFamily.montserratFont,

  );
  static  TextStyle styleSemiBold18(BuildContext context)=>TextStyle(
    // put the most color used
    color:Colors.black54,
    fontSize: getResponsiveFontSize(fontSize: FontSize.fontSize18,context),
    fontWeight:FontWeightManger.semiBold,
    fontFamily: FontFamily.montserratFont,

  );
}
/// see it again video
double getResponsiveFontSize(BuildContext context,{required double fontSize})
{
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize =fontSize*scaleFactor;
//لو قلبت هتقل 20% ولو زدت هتزبد 20%
  double lowerLimit =fontSize*.8;
  double upperLimit =fontSize*1.2;
  print('base font Size =$fontSize lowerLimit $lowerLimit , upperLimit =$upperLimit ,responsive font size=$responsiveFontSize finalFontSize = ${responsiveFontSize.clamp(lowerLimit,upperLimit)}');
  return responsiveFontSize.clamp(lowerLimit,upperLimit);
}

double getScaleFactor(BuildContext context) {
  // mobile ,tablet only
  // var dispatcher=PlatformDispatcher.instance;
  // var physicalWidth =dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio =dispatcher.views.first.devicePixelRatio;
  // double width =physicalWidth/devicePixelRatio;
  var width =MediaQuery.of(context).size.width;
  if(width<SizeConfig.tablet)
  {
    return width /550;
  }else if(width<SizeConfig.desktop)
  {
    return width/1000;
  }else
  {
    return  width/1900;
  }
}