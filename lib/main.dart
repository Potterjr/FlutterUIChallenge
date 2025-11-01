import 'package:ex_ui_shoping/config/api/setupapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';

import 'config/routes/routes.dart';

void main() async {
  onSetup();
  if (!GetPlatform.isWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    return runApp(const MainApp());
  }
  runApp(DevicePreview(builder: (context) => const MainApp()));
}

/// Initialize the setup for the application.
///
/// This function is responsible for setting the preferred
/// orientations for the application, and initializing the API.
///
/// It is called immediately after the application is started.
///
/// It is an asynchronous function, and it will not block the
/// execution of the application.
void onSetup() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  widgetsBinding.addPostFrameCallback((timeStamp) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  });

  API.init();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: routes,
      initialRoute: RoutesHandler.home,
    );
  }
}
