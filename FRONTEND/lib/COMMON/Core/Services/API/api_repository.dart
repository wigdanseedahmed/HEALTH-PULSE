///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();

  Future<ResponseTopHeadlinesNewsModel> fetchTopHeadlinesNews() =>
      _apiProvider.getTopHeadlinesNews();

  Future<ResponseTopHeadlinesNewsModel> fetchTopBusinessHeadlinesNews() =>
      _apiProvider.getTopBusinessHeadlinesNews();

  Future<ResponseTopHeadlinesNewsModel> fetchTopEntertainmentHeadlinesNews() =>
      _apiProvider.getTopEntertainmentHeadlinesNews();

  Future<ResponseTopHeadlinesNewsModel> fetchTopHealthHeadlinesNews() =>
      _apiProvider.getTopHealthHeadlinesNews();

  Future<ResponseTopHeadlinesNewsModel> fetchTopScienceHeadlinesNews() =>
      _apiProvider.getTopScienceHeadlinesNews();

  Future<ResponseTopHeadlinesNewsModel> fetchTopSportHeadlinesNews() =>
      _apiProvider.getTopSportHeadlinesNews();

  Future<ResponseTopHeadlinesNewsModel> fetchTopTechnologyHeadlinesNews() =>
      _apiProvider.getTopTechnologyHeadlinesNews();
}
