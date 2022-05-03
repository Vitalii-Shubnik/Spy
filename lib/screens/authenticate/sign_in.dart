import 'package:flutter/material.dart';
import 'package:spy_project/services/auth.dart';
import 'package:spy_project/shared/Loading.dart';
import 'package:spy_project/shared/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleSignType}) : super(key: key);
  final Function toggleSignType;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(key: UniqueKey()) : Scaffold(
      backgroundColor: secondaryDarkGreyColor,
      appBar: AppBar(
        backgroundColor: mainDarkGreyColor,
        elevation: 0.0,
        title: Text("Sign In to Spy"),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person, color: Colors.white,),
            label: Text('Register', style: TextStyle(color: Colors.white)),
            onPressed: (){
              widget.toggleSignType();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                style: textInputStyle,
                validator: (String? val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                setState(() {
                  email = val;
                });
              }),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                style: textInputStyle,
                validator: (String? val) => val!.length < 6? 'password must be 6 symbols long or more' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  }),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Sign in'),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(accentRedColor)),
                onPressed: () async {
                  if (_formKey.currentState?.validate() != null) {
                  setState(() => loading = true);
                  dynamic result = await _auth.signInWithEmail(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Incorrect email or password';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
