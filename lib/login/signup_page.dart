import 'package:flutter/material.dart';
import 'package:tailor_book/login/login_page.dart';

import '../colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var hide = true;
  var hide2 = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPswController = TextEditingController();
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
              "Create An Account",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Sign Up Now To Get Started With An Account",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: grey!,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "Name",
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
                controller: nameController,
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
                  hintText: "Enter Your Name",
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
              margin: const EdgeInsets.only(left: 20, top: 10),
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
              margin: const EdgeInsets.only(left: 20, top: 10),
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
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "Confirm Password",
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
                obscureText: hide2 == true ? true : false,
                controller: confirmPswController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (hide2 == true) {
                          hide2 = false;
                        } else {
                          hide2 = true;
                        }
                      });
                    },
                    child: Icon(
                      hide2 == true
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
                  hintText: "Confirm Password",
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
              onTap: () {},
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
                      "SignUp",
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
                    "Already Have An Account?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: grey!,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
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
                      margin: const EdgeInsets.only(
                        left: 5,
                      ),
                      child: const Text(
                        "Login",
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
