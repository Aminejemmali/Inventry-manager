import 'dart:convert';
import 'package:ecomme_app/models/product.dart';
import 'package:ecomme_app/screens/addproduct.dart';
import 'package:ecomme_app/screens/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:async';
import 'dart:convert';
class productlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Liste Produits',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListScreen(),
    );
  }
}



class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    // Fetch product data from JSON
    String json = '''
      [
        {"id":"1","name": "Product 1","Designation":"GFT01","unité":"045", "price": 10.0},
        {"id":"2","name": "Product 2","Designation":"GFT02","unité":"25", "price": 15.0},
        {"id":"3","name": "Product 3","Designation":"GFT03","unité":"478", "price": 20.0},
        {"id":"4","name": "Product 4","Designation":"GFT04","unité":"14", "price": 20.0},
        {"id":"5","name": "Product 5","Designation":"GFT05","unité":"03", "price": 20.0},
        {"id":"6","name": "Product 6","Designation":"GFT06","unité":"65", "price": 20.0}
      ]
    ''';
    
    productList = List<Product>.from(
      jsonDecode(json).map((product) => Product(
            id:product['id'] ,
            name: product['name'],
            designation: product['Designation'],
            unite: product['unité'],
            price: product['price'],
          )),
    );
    //hadhi fintion get all article from api response
    
  /*int longarticles =0;
  Future getData() async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://localhost:3000/Article/Admin/AllArticles'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var s=await response.stream.bytesToString();
      Map<String, dynamic> data1 = jsonDecode(s);
      if(data1['status']=='Success'){
        List data2 = jsonDecode(data1['articles']);
        if(mounted){
        setState(() {
          longarticles =data2.length;
          for(int i=0;i<longarticles;i++) {
            var id = data2[i]['_id'];
            var N = data2[i]['Articles'];
            var D =data2[i]['Designation'];
           var U= data2[i]['Unité'];
            var P=data2[i]['PUHT'];
            Product product =  Product(id:id, name: N ,designation:D,unite: U,price: P );
            productList.add(product);
          }

        });}
      }
      else{
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.BOTTOMSLIDE,
          title:'Error Connection' ,
          desc: data1['Reponse'],
          titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900,),
          descTextStyle: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w900,),
          buttonsTextStyle:TextStyle(color: Colors.black,fontSize: 15),
          btnOkText: 'Ok',
          btnOkOnPress: () {},
        )..show();
      }
    }
    else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title:'Error Connection' ,
        desc: response.reasonPhrase,
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900,),
        descTextStyle: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w900,),
        buttonsTextStyle:TextStyle(color: Colors.black,fontSize: 15),
        btnOkText: 'Ok',
        btnOkOnPress: () {},
      )..show();
    }
  }*/

  }

  void addProduct() {
    setState(() {
      productList.add(Product(id:'5',name: 'CocaCola',designation: "aa",unite: "aa", price: 200.0));
    });
  }

  void deleteProduct(int index) {
    setState(() {
      productList.removeAt(index);
    });
  }

  void checkout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(products: productList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
       backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange[80],
        title: Text('Liste Produits'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Card(
             shape: RoundedRectangleBorder( //<-- SEE HERE
       side: BorderSide(width: 2),
    borderRadius: BorderRadius.circular(20),

  ),
            color: Colors.white,
            shadowColor: Colors.black,
            
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(productList[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productList[index].designation),
                  SizedBox(height: 4),
                  Text(productList[index].unite),
                  SizedBox(height: 4),
                  Text('Prix: \dt ${productList[index].price.toStringAsFixed(2)}'),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Quantitée:'),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              productList[index].quantity = int.parse(value);
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Total Price: \dt ${productList[index].totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteProduct(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
           Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductPage(products: productList),
      ),
    );
          //addProduct();
        },
      ),

  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  bottomNavigationBar: BottomAppBar(
    child: Container(
      height: 50.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Text(
              
              'Total Price: \dt ${_calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                
                fontSize: 21,color: Colors.orange[60]
              ),
            ),
            ElevatedButton(
              child: Text('Checkout',
              style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.bold),),
              onPressed: checkout,
            ),
          ],
        ),
      ),
    ),
  ),
);
}

double _calculateTotalPrice() {
double totalPrice = 0;
for (var product in productList) {
totalPrice += product.totalPrice;
}
return totalPrice;
}
}



