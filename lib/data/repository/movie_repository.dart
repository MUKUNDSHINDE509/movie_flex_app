
import 'dart:convert';

import '../models/movie_models.dart';
import 'package:http/http.dart' as http;

class MovieRepository{
  String baseUrl = "https://api.themoviedb.org/3/movie";
  Future<List<MovieModel>> getNowPlayingMovies(int page) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&page=$page'));
      if (response.statusCode == 200) {
        return (jsonDecode(response.body)['results'] as List<dynamic>)
            .map((json) => MovieModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<List<MovieModel>> getTopRatedMovies(int page) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&page=$page'));
      if (response.statusCode == 200) {
        return (jsonDecode(response.body)['results'] as List<dynamic>)
            .map((json) => MovieModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      rethrow;
    }
  }
}