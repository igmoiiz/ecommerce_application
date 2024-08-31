// ignore_for_file: deprecated_member_use

import 'package:ecommerce_application/Checkout%20Pages/checkout_page.dart';
import 'package:ecommerce_application/Components/cart_tile_widget.dart';
import 'package:ecommerce_application/Components/empty_cart_msg_widget.dart';
import 'package:ecommerce_application/Components/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PersistentShoppingCart().showCartItems(
                cartTileWidget: ({required data}) => CartTileWidget(data: data),
                showEmptyCartMsgWidget: const EmptyCartMsgWidget(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                color: Colors.grey.shade900,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PersistentShoppingCart().showTotalAmountWidget(
                    cartTotalAmountWidgetBuilder: (totalAmount) {
                      return Visibility(
                        visible: totalAmount == 0.0 ? false : true,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total:',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                ),
                                Text(
                                  totalAmount.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            MyButton(
                              buttontext: 'CheckOut',
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) =>
                                        const CheckOutPage()));
                              },
                              loading: false,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
