import 'package:flutter/material.dart';
import 'addcv.dart';
import 'main.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 123, 4, 4), 
                  Color.fromARGB(255, 8, 0, 0), 
                ],
              ),
            ),
          ),

          Positioned.fill(
            child: Image.asset(
              'assets/279.jpg', 
              fit: BoxFit.cover, 
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.02), 
              colorBlendMode: BlendMode.dstIn, 
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "AI CV Matcher",
                  style: TextStyle(
                    
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 120), 

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    createCustomRoute(
                       const AddCvPage(),
                    ),
                  );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF003366), 
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 25),
                    textStyle: const TextStyle(
                      letterSpacing: 2,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), 
                    ),
                    elevation: 10, 
                  ),
                  child: const Text("Let's Start"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}