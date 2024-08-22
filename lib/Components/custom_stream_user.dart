// ignore_for_file: must_be_immutable

import 'package:ecommerce_application/Categories/categories_services.dart';
import 'package:ecommerce_application/Components/cart_button.dart';

import 'package:ecommerce_application/Components/reusable_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CustomStreamUser extends StatelessWidget {
  String collectionName;
  VoidCallback onTap;
  CustomStreamUser({
    super.key,
    required this.collectionName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesServices>(
      builder: (context, value, child) {
        return StreamBuilder(
          stream: value.fireStore.collection(collectionName).snapshots(),
          builder: (context, snapshot) {
            //  checking if the data is being loaded
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }
            //  checking if there is any error
            if (snapshot.hasError) {
              return Center(
                child: Text('Error ${snapshot.error}'),
              );
            }
            //  returning list view builder
            return Expanded(
              child: MasonryGridView.builder(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: onTap,
                    child: Card(
                      color: Theme.of(context).colorScheme.surface,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image(
                                image: NetworkImage(
                                  snapshot.data!.docs[index]['imageUrl'],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .01),
                          ReusableRow(
                            title: 'Brand Name',
                            value: snapshot.data!.docs[index]['brand'],
                          ),
                          ReusableRow(
                            title: 'Price in RS.',
                            value: snapshot.data!.docs[index]['price'],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .01),
                          CartButton(
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
