import 'package:project/screens/profileScreen.dart';
import 'package:project/screens/coupon_screen.dart';
import 'package:project/screens/estacion1_screen.dart';
import 'package:project/screens/estacion2_screen.dart';
import 'package:project/screens/Bicicletas.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/screens/register.dart';
import 'package:project/screens/splashscreen.dart';
import 'package:project/screens/map_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final TextTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(252, 163, 17, 1),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.latoTextTheme(TextTheme).copyWith(
          bodyMedium: GoogleFonts.oswald(textStyle: TextTheme.bodyMedium),
        ),
      ),
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/login': (_) => const Login(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomeScreen(),
        '/map': (_) => const MapScreen(),
        '/bicicletas': (_) => const Estacion1(),
        '/scooters': (_) => const Estacion2(),
        '/bicicletas1': (_) => const BicicletaScreen(),
        '/profile': (_) => ProfileScreen(),
        '/coupons': (_) => CouponScreen(),
      },
      home: const Login(),
    );
  }
}
