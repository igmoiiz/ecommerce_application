// ignore_for_file: deprecated_member_use

import 'package:ecommerce_application/Authentication/signup.dart';
import 'package:ecommerce_application/Components/my_button.dart';
import 'package:ecommerce_application/Components/my_textfield.dart';
import 'package:ecommerce_application/Interface/Pages/admin_page.dart';
import 'package:ecommerce_application/Services/Authentication%20Services/auth_services.dart';
import 'package:ecommerce_application/Services/Utilities/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //  global form state key
  final formKey = GlobalKey<FormState>();
  final formKeyAdmin = GlobalKey<FormState>();
  //  admin variables
  String email = 'khanmoaiz682@gmail.com';
  String password = '123456789';
  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationServices>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: ListView(
              children: [
                SizedBox(height: size.height * 0.09),
                Icon(
                  Icons.delivery_dining_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: MediaQuery.of(context).size.height * .075,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                Center(
                  child: Text(
                    'Welcome Back! You\'ve been Missed!',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      //  text form field for email input
                      MyTextfield(
                        labelText: 'Email..',
                        obscure: false,
                        controller: authProvider.emailController,
                        suffixIcon: null,
                      ),
                      //  text form field for password input
                      MyTextfield(
                        labelText: 'Password..',
                        obscure: true,
                        controller: authProvider.passwordController,
                        suffixIcon: null,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                Consumer<AuthenticationServices>(
                  builder: (context, value, child) {
                    return MyButton(
                      buttontext: 'Log In'.toUpperCase(),
                      onTap: () async {
                        try {
                          await value.signInWithEmailAndPassword(
                              value.emailController.text,
                              value.passwordController.text,
                              context);
                        } catch (e) {
                          throw Exception(e.toString());
                        }
                      },
                      loading: value.loading,
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a Member? ',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const RegisterPage()));
                      },
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Are You an Admin?'),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Form(
                  key: formKeyAdmin,
                  child: Column(
                    children: [
                      MyTextfield(
                        labelText: 'Email..',
                        obscure: false,
                        controller: authProvider.adminEmailController,
                        suffixIcon: null,
                      ),
                      MyTextfield(
                        labelText: 'Password..',
                        obscure: true,
                        controller: authProvider.adminPasswordController,
                        suffixIcon: null,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                MyButton(
                  buttontext: 'Admin Login',
                  onTap: () {
                    if (formKeyAdmin.currentState!.validate()) {
                      if (authProvider.adminEmailController.text == email &&
                          authProvider.adminPasswordController.text ==
                              password) {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const AdminPage()));
                      } else {
                        Utils().toastMessage(
                            'Admin Credentials Don\'t Match! Please try Again!');
                      }
                    }
                  },
                  loading: authProvider.loading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
