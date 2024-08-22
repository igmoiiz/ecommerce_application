// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttontext;
  final VoidCallback onTap;
  final bool loading;
  const MyButton({
    super.key,
    required this.buttontext,
    required this.onTap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 60,
            ),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: loading
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .41,
                        vertical: MediaQuery.of(context).size.height * .015),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Center(
                    child: Text(
                    buttontext,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Theme.of(context).colorScheme.onBackground),
                  )),
          ),
        ));
  }
}
