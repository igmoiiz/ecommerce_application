// ignore_for_file: deprecated_member_use

import 'package:ecommerce_application/Components/my_button.dart';
import 'package:ecommerce_application/Components/my_textfield.dart';
import 'package:ecommerce_application/Services/Authentication%20Services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //  form key
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider =
        Provider.of<AuthenticationServices>(context, listen: false);
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: size.height * 0.09),
              Icon(
                Icons.local_dining_sharp,
                color: Theme.of(context).colorScheme.primary,
                size: 55,
              ),
              SizedBox(height: size.height * 0.01),
              Center(
                child: Text(
                  'Let\'s Get Crazy with Shop Breeze!',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyTextfield(
                      labelText: 'Name..',
                      obscure: false,
                      controller: authProvider.nameController,
                      suffixIcon: null,
                    ),
                    MyTextfield(
                      labelText: 'City of Residence..',
                      obscure: false,
                      controller: authProvider.cityController,
                      suffixIcon: null,
                    ),
                    MyTextfield(
                      labelText: 'Email..',
                      obscure: false,
                      controller: authProvider.emailController,
                      suffixIcon: null,
                    ),
                    MyTextfield(
                      labelText: 'Password..',
                      obscure: true,
                      controller: authProvider.passwordController,
                      suffixIcon: null,
                    ),
                    MyTextfield(
                      labelText: 'Confirm Password..',
                      obscure: true,
                      controller: authProvider.confirmPassController,
                      suffixIcon: null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Consumer<AuthenticationServices>(
                builder: (context, value, child) {
                  return MyButton(
                    buttontext: 'Sign Up',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await value.signUpWithEmailAndPassword(
                              value.emailController.text,
                              value.passwordController.text,
                              context);
                        } catch (e) {
                          throw Exception(e.toString());
                        }
                      }
                    },
                    loading: value.loading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
