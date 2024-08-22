// ignore_for_file: deprecated_member_use

import 'package:ecommerce_application/Categories/categories_services.dart';
import 'package:ecommerce_application/Categories/category_details.dart';
import 'package:ecommerce_application/Components/category_container.dart';
import 'package:ecommerce_application/Services/Authentication%20Services/auth_services.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InterfacePage extends StatefulWidget {
  const InterfacePage({super.key});

  @override
  State<InterfacePage> createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider =
        Provider.of<AuthenticationServices>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        //  App Bar
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        //  End Drawer
        endDrawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Divider(),
                ListTile(
                  onTap: () async {
                    try {
                      await authProvider.signUserOut(context);
                    } catch (e) {
                      throw Exception(e.toString());
                    }
                  },
                  title: const Text('Good Bye! See Ya!'),
                  leading: Icon(
                    Icons.logout_sharp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        //  Body
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Text(
                'Your shopping breeze starts here.',
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories'.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Consumer<CategoriesServices>(
                builder: (context, value, child) {
                  return Expanded(
                    child: MasonryGridView.builder(
                      itemCount: value.items.length,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Expanded(
                          child: CategoryContainer(
                            imageUrl: value.listCategory[index][0],
                            text: value.listCategory[index][1],
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => CategoryDetails(
                                    collectionName2: value.listCategory[index]
                                        [2],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
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
