import 'package:flutter/material.dart';
import 'package:tailor_book/colors.dart';
import 'package:tailor_book/home/home_page.dart';
import 'package:tailor_book/login/forgotpsw_page.dart';
import 'package:tailor_book/login/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var hide = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              image: const AssetImage("assets/images/logo.png"),
            ),
            const Text(
              "Log in To Your Account",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Welcome Back, Please Enter Your Details",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: grey!,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Email Address",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: grey!,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: grey!,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  hintText: "Enter Your Email",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: grey!,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Password",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: grey!,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                obscureText: hide == true ? true : false,
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (hide == true) {
                          hide = false;
                        } else {
                          hide = true;
                        }
                      });
                    },
                    child: Icon(
                      hide == true
                          ? Icons.visibility_outlined
                          : Icons.visibility_off,
                      size: 25,
                      color: black,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: grey!,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  hintText: "Enter Your Password",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: grey!,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const ForgotpswPage(),
                    transitionDuration: const Duration(seconds: 1),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20, top: 10),
                child: const Text(
                  "Forgot Password?",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const HomePage(),
                    transitionDuration: const Duration(seconds: 1),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 2,
                    color: blue,
                  ),
                  color: blue,
                ),
                margin: const EdgeInsets.only(top: 30),
                height: 60,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have An Account?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: grey!,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const SignupPage(),
                          transitionDuration: const Duration(seconds: 1),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 5,
                      ),
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
