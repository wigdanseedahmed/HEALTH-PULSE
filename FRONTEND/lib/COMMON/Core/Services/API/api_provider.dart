import 'package:dio/dio.dart';
///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=id&apiKey=YOUR_API_KEY';

  void printOutError(error, StackTrace stacktrace) {
    print('Exception occured: $error with stacktrace: $stacktrace');
  }

  Future<ResponseTopHeadlinesNewsModel> getTopHeadlinesNews() async {
    try {
      final response = await _dio.get(_baseUrl);
      return ResponseTopHeadlinesNewsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNewsModel.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNewsModel> getTopBusinessHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=business');
      return ResponseTopHeadlinesNewsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNewsModel.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNewsModel> getTopEntertainmentHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=entertainment');
      return ResponseTopHeadlinesNewsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNewsModel.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNewsModel> getTopHealthHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=health');
      return ResponseTopHeadlinesNewsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNewsModel.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNewsModel> getTopScienceHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=science');
      return ResponseTopHeadlinesNewsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNewsModel.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNewsModel> getTopSportHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=sport');
      return ResponseTopHeadlinesNewsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNewsModel.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNewsModel> getTopTechnologyHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&category=technology');
      return ResponseTopHeadlinesNewsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNewsModel.withError('$error');
    }
  }
}
