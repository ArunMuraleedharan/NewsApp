
import 'package:flutter/material.dart';
import 'package:newsapp/DetailScreen.dart';
import 'package:newsapp/services/database.dart';

import 'Model/article_model.dart';

Widget customListTileBookmark(Article article, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.lightGreen,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
            //let's add the height

            image: DecorationImage(
                image: NetworkImage(article.urlToImage), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        // Container(
        //   padding: EdgeInsets.all(6.0),
        //   decoration: BoxDecoration(
        //     color: Colors.blue,
        //     borderRadius: BorderRadius.circular(30.0),
        //   ),
        //   child: Text(
        //     article.source.name,
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          article.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        IconButton(
          icon: Icon(Icons.forward),
          iconSize: 20,
          color: Colors.white,
          onPressed:() async{
            print(article.urlToImage);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      article: article,
                    )));
          },
        ),

      ],
    ),
  );
}