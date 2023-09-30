class News {
  String? title;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? author;

  News({
    required this.title,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.author,
  });

  factory News.fromJSON(Map<String, dynamic> map) {
    return News(
        title: map['title'],
        url: map['url'],
        urlToImage: map['urlToImage'],
        publishedAt: map['publishedAt'],
        author: map['author']);
  }
}
