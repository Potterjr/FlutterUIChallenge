import 'package:flutter/material.dart';

class DeviceUtils {
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.shortestSide;
    
    return width >= 600;
  }

  static bool isMobile(BuildContext context) {
    return !isTablet(context);
  }

  static String deviceType(BuildContext context)  {
    if (isTablet(context)) {
      return "Tablet";
    }
    return "Mobile";
  }
}
