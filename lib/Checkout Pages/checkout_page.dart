import 'package:ecommerce_application/Checkout%20Pages/checkout_services.dart';
import 'package:ecommerce_application/Components/my_button.dart';
import 'package:ecommerce_application/Components/my_textfield.dart';
import 'package:ecommerce_application/Services/Utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutServices =
        Provider.of<CheckoutServices>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Icon(
              Icons.shopping_cart_checkout_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 45,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Check Out',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Form(
              key: checkoutServices.formKey,
              child: Column(
                children: [
                  MyTextfield(
                    labelText: 'Name',
                    obscure: false,
                    controller: checkoutServices.customerNameController,
                    suffixIcon: null,
                  ),
                  MyTextfield(
                    labelText: 'Address',
                    obscure: false,
                    controller: checkoutServices.customerAddressController,
                    suffixIcon: null,
                  ),
                  MyTextfield(
                    labelText: 'Email',
                    obscure: false,
                    controller: checkoutServices.customerEmailController,
                    suffixIcon: null,
                  ),
                  MyTextfield(
                    inputType: TextInputType.number,
                    labelText: 'Contact Number',
                    obscure: false,
                    controller: checkoutServices.customerPhoneController,
                    suffixIcon: null,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            MyButton(
              buttontext: 'Place Order',
              onTap: () {
                if (checkoutServices.formKey.currentState!.validate()) {
                  checkoutServices.confirmOrder();
                } else {
                  Utils().toastMessage('Please fill all Fields!');
                }
              },
              loading: checkoutServices.loading,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Happy Shopping! Come Back Soon!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
