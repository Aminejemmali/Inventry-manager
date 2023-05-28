import 'dart:convert';
import 'package:ecomme_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Product> products;

   CheckoutScreen({required this.products});
 final List<Product> articles=[];
  @override
  void initState() {
    // TODO: implement setState
   
    
  }

  @override
  Widget build(BuildContext context) {
      
   final List<Product> articles=List.from(products) ;
    articles.removeWhere((item) => item.quantity ==0);
    
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Facture'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              _printInvoice(context);
            },
          ),
        ],
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(8),
           separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ListTile(
            
           shape: RoundedRectangleBorder( //<-- SEE HERE
       side: BorderSide(width: 2),
    borderRadius: BorderRadius.circular(20),

  ),
  
            title: Text(articles[index].name,style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
            subtitle: Text('Quantitée: ${articles[index].quantity}',style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
            trailing: Text(
              'Prix Total: \dt ${articles[index].totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 21,color: Color.fromARGB(255, 255, 255, 255)),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Prix Total: \dt ${_calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(
                
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _calculateTotalPrice() {
    final List<Product> articles=List.from(products) ;
    articles.removeWhere((item) => item.quantity ==0);
    double totalPrice = 0;
    for (var article in articles) {
      totalPrice += article.totalPrice;
    }
    return totalPrice;
  }

 pw.Widget buildInvoiceDate() {
  final List<Product> articles=List.from(products) ;
    articles.removeWhere((item) => item.quantity ==0);
  final currentDate = DateTime.now();
  final formattedDate = '${currentDate.day}/${currentDate.month}/${currentDate.year}';

  return pw.Text('Date: $formattedDate', style: pw.TextStyle(fontSize: 14));
}

  Future<void> _printInvoice(BuildContext context) async {
    final List<Product> articles=List.from(products) ;
    articles.removeWhere((item) => item.quantity ==0);
   var img = await imageFromAssetBundle('lib/assests/images/logo1.png');
  /*final bytes = File( "lib/assests/images/logo.png").readAsBytesSync();
  final imageProvider = pw.MemoryImage(bytes);*/
    final headers = ['Produit', 'Quantités', 'prix total'];
    final data = articles.map((article) {
      return [article.name, article.quantity.toString(), '\dt ${article.totalPrice.toStringAsFixed(2)}'];
    }).toList();

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children:[
              pw.Row(
                children:[
              pw.Column(
                children:[
              pw.Container(
                alignment: pw.Alignment.bottomLeft,
                child:pw.Image(img),height: 40,width: 40),
              
            pw.Container(
            alignment: pw.Alignment.bottomLeft,
            child: pw.Text('Entreprise : Tunisie Telecom'),),
            pw.Container(
            alignment: pw.Alignment.bottomLeft,
           child: pw.Text('Address : Rue de Cordoue 5100 Mahdia '),),
           pw.Container(
            alignment: pw.Alignment.bottomLeft,
            child:pw.Text('Tel : 73 681 222 /73 681 333'),),
            pw.SizedBox(height: 30),
            pw.SizedBox(width: 50),
                ],),
                pw.SizedBox(width: 50),
                pw.SizedBox(width: 50),
                pw.Column(
                children:[
            
              
            pw.Container(
            alignment: pw.Alignment.bottomRight,
            child: pw.Text('NUM Facture : 78550'),),
            pw.Container(
            alignment: pw.Alignment.bottomRight,
           child: buildInvoiceDate(),),
           pw.Container(
            alignment: pw.Alignment.bottomRight,
            child:pw.Text('Client : '),),
            pw.SizedBox(height: 30),
                ],),]),
          pw.Table.fromTextArray(
            headers: headers,
            data: data,
            
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.centerLeft,
            cellAlignments: {0: pw.Alignment.centerLeft},
            border: pw.TableBorder.all(),
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
            defaultColumnWidth: pw.IntrinsicColumnWidth(),
          ),
          pw.SizedBox(height: 20),
          pw.Container(
            alignment: pw.Alignment.centerRight,
          child:pw.Text('Prix Total: \dt ${_calculateTotalPrice().toStringAsFixed(2)}'),),
          
      
      
      
      
      ]);
          
        },
      ),
    );

    final pdfData = await pdf.save();
    await Printing.sharePdf(
      bytes: pdfData,
      filename: 'invoice.pdf',
      
    );
  }
}
