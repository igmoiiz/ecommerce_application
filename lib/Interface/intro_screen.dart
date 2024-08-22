import 'package:ecommerce_application/Authentication/login.dart';
import 'package:ecommerce_application/Components/my_button.dart';
import 'package:ecommerce_application/Services/Authentication%20Services/auth_services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  //  instance for authentication Services
  final authServices = AuthenticationServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Shop Breeze',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Lottie.asset('Assets/Animation - 1723573337820.json'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          MyButton(
            buttontext: 'Get Started',
            onTap: () {
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => const LoginPage()));
            },
            loading: authServices.loading,
          ),
        ],
      ),
    );
  }
}
