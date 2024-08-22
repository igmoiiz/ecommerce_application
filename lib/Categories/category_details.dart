// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use

import 'package:ecommerce_application/Categories/categories_services.dart';
import 'package:ecommerce_application/Components/custom_stream_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  var collectionName2;
  CategoryDetails({super.key, required this.collectionName2});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text(
              'Find your breeze at Shop Breeze...',
              style: TextStyle(
                fontSize: 40,
                letterSpacing: 2,
                fontFamily: GoogleFonts.bebasNeue().fontFamily,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Divider(
              color: Colors.grey.shade500,
            ),
            SizedBox(height: size.height * 0.01),
            Consumer<CategoriesServices>(
              builder: (context, value, child) {
                return CustomStreamUser(
                  onTap: () {},
                  collectionName: widget.collectionName2,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
