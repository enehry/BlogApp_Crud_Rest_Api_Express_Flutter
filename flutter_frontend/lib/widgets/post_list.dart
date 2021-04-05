import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/post.dart';
import 'package:flutter_frontend/providers/post_provider.dart';
import 'package:flutter_frontend/widgets/post_card_widget.dart';
import 'package:provider/provider.dart';

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FutureBuilder<List<Post>>(
        future: context.watch<PostProvider>().searchKey.isEmpty
            ? context.watch<PostProvider>().getAllPost()
            : context.watch<PostProvider>().searchPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.isNotEmpty) {
              print(snapshot.data![0].author);
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (_, i) => PostCardWidget(
                  post: snapshot.data![i],
                ),
              );
            } else {
              return Center(
                child: Text('No data retreive'),
              );
            }
          }
        },
      ),
    );
  }
}
