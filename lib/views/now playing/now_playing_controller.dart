import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flex_app/data/models/movie_models.dart';
import 'package:movie_flex_app/data/repository/movie_repository.dart';

class NowPlayingController extends GetxController {
  final MovieRepository movieRepository = MovieRepository();
  static NowPlayingController get instance => Get.find();
  final searchController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  int page = 1;
  var movies = <MovieModel>[].obs;
  var movies1 = <MovieModel>[].obs;

  void getNowPlayingMovies() async {
    try {
      if (movies.isEmpty) {
        isLoading(true);
        final movieList = await movieRepository.getNowPlayingMovies(page);
        movies.assignAll(movieList);
        movies1.assignAll(movieList);
        page++;
      } else {
        final moreMovies = await movieRepository.getNowPlayingMovies(page);
        if (moreMovies.isNotEmpty) {
          movies.addAll(moreMovies);
          movies1.addAll(moreMovies);
          page++;
        }
      }
    } catch (e) {
      errorMessage("Oops, Something went wrong...!");
    } finally {
      isLoading(false);
    }
  }

  void deleteNowPlayingMovie(int index) {
    movies.removeAt(index);
    movies1.removeAt(index);
  }

  void refreshNowPlayingMovies() async {
    try {
      page = 1;
      movies.clear();
      movies1.clear();
      isLoading(true);
      final movieList = await movieRepository.getNowPlayingMovies(page);
      movies.assignAll(movieList);
      movies1.assignAll(movieList);
      page++;
    } catch (e) {
      errorMessage("Oops, Something went wrong...!");
    }finally{
      isLoading(false);
    }
  }

  void searchNowPlayingMovies(String movieName) {
    if (movieName.isNotEmpty) {
      var searchedMovies = movies1
          .where((element) =>
              element.title!.toLowerCase().contains(movieName.toLowerCase()))
          .toList();
      movies.assignAll(searchedMovies);
    } else {
      movies.assignAll(movies1);
    }
  }
}
