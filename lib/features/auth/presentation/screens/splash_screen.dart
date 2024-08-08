// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:rick_and_morty/features/auth/presentation/screens/splash_screen_2.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     {
//   @override
//   void initState() {
//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => SplashScreen2(),
//         ),
//       );
//     });
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//     super.initState();
//     // Future.delayed(const Duration(seconds: 5), () {});
//   }

//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: SystemUiOverlay.values);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/splash.png'),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
