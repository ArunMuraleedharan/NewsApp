import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:core';

import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/main.dart';


class AuthForm extends ConsumerStatefulWidget {

  AuthForm({ required this.submitFn, required this.isLogin});
  final void Function(String email,String password,String username,bool isLoging,WidgetRef ref) submitFn;
  final bool isLogin;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {

  final _formKey=GlobalKey<FormState>();
  bool logIn=true;
  String _userEmail='';
  String _userUsername='';
  String _userPassword='';

  void _trySubmit()
  {

    final isvalid=_formKey.currentState!.validate();

    if(isvalid)
    {
      _formKey.currentState!.save();
      print(_userEmail);
      print(_userUsername);
      print(_userPassword);
      widget.submitFn(_userEmail.trim(),_userPassword.trim(),_userUsername.trim(),logIn,ref);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          side: new BorderSide( width: 2.0),
        borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                 // style: TextStyle(color: Color.fromARGB(255, 255, 255, 0)),
                 //  decoration: InputDecoration(fillColor: Colors.orange, filled: true),
                  key: ValueKey("useremail"),
                  validator: (value){
                    if(value!.isEmpty|| !value.contains('@'))
                    {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    labelStyle: GoogleFonts.darkerGrotesque(textStyle: TextStyle(color: Color.fromARGB(255,0,0,0),fontWeight: FontWeight.w400,fontSize: 25,wordSpacing:0))
                  ),
                  onSaved: (val){
                     _userEmail=val!;
                  },
                ),
                if(!logIn)
                  TextFormField(
                    key:ValueKey("username"),
                    validator: (value){
                      if( value!.length<4)
                      {
                        return 'Please Enter userId with 4 char atleast';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                    onSaved: (val){
                      _userUsername=val!;
                    },
                  ),
                TextFormField(
                  key:ValueKey("password"),
                  validator: (value){
                    if(value!.length<7)
                    {
                      return'Password atleast 7 char long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                      labelStyle: GoogleFonts.darkerGrotesque(textStyle: TextStyle(color: Color.fromARGB(255,0,0,0),fontWeight: FontWeight.w400,fontSize: 25,wordSpacing:0))
                  ),
                  obscureText: true,
                  onSaved: (val){
                    _userPassword=val!;
                  },
                ),
                SizedBox(height: 20,),
                MaterialButton(
                  child:widget.isLogin?CircularProgressIndicator():Text("Login",style: GoogleFonts.darkerGrotesque(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 25,wordSpacing:0)),) ,
                  color: Colors.black,
                  onPressed: (){_trySubmit();},
                ),
                MaterialButton(
                  color: Colors.blue,
                    onPressed: (){
                      ref.read(google_login).googleLogin();

                    },
                  child: Text("Google Sign In"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

