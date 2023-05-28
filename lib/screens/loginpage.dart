

import 'package:ecomme_app/screens/productlist.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      String email = _emailController.text;
      String password = _passwordController.text;
      // You can add your login logic here, like making an API call

      // Example validation
      if (email == 'admin@gmail.com' && password == '1234') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Connexion avec succés !!'),
              content: Text('Bienvenue, $email!'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                     Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => productlist()
        ),
      );
                  },
                ),
              ],
            );
          },
        );
      } 
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Connexion échouée'),
              content: Text('email ou mdp incorrect.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Connexion'),

        
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                child:Image.asset(
              "lib/assests/images/logo1.png",
              height: 150,
              width: 200,
            ),),
              SizedBox(height: 10,),
              TextFormField(

                controller: _emailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  focusColor: Colors.black,
                  label: const Text("Email"
                  ,style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold,),),
                  hintText: 'tapez votre Email',
                  border: OutlineInputBorder(
                   
      borderRadius: BorderRadius.circular(30),
    ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'svp tapez votre email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
              
                controller: _passwordController,
                decoration: InputDecoration(
                  icon: Icon(Icons.password),
                  label: const Text("Mot de passe"
                   ,style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold,),),
                  hintText: 'tapez votre mdp',
                  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'svp tapez votre mdp';
                  }
                  return null;
                },
              ),
              SizedBox(height: 21),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
           backgroundColor: Colors.black54,// set the background color
         fixedSize:Size(40, 50),
         
     ),
                onPressed: _submitForm,
                child: Text('Connecter',style: TextStyle(color:Colors.blue , fontSize: 24,fontWeight: FontWeight.bold,),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
