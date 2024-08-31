// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use

import 'package:ecommerce_application/Cart%20Page/cart.dart';
import 'package:ecommerce_application/Categories/categories_services.dart';
import 'package:ecommerce_application/Components/custom_stream_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
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
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => const CartPage()));
              },
              icon: Badge(
                label: Text(itemCount.toString()),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                ),
              ),
            ),
          ),
        ],
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
