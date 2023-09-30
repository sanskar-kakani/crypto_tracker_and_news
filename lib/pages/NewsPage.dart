import 'package:crypto_currency_tracker_and_news/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/News.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsState();
}

class _NewsState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        if (newsProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (newsProvider.news.length > 0) {
            return RefreshIndicator(
              onRefresh: () async {
                await newsProvider.fetchData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: newsProvider.news.length,
                itemBuilder: (context, index) {
                  News news = newsProvider.news[index];
                  return Column(
                    children: [
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          _launchURL(news.url ??
                              "https://t3.ftcdn.net/jpg/03/45/05/92/240_F_345059232_CPieT8RIWOUk4JqBkkWkIETYAkmz2b75.jpg");
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            news.urlToImage ??
                                "https://t3.ftcdn.net/jpg/03/45/05/92/240_F_345059232_CPieT8RIWOUk4JqBkkWkIETYAkmz2b75.jpg",
                            fit: BoxFit.cover,
                            height: 200,
                            width: 400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        news.title ?? "no title",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            news.author ?? "no author",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(formattedDate(news.publishedAt ?? "")),
                        ],
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            );
          } else {
            return const Text("Data not found!");
          }
        }
      },
    );
  }

  String formattedDate(String dateString) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    final DateTime dateTime = inputFormat.parse(dateString);
    final outputFormat = DateFormat("d MMM"); // Example: "September 29, 2023"
    final formatted = outputFormat.format(dateTime);
    return formatted;
  }

  Future<void> _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
