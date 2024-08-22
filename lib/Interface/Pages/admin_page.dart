import 'package:ecommerce_application/Categories/categories_services.dart';
import 'package:ecommerce_application/Components/my_button.dart';
import 'package:ecommerce_application/Components/my_textfield.dart';
import 'package:ecommerce_application/Services/Authentication%20Services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //  form key
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //  category provider
    final categoryProvider = Provider.of<CategoriesServices>(context,
        listen: false); //  authentication provider
    final authProvider =
        Provider.of<AuthenticationServices>(context, listen: false);
    //  size variable
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Admin Panel'.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      //  end drawer
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              const Spacer(),
              const Divider(),
              ListTile(
                title: const Text('Good Bye! See Ya!'),
                onTap: () async {
                  //  sign out
                  await authProvider.signUserOut(context);
                },
                leading: Icon(
                  Icons.logout_sharp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
      //  body
      body: ListView(
        children: [
          SizedBox(height: size.height * 0.02),
          Consumer<CategoriesServices>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () {
                    value.getImageFromGallery();
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    child: Center(
                      child: value.image != null
                          ? Image.file(value.image!.absolute)
                          : Icon(
                              Icons.image,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: size.height * 0.02),
          Form(
            key: formKey,
            child: Column(
              children: [
                MyTextfield(
                  labelText: 'Brand Name..',
                  obscure: false,
                  controller: categoryProvider.brandController,
                  suffixIcon: null,
                ),
                MyTextfield(
                  labelText: 'Material of Shoe..',
                  obscure: false,
                  controller: categoryProvider.materialController,
                  suffixIcon: null,
                ),
                MyTextfield(
                  labelText: 'Price of Item..',
                  obscure: false,
                  controller: categoryProvider.priceController,
                  suffixIcon: null,
                ),
                MyTextfield(
                  labelText: 'Description of Item..',
                  obscure: false,
                  controller: categoryProvider.descriptionController,
                  suffixIcon: null,
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: DropdownButtonFormField<String>(
                    value: categoryProvider.selectedItem,
                    items: categoryProvider.items.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        categoryProvider.selectedItem = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select a Category',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Consumer<CategoriesServices>(
            builder: (context, value, child) {
              return MyButton(
                buttontext: 'Get Live',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    value.uploadItemToDatabase(value.selectedItem.toString());
                  }
                },
                loading: value.loading,
              );
            },
          ),
        ],
      ),
    );
  }
}
