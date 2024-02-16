import 'package:firebase_core/firebase_core.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:recipe_app/provider/ads.provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/cubit/counter_cubit.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/pages/splash_screen.dart';
import 'package:recipe_app/provider/app_auth.provider.dart';
import 'package:recipe_app/services/preferences.services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {

    //PreferencesService.prefs = await SharedPreferences.getInstance();
    var preference = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(preference);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    //);

    // if (preference != null) {
    //   print(
    //       '========================= prefrences init Successfully ========================');
    // }
  } catch (e) {
    print(
        '=========================Error In init Prefrences ${e}========================');



  }
  // runApp(MultiProvider(
  //     providers: [ChangeNotifierProvider(create: (_) => AppAuthProvider())],
  //     child: const MyApp()));

  //****************  Using BlocProvider ********************
  // runApp(BlocProvider<CounterCubit>(
  //     create:  (context) => CounterCubit(),
  //     child: const MyApp()));
  //****************  Using MultiProvider ********************
  runApp(                                                     MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppAuthProvider()),
    ChangeNotifierProvider(create: (_) => AdsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlayKit(
      child:MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Hellix',
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xfff45b00),
            primary: Color(0xfff45b00),
            secondary: Color(0xfff45b00),
          ),
          useMaterial3: true,
        ),
        home: SplashPage(),
      )
    );
  }
}


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     //PreferencesService.prefs = await SharedPreferences.getInstance();
//     var preferences = await SharedPreferences.getInstance();
//     GetIt.I.registerSingleton<SharedPreferences>(preferences);
//
//     // if(PreferencesService.prefs != null){
//     //   print("********** Preferences Intialized Successfully *******")
//     // }
//   } catch (e) {
//     print("***********Error in shared pref ${e} **************");
//   }
//
//   runApp(BlocProvider<CounterCubit>{
//   create: (context) => CounterCubit(),
//   (child: const MyApp()));
//
//   }
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a blue toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const SplashPage(),
//     );
//   }
// }
//
