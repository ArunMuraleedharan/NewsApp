import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:newsapp/HomeScreen.dart';
import 'package:newsapp/provider/FirebaseProvider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newsapp/provider/google_signin.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child:MyApp()));
}

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authServicesProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(ref.read(firebaseAuthProvider));
});

final authStateProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(authServicesProvider).authStateChange;
});

final google_login=ChangeNotifierProvider((ref)=>GoogleSignInProvider());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splashscreen()
    );
  }
}

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    startpage()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: Colors.deepPurpleAccent,
      duration: Duration(seconds: 2),
    );
  }
}

class startpage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          {
             return SpinKitCircle(
               color: Colors.deepPurpleAccent,
               duration: Duration(seconds: 2),
             );
          }
        if (snapshot.hasError) {
          return Center(
            child: Text("Something Went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AuthChecker();
        }
        //loading
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class AuthChecker extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
      data: (value) {
        if (value != null) {
          final name=value.displayName.toString();
          return
            // AnimationPage();
            HomeScreen(name: name,);
        }
        return AuthScreen();
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (_, __) {
        return Scaffold(
          body: Center(
            child: Text("OOPS"),
          ),
        );
      },
    );
  }
}

