import 'package:flutter/material.dart';
import 'package:viet_travel_test/data/articles_model.dart';
import 'package:viet_travel_test/data/network_url.dart';
import 'package:viet_travel_test/data/rest_client.dart';
import 'package:viet_travel_test/data/viet_travel_repository.dart';
import 'package:viet_travel_test/search.dart';

void main() async {
  RestClient.instance.init(
    baseURL,
    language: "us",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TopHeadings(),
    );
  }
}

class TopHeadings extends StatefulWidget {
  const TopHeadings({super.key});

  @override
  State<TopHeadings> createState() => _TopHeadingsState();
}

class _TopHeadingsState extends State<TopHeadings> {
  final _repo = VietTravelRepository();
  ArticlesModel? articlesModel;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        articlesModel = await _repo.getTopHeadlines();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: articlesModel != null
          ? Column(
              children: [
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Search",
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SearchTravel();
                      },
                    ));
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: articlesModel!.articles?.length,
                    itemBuilder: (context, index) {
                      final article = articlesModel!.articles![index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(article.title ?? ""),
                            Image.network(
                              article.urlToImage ?? "",
                            ),
                            Text(article.description ?? ""),
                            Text(article.publishedAt.toString()),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
