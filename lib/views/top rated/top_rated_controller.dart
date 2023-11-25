import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flex_app/data/models/movie_models.dart';
import 'package:movie_flex_app/data/repository/movie_repository.dart';

class TopRatedController extends GetxController {
  final MovieRepository movieRepository = MovieRepository();
  static TopRatedController get instance => Get.find();
  final searchController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  int page = 1;
  var movies = <MovieModel>[].obs;
  var movies1 = <MovieModel>[].obs;

  void getTopRatedMovies() async {
    try {
      if (movies.isEmpty) {
        isLoading(true);
        final movieList = await movieRepository.getTopRatedMovies(page);
        movies.assignAll(movieList);
        movies1.assignAll(movieList);
        page++;
      } else {
        final moreMovies = await movieRepository.getTopRatedMovies(page);
        if (moreMovies.isNotEmpty) {
          movies.addAll(moreMovies);
          movies1.addAll(moreMovies);
          page++;
        }
      }
    } catch (e) {
      log(e.toString());
      errorMessage("Oops, Something went wrong...!");
    } finally {
      isLoading(false);
    }
  }

  void deleteTopRatedMovie(int index) {
    movies.removeAt(index);
    movies1.removeAt(index);
  }

  void refreshTopRatedMovies() async {
    try {
      page = 1;
      movies.clear();
      movies1.clear();
      isLoading(true);
      final movieList = await movieRepository.getTopRatedMovies(page);
      movies.assignAll(movieList);
      movies1.assignAll(movieList);
      page++;
    } catch (e) {
      log(e.toString());
      errorMessage("Oops, Something went wrong...!");
    }finally{
      isLoading(false);
    }
  }

  void searchTopRatedMovies(String movieName) {
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
