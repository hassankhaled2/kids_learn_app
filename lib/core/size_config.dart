//to can modify all value in all app easily if you need
import 'package:flutter/material.dart';

class SizeConfig {
  static const double desktop = 1200;
  static const double tablet = 800;
  static late double width, height;
  //! --> instead of using of media Query in direct you use variable you will see problem specially in web why?
  // because you change the value in realTime Not Like the mobile you need to rebuild to see the value change
  // use it in mobile & tablet only
  static init (BuildContext context)
  {
    height = MediaQuery.sizeOf(context).height;
    height = MediaQuery.sizeOf(context).width;
  }
}