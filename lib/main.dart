
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/AddScreen.dart';
import 'package:my_first_app/UpdateScreen.dart';
import 'package:my_first_app/viewmodels/product_viewmodel.dart';
import 'package:provider/provider.dart';

import 'DashboardScreen.dart';
import 'ForgetScreen.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ProductViewModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/login",
        routes: {
          "/login": (context) => LoginScreen(),
          "/register": (context) => RegisterScreen(),
          "/forget-password": (context) => ForgetScreen(),
          "/dasboard": (context) => DashBoardScreen(),
          "/add-screen": (context)=> AddScreen(),
          "/update-screen": (context)=>UpdateScreen()
        },
      ),
    );
  }
}
