import 'package:flutter/material.dart';

import '../services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({ required this.toggleView });
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  //Text field state
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Sign in to continue'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),

              TextFormField(    //email
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(  //password
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });

                },
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null) {
                      setState(() {
                      error = 'Could not sign in with those credentials';
                      });

                  }
                  }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Background
                    foregroundColor: Colors.white, // Foreground
                  ),
                  child: Text('Sign in',
                  style: TextStyle(color: Colors.white),))
            ],
          )
        ),

      )
    );
  }
}
