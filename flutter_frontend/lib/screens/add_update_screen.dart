import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/post.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/providers/auth_provider.dart';
import 'package:flutter_frontend/providers/post_provider.dart';
import 'package:provider/provider.dart';

class AddUpdateScreen extends StatelessWidget {
  final Post? post;
  AddUpdateScreen({Key? key, this.post}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final _title = TextEditingController();
  final _body = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = context.read<AuthProvider>().user!;
    String author = user.username!;
    String authorId = user.id!;
    if (post != null) {
      _title.text = post!.title;
      _body.text = post!.body;
    }

    final isLoading = context.watch<PostProvider>().isLoading;

    return AbsorbPointer(
      absorbing: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: post == null ? Text('Create new post') : Text('Update post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _title,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (val) =>
                      val!.length > 0 ? null : 'Title cannot be empty.',
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _body,
                  decoration: InputDecoration(
                    labelText: 'Body',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  minLines: 4,
                  maxLines: 6,
                  validator: (val) =>
                      val!.length > 0 ? null : 'Body cannot be empty.',
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    isLoading
                        ? ElevatedButton(
                            onPressed: null,
                            child: Container(
                              constraints: BoxConstraints(
                                  maxHeight: 20.0, maxWidth: 20.0),
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (post == null) {
                                  await context.read<PostProvider>().createPost(
                                        _title.text,
                                        _body.text,
                                        author,
                                        authorId,
                                      );
                                } else {
                                  Post updatedPost = Post(
                                      id: post!.id,
                                      authorId: post!.authorId,
                                      author: post!.author,
                                      body: _body.text,
                                      title: _title.text,
                                      createdAt: post!.title);

                                  await context.read<PostProvider>().updatePost(
                                        updatedPost,
                                      );
                                }
                                _title.text = '';
                                _body.text = '';
                                Navigator.pop(context);
                              }
                            },
                            child: post == null ? Text('Add') : Text('Update'),
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
