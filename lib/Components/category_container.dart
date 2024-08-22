// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  String text;
  String imageUrl;
  VoidCallback onTap;
  CategoryContainer({
    super.key,
    required this.imageUrl,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                text.toUpperCase(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
