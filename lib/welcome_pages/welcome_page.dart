import 'package:flutter/material.dart';
import 'package:tailor_book/colors.dart';
import 'package:tailor_book/login/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            child: Image.asset("assets/images/logo.png"),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const LoginPage(),
                    transitionDuration: const Duration(seconds: 1),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: const BoxDecoration(
                  color: blue,
                ),
                child: const Text(
                  "START",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
