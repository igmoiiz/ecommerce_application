import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application/Services/Authentication Services/auth_services.dart';
import 'package:ecommerce_application/Services/Utilities/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class CategoriesServices extends ChangeNotifier {
  // instance for firebase authentication class
  final authServices = AuthenticationServices();
  // instance for firebase fire store
  final fireStore = FirebaseFirestore.instance;
  //  instance for firebase storage
  storage.FirebaseStorage firebaseStorage = storage.FirebaseStorage.instance;
  //  image variable for storing file image
  File? _image;
  //  loading variable for loading
  bool _loading = false;
  //  text controllers
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _materialController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  //  selected item index
  String? selectedItem;
  //  list for dropdown button
  final List<String> items = [
    'Boots',
    'Joggers',
    'Chelsea Boots',
    'Sneakers',
    'Football Shoes',
    'Crocks',
    'Heels',
    'Gym Wear',
    'Women',
  ];
  //  list for categories
  final List listCategory = [
    ['Assets/chelse boots.jpg', 'Chelsea Boots', 'Chelsea Boots'],
    ['Assets/joggers.jpg', 'Joggers', 'Joggers'],
    ['Assets/leather boots.jpg', 'Leather Boots', 'Boots'],
    ['Assets/sneakers.jpg', 'Sneakers', 'Sneakers'],
    ['Assets/women.jpg', 'Women Wear', 'Women'],
    ['Assets/crocks.jpg', 'Crocks', 'Crocks'],
    ['Assets/football shoes.jpg', 'FootBall Shoes', 'Football Shoes'],
    ['Assets/gym wear.jpg', 'Gym Wear', 'Gym Wear'],
    ['Assets/heels.jpg', 'Heels', 'Heels'],
  ];

  //  getter for image variable
  File? get image => _image;
  //  getter for loading  variable
  bool get loading => _loading;
  //  getters for controllers
  TextEditingController get categoryController => _categoryController;
  TextEditingController get materialController => _materialController;
  TextEditingController get priceController => _priceController;
  TextEditingController get brandController => _brandController;
  TextEditingController get descriptionController => _descriptionController;

  // method to select image from the gallery
  Future<void> getImageFromGallery() async {
    // instance for image picker
    final picker = ImagePicker();
    //  picking the file from the gallery
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      //  checking if the file is picked or not
      if (pickedFile != null) {
        //  setting the picked file to the image variable
        _image = File(pickedFile.path);
        notifyListeners();
        Utils().toastMessage('Image Selected!');
      } else {
        Utils().toastMessage('No image selected!');
      }
    } on Exception catch (e) {
      Utils().toastMessage('Error selecting image: $e');
    } finally {
      notifyListeners();
    }
  }

  // method to post the image to firebase along with its description and pricing
  Future<void> uploadItemToDatabase(String collectionName) async {
    //  id for firebase storage and fire store documents
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    //  checking if the image is selected
    if (_image == null) {
      Utils().toastMessage('Please Select an Image!');
      notifyListeners();
      return;
    }
    if (priceController.text.isEmpty ||
        materialController.text.isEmpty ||
        brandController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      Utils().toastMessage('Please fill all fields!');
      notifyListeners();
      return;
    }
    try {
      //  setting the loading variable to true
      _loading = true;
      notifyListeners();
      //  firebase storage reference
      storage.Reference ref = storage.FirebaseStorage.instance.ref('Shoes/$id');
      //  uploading the image to firebase storage
      storage.UploadTask uploadTask = ref.putFile(_image!);
      await uploadTask.whenComplete(() async {
        //  getting the url of the image we just uploaded
        var imageUrl = await ref.getDownloadURL();
        //  storing the data into the database ny categories
        await fireStore.collection(collectionName).doc(id).set({
          'imageUrl': imageUrl,
          'price': priceController.text,
          'material': materialController.text,
          'category': selectedItem,
          'brand': brandController.text,
          'description': descriptionController.text,
          'id': id,
        }).then((value) {
          //  clearing the controllers and setting loading to false
          priceController.clear();
          materialController.clear();
          brandController.clear();
          descriptionController.clear();
          _image = null;
          _loading = false;
          notifyListeners();
          Utils().toastMessage('Product Uploaded Successfully!');
        }).onError((error, stackTrace) {
          //  setting the loading variable to false and displaying the catch error
          _loading = false;
          notifyListeners();
          Utils().toastMessage(error.toString());
        });
      }).onError((error, stackTrace) {
        //  setting the loading variable to false and displaying the catch error
        _loading = false;
        notifyListeners();
        throw Exception(error.toString());
      });
    } on Exception catch (e) {
      _loading = false;
      notifyListeners();
      throw Exception('Error uploading product: $e');
    }
  }

  //  method to dele a upload
  Future<void> deletePost(String postId) async {
    try {
      _loading = true;
      notifyListeners();
      await fireStore
          .collection('INVENTORY')
          .doc(postId)
          .delete()
          .then((value) {
        _loading = false;
        notifyListeners();
        Utils().toastMessage('Post Deleted Successfully!');
      }).onError((error, stackTrace) {
        _loading = false;
        notifyListeners();
        Utils().toastMessage(error.toString());
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
