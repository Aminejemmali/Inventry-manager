import 'dart:convert';

import 'dart:math';

import 'package:ecomme_app/models/product.dart';
import 'package:ecomme_app/screens/productlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddProductPage extends StatelessWidget {
    final List<Product> products;
   AddProductPage({required this.products});
    final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  TextEditingController designationController = TextEditingController();

  TextEditingController unitController = TextEditingController();

  TextEditingController priceController = TextEditingController();
   /* Future <void> addproduct() async {
    var request = http.MultipartRequest('POST', Uri.parse('https://localhost:3000/Article/Admin/AddArticle'));
    request.fields.addAll({
      'name': nameController.text,
      'designation': designationController.text,
      'unite': unitController.text,
      'price': priceController.text,
      
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var s = await response.stream.bytesToString();
      Map<String, dynamic> data1 = json.decode(s);
      if (data1['status'] == 'Success') {
        //Or put here your next screen using Navigator.push() method
      
      MaterialPageRoute(
        builder: (context) => ProductListScreen(),
      );
  }
      else{
        print('erreur');
      }

    }
}*/
  void add() async{
     if (_formKey.currentState!.validate()) {
                String name = nameController.text;
                String designation = designationController.text;
                String unit = unitController.text;
                double price = double.tryParse(priceController.text) ?? 0.0;

                // Perform any further actions with the entered data
                
               // addproduct();
  

                // Clear the text fields
                nameController.clear();
                designationController.clear();
                unitController.clear();
                priceController.clear();
              }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                
              ),
               validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a name';
          }
          return null;
        },
            ),
            TextFormField(
              controller: designationController,
              decoration: InputDecoration(
                labelText: 'Designation',
              ),
              validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a name';
          }
          return null;
        },
            ),
            TextFormField(
              controller: unitController,
              decoration: InputDecoration(
                labelText: 'Unit',
              ),
               validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a name';
          }
          return null;
        },
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
               validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a name';
          }
          return null;
        },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async{
                add();
                },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
