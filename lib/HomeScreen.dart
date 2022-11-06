


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newsapp/services/api_services.dart';

import 'Model/article_model.dart';
import 'customTile.dart';
import 'main.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({required this.name});
  String name;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ApiService client = ApiService();
  int index=0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, "+widget.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.white,
            onPressed:(){
              ref.read(authServicesProvider).signout();

            },
          )
        ],
      ),

      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>?> snapshot) {
          if (snapshot.hasData) {
            List<Article>? articles = snapshot.data;
            return GridView.builder(
              itemCount: articles!.length,
              itemBuilder: (context, index)=>customListTile(articles[index], context),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),

            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: index,
        onDestinationSelected: (index){
          setState(() =>this.index=index);

        },
        animationDuration: Duration(milliseconds: 200),
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Place Order"),
          NavigationDestination(icon: Icon(Icons.bookmark_add_outlined), label: "Status")
        ],
      ),
    );
  }
}
