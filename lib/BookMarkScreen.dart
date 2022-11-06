


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newsapp/Model/article_model.dart';
import 'package:newsapp/services/database.dart';

import 'customTile.dart';
import 'customtileBookmark.dart';
import 'main.dart';

class BookMark extends ConsumerStatefulWidget {


  @override
  _BookMarkState createState() => _BookMarkState();
}

class _BookMarkState extends ConsumerState<BookMark> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>?>(
      future: DatabaseHelper.getAllNotes(),
      builder: (context, AsyncSnapshot<List<Article>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          if (snapshot.data != null) {
            List<Article>? articles = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) =>
                  GestureDetector(
                    onDoubleTap: () async{
                      await DatabaseHelper.deleteNote(articles![index]);
                      setState((){});

                    },
                      child: customListTileBookmark( articles![index], context)),
              itemCount: snapshot.data!.length,
            );
          }
          return const Center(
            child: Text('No Bookmark Yet',style: TextStyle(color: Colors.black)),
          );
        }
        return Center(
            child: Text('No Bookmark Yet',style: TextStyle(color: Colors.black)));
      },
    );
  }
}

