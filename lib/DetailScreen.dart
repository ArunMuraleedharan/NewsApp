
import 'package:flutter/material.dart';

import 'Model/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  DetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(article.url.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
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
              article.description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            MaterialButton(
              onPressed: () async{
                await launchUrl(uri);
              },
              child: Text("Go To Browser",style: TextStyle(color: Colors.white)),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}