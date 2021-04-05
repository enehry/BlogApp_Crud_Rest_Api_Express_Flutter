class Post {
  final String id;
  final String title;
  final String body;
  final String author;
  final String authorId;
  final String createdAt;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.authorId,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    return Post(
      id: parsedJson['_id'].toString(),
      title: parsedJson['title'].toString(),
      body: parsedJson['body'].toString(),
      author: parsedJson['author'].toString(),
      authorId: parsedJson['author_id'].toString(),
      createdAt: parsedJson['createdAt'].toString(),
    );
  }
}
