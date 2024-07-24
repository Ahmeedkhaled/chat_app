import 'package:chat_app/constant/routes_app.dart';
import 'package:chat_app/constant/theme_app.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/view/screen/add_room/add_room.dart';
import 'package:chat_app/view/screen/auth/login/login_screen.dart';
import 'package:chat_app/view/screen/auth/register/register_screen.dart';
import 'package:chat_app/view/screen/home/home_screen.dart';
import 'package:chat_app/view/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBlV4kXeu3CwWlTiN2c9wb-bsCuJzUCwNY',
      appId: '1:219997589097:android:904e51fd4127ed8b3b9cf8',
      messagingSenderId: '219997589097',
      projectId: 'chat-app-fbcd7',
      // storageBucket: 'chat-app-fbcd7.appspot.com',
    ),
  );

  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesApp.splashScreen,
      routes: {
        RoutesApp.registerScreen: (context) => const RegisterScreen(),
        RoutesApp.homeScreen: (context) => const HomeScreen(),
        RoutesApp.loginScreen: (context) => const LoginScreen(),
        RoutesApp.splashScreen: (context) => const SplashScreen(),
        RoutesApp.addRoom: (context) => const AddRoom(),
      },
      theme: ThemeApp.themeApp,
    );
  }
}
