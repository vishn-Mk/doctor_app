import 'package:doctor_app/provider/bottomnav_provider.dart';
import 'package:doctor_app/provider/offer_provider.dart';
import 'package:doctor_app/screens/HomeScreen.dart';
import 'package:doctor_app/screens/doctors.dart';
import 'package:doctor_app/screens/login.dart';
import 'package:doctor_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OfferProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health App',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(), // Apply Montserrat text theme
        tabBarTheme: TabBarTheme( // Proper TabBarTheme object
          labelStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
