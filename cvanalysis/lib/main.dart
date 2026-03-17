import 'package:cvanalysis/Welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class Cvanalysis extends StatefulWidget {
  const Cvanalysis({super.key});

  @override
  State<Cvanalysis> createState() => _CvanalysisState();
}

class _CvanalysisState extends State<Cvanalysis> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
Route createCustomRoute(Widget destinationPage) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500), 
    pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      
      const begin = Offset(1.0, 0.0); 
      const end = Offset.zero;
      
      const curve = Curves.easeOutQuart; 

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}