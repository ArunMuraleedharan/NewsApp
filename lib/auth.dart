


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:google_fonts/google_fonts.dart';

import 'LoginPage.dart';
import 'main.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _auth=FirebaseAuth.instance;
  var isLoading=false;



  void _submitAuthForm(String email,String password,String username,bool isLoging,WidgetRef ref) async
  {

    if(isLoging)
      {
        await ref.read(authServicesProvider).signIn(email: email, password: password);
      }
    else
      {
        await ref.read(authServicesProvider).signUp(email: email, password: password);
      }

  }
  // void _submitAuthForm(String email,String password,String username,bool isLoging,BuildContext ctx) async
  // {
  //   if(mounted)
  //   {
  //     setState(() {
  //       isLoading=true;
  //     });
  //   }
  //
  //
  //   UserCredential authResult;
  //   try{
  //     if(isLoging)
  //     {
  //       authResult=await _auth.signInWithEmailAndPassword(email: email, password: password);
  //       setState(() {
  //         isLoading=false;
  //       });
  //     }
  //     else
  //     {
  //       authResult=await _auth.createUserWithEmailAndPassword(email: email,password: password);
  //       await FirebaseFirestore.instance.collection("User/").doc(authResult.user!.uid.toString()+"/").set({'email':email,'username':username});
  //       setState(() {
  //         isLoading=false;
  //       });
  //     }
  //
  //   }
  //   on PlatformException catch(err)
  //   {
  //     if(mounted)
  //     {
  //       setState(() {
  //         isLoading=false;
  //       });
  //     }
  //
  //     String message="An error occured plaese check your credential";
  //     if(err.message!=null)
  //     {
  //       message=err.message.toString();
  //     }
  //     Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.deepOrange,));
  //     print(message);
  //
  //   }
  //   catch(err)
  //   {
  //     print(err.toString());
  //     if(mounted)
  //     {
  //       setState(() {
  //         isLoading=false;
  //       });
  //     }
  //
  //   }
  //
  // }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome",style: GoogleFonts.darkerGrotesque(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 40,wordSpacing:0))),
          AuthForm(submitFn: _submitAuthForm,isLogin: isLoading,),
        ],
      ),

    );
  }
}
