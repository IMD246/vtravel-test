import 'package:dio/dio.dart' as dio;
import 'package:viet_travel_test/data/api_respone.dart';
import 'package:viet_travel_test/data/articles_model.dart';

import 'rest_client.dart';

abstract class BaseSerivce {
  Future<dynamic> getWithCustomUrl(String customUrl, String path,
      {Map<String, dynamic>? params}) async {
    final response = await RestClient.getDio(customUrl: customUrl)
        .get(path, queryParameters: params);
    return response.data;
  }

  Future<ArticlesModel> get(String path, {Map<String, dynamic>? params}) async {
    final response =
        await RestClient.getDio().get(path, queryParameters: params);
    return _handleResponse(response);
  }

  Future<ArticlesModel> post(String path,
      {data, bool enableCache = false}) async {
    final response = await RestClient.getDio().post(path, data: data);
    return _handleResponse(response);
  }

  ArticlesModel _handleResponse(dio.Response response) {
    var apiResponse = ApiResponse.fromJson(
      response.data,
      response.statusCode ?? 0,
    );
    switch (apiResponse.code) {
      case 200:
        return ArticlesModel.fromJson(response.data);
      default:
        throw Exception;
    }
  }
}
