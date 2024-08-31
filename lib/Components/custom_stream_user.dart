// ignore_for_file: must_be_immutable

import 'package:ecommerce_application/Categories/categories_services.dart';
import 'package:ecommerce_application/Components/network_image_widget.dart';

import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
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
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                NetworkImageWidget(
                                  imageUrl: snapshot.data!.docs[index]
                                      ['imageUrl'],
                                  height: 100,
                                  width: 100,
                                  borderRadius: 8,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['brand'],
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5,
                                          fontSize: 19,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            ['description'],
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                        ),
                                      ),
                                      Text(
                                        'Rs. ${snapshot.data!.docs[index]['price']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                        ),
                                      ),
                                      PersistentShoppingCart()
                                          .showAndUpdateCartItemWidget(
                                        notInCartWidget: Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text('Add to Cart',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                        ),
                                        inCartWidget: Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text('Remove',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                        ),
                                        product: PersistentShoppingCartItem(
                                            productId: snapshot
                                                .data!.docs[index]['id'],
                                            productName: snapshot
                                                .data!.docs[index]['brand'],
                                            unitPrice: double.parse(snapshot
                                                .data!.docs[index]['price']
                                                .toString()),
                                            productThumbnail: snapshot
                                                .data!.docs[index]['imageUrl'],

                                                
                                            quantity: 1,
                                            productDescription: snapshot.data!
                                                .docs[index]['description']),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
