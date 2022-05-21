/*
* © Mostafa Alazhariy 2021
*/

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:encryption_app/layout/on_board_screen.dart';
import 'package:encryption_app/shared/network/local/on_board_cache.dart';
import 'package:encryption_app/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'layout/home_screen.dart';


void main() async {

  // insure the future methods are executed first before run app
  WidgetsFlutterBinding.ensureInitialized();

  RequestConfiguration config = RequestConfiguration(
    testDeviceIds: <String>['4A92A9DE35E8C65AF79B64ABF57D1274'],
    // a539cc08-fef2-4e5d-b4fd-4b7dbe141840
  );
  // MobileAds.instance.updateRequestConfiguration(config);
  MobileAds.instance.initialize();

  // prevent device orientation changes & force portrait
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );

  // Bloc.observer = MyBlocObserver();
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('myBox');

  runApp(
    EasyLocalization(
        supportedLocales: const[Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Sizer(
      builder: (context, orientation, deviceType){



        return MaterialApp(
          // localization methods
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          debugShowCheckedModeBanner: false,
          // locale: DevicePreview.locale(context),
          builder: (context, myWidget){
            myWidget = BotToastInit()(context, myWidget);
            // myWidget = DevicePreview.appBuilder(context, myWidget);
            return myWidget;
          },
          navigatorObservers: [BotToastNavigatorObserver()],

          home: BoardCache.isBoardSkipped() ? HomeScreen() : const OnBoardScreen(),
          // home: false ? HomeScreen() : const OnBoardScreen(),

          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
        );
      },
    );
  }
}
