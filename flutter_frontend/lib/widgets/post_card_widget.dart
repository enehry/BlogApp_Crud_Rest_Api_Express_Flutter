import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/post.dart';
import 'package:flutter_frontend/providers/auth_provider.dart';
import 'package:flutter_frontend/providers/post_provider.dart';
import 'package:flutter_frontend/screens/add_update_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCardWidget extends StatelessWidget {
  final Post post;

  const PostCardWidget({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final username = context.read<AuthProvider>().user!.username;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: ExpandablePanel(
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
              ),
              Text(
                '${DateFormat.yMMMMEEEEd().format(DateTime.parse(post.createdAt))}',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
              ),
              Text(
                'By : ${post.author}',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
          collapsed: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.body,
                textAlign: TextAlign.left,
                style: TextStyle(height: 1.5),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10.0,
              ),
              username == post.author
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          constraints: BoxConstraints(
                            maxHeight: 20.0,
                            maxWidth: 20.0,
                          ),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[400],
                          ),
                          onPressed: () async {
                            await context
                                .read<PostProvider>()
                                .deletePost(post.id);
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        IconButton(
                          constraints: BoxConstraints(
                            maxHeight: 20.0,
                            maxWidth: 20.0,
                          ),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue[400],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddUpdateScreen(post: post),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
          expanded: Column(
            children: [
              Text(
                post.body,
                style: TextStyle(height: 1.5),
                textAlign: TextAlign.left,
                softWrap: true,
              ),
              SizedBox(
                height: 10.0,
              ),
              username == post.author
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          constraints: BoxConstraints(
                            maxHeight: 20.0,
                            maxWidth: 20.0,
                          ),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[400],
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        IconButton(
                          constraints: BoxConstraints(
                            maxHeight: 20.0,
                            maxWidth: 20.0,
                          ),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue[400],
                          ),
                          onPressed: () {
                            print('ayaw');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddUpdateScreen(post: post),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
