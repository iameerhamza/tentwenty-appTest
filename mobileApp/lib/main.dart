import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/Providers/MoviesListProvider/moviesListProvider.dart';
import 'package:mobile_app/Screens/splashUI.dart';
import 'package:provider/provider.dart';

import 'Utils/HelperFunctions/helperFunctions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top,
    SystemUiOverlay.bottom
  ]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<MoviesListProvider>(create: (context) => MoviesListProvider()),
            // ChangeNotifierProvider<BookingProvider>(create: (context) => BookingProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Ten Twenty",
            theme: HelperFunctions().buildTheme(Brightness.dark),
           home: const SplashUI(),

            // onGenerateRoute: RouteGenerator.router.generator,
          ),
        );
      },
    );
  }
}
