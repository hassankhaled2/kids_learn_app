import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kids_learn_app/utils/themes/app_colors.dart';
import 'package:kids_learn_app/utils/themes/font_size.dart';

AppBar getDefaultAppBarWidget({required bool centerTitle,required BuildContext context, required String title, required Color color , List<Widget>? actions,required FontWeight fontWeight,Color iconTheme = AppColors.white54Color}) {
  return AppBar(

    elevation:20,
    centerTitle: centerTitle,
    // backgroundColor:backgroundColor ,
    title: Text(
      title,
      // style: TextStyle(color: color, fontWeight: fontWeight,),
    ),

    // toolbarHeight: context.getDefaultSize() * 4.8, //  for increasing the height based on the screen size
    titleTextStyle: TextStyle(color: color, fontWeight: fontWeight,fontSize: FontSize.fontSize18),
    actions: actions,
    iconTheme:  IconThemeData(color: iconTheme), // <-- back button color
  );
}
