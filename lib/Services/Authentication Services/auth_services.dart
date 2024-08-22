// ignore_for_file: avoid_print, prefer_final_fields

import 'package:ecommerce_application/Authentication/login.dart';
import 'package:ecommerce_application/Interface/Pages/interface_page.dart';
import 'package:ecommerce_application/Services/Utilities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationServices extends ChangeNotifier {
  //  instance for firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //  loading variable
  bool _loading = false;
  //  controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _adminEmailController = TextEditingController();
  final TextEditingController _adminPasswordController =
      TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();


  //  getters for controllers
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get adminEmailController => _adminEmailController;
  TextEditingController get adminPasswordController => _adminPasswordController;
  TextEditingController get nameController => _nameController;
  TextEditingController get confirmPassController => _confirmPassController;
  TextEditingController get cityController => _cityController;

  //  getter for firebase authentication
  FirebaseAuth get auth => _auth;
  //  getter for loading variable
  bool get loading => _loading;

  //  sign in
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      //  setting the loading variable to true for loading progress indicator
      _loading = true;
      notifyListeners();
      //  signing the user into the account
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        //  setting the loading variable to false after successful sign in
        _loading = false;
        _emailController.clear();
        _passwordController.clear();
        notifyListeners();
        //  navigation
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (context) => const InterfacePage()));
        //  user information
        Utils().toastMessage(
            'Successfully Signed In As ${auth.currentUser!.email}');
      }).onError((error, stacktrace) {
        //  setting the loading variable to false after a failed sign in attempt
        _loading = false;
        notifyListeners();
        //  show the error to the user
        Utils().toastMessage(error.toString());
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //  sign up
  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      //  setting the loading variable to true for loading animation
      _loading = true;
      notifyListeners();
      //  signing up the user into the application
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        //  setting the loading variable to false after successful sign in
        _loading = false;
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPassController.clear();
        _cityController.clear();
        notifyListeners();
        //  navigation
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (context) => const InterfacePage()));
        //  user information
        Utils().toastMessage(
            'Successfully Signed Up and Signed In As ${auth.currentUser!.email}');
      }).onError((error, stacktrace) {
        //  setting the loading variable to false after a failed sign in attempt
        _loading = false;
        notifyListeners();
        //  show the error to the user
        Utils().toastMessage(error.toString());
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //  logout
  Future<void> signUserOut(BuildContext context) async {
    try {
      _loading = true;
      notifyListeners();
      await auth.signOut().then((value) {
        _loading = false;
        notifyListeners();
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => const LoginPage()));
        Utils().toastMessage(
            'Signed Out Successfully as ${auth.currentUser!.email}');
      }).onError((error, stackTrace) {
        _loading = false;
        notifyListeners();
        Utils().toastMessage(error.toString());
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
//                                          end{code}