import 'package:e_auction/Providers/productservices.dart';
import 'package:e_auction/Providers/user_info.dart';
import 'package:e_auction/splashscreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/constant.dart';
import 'constants/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MultiProvider(providers: [
    Provider(create: (context)=>ProductService()),
    Provider(create: (context)=>userInfo()),

  ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: apptitle,
      theme: theme(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

