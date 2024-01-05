import 'package:viet_travel_test/data/articles_model.dart';
import 'package:viet_travel_test/data/base_service.dart';
import 'package:viet_travel_test/data/network_url.dart';

class VietTravelRepository extends BaseSerivce {
  Future<ArticlesModel> getTopHeadlines() async {
    return await get(
      TOP_HEADLINES,
      params: {"country": "us", "apiKey": "81a6663c354548dcaa6a5eb6f099bfc1"},
    );
  }

  Future<ArticlesModel> getEverything({String? query}) async {
    return await get(
      EVERYTHINNG,
      params: {"q": query, "apiKey": "81a6663c354548dcaa6a5eb6f099bfc1"},
    );
  }
}
