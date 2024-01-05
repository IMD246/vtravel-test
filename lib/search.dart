import 'package:flutter/material.dart';
import 'package:viet_travel_test/data/viet_travel_repository.dart';

import 'data/articles_model.dart';

class SearchTravel extends StatefulWidget {
  const SearchTravel({super.key});

  @override
  State<SearchTravel> createState() => _SearchTravelState();
}

class _SearchTravelState extends State<SearchTravel> {
  List<String> wordsSuggest = ["Vietravel", "Apple", "Bitcoin"];
  ArticlesModel? articlesModel;
  final _repo = VietTravelRepository();
  TextEditingController ctr = TextEditingController();

  void _getByKeyword(String k) async {
    articlesModel = await _repo.getEverything(query: k);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BackButton(),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: ctr,
                  onChanged: (value) {
                    _getByKeyword(value);
                  },
                ),
              ),
              GestureDetector(
                onTap: () => _getByKeyword(ctr.text),
                child: const Icon(
                  Icons.search,
                ),
              )
            ],
          ),
          SizedBox(
            height: 100,
            child: Row(
              children: wordsSuggest
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton(
                          onPressed: () {
                            _getByKeyword(e);
                          },
                          child: Text(e)),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          articlesModel != null
              ? Expanded(
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
                            Text(article.source?.name ?? ""),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
