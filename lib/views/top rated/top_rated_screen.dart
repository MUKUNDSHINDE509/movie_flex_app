import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

import '../../utils/color_theme.dart';
import '../widgets/movie.dart';
import 'top_rated_controller.dart';

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({super.key});

  @override
  State<TopRatedScreen> createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {
  final TopRatedController topRatedController = Get.put(TopRatedController());
  final scrollController = ScrollController();
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get stream => _controller.stream;
   @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
     topRatedController.getTopRatedMovies();
  }
  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    _controller.close();
    super.dispose();
  }

  void onScroll() {
    if (isBottom) {
      topRatedController.getTopRatedMovies();
    }
  }

  bool get isBottom {
    if (!scrollController.hasClients) {
      return false;
    } else {
      if (topRatedController.searchController.text.isEmpty) {
        final maxScroll = scrollController.position.maxScrollExtent;
        final currentScroll = scrollController.offset;
        return currentScroll == maxScroll;
      }
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.primaryColor,
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.35),
        automaticallyImplyLeading: false,
        title: TextFormField(
          controller: topRatedController.searchController,
          onChanged: (value) {
            topRatedController.searchTopRatedMovies(value);
          },
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(
                fontSize: 15,
                color: ColorTheme.lightGrey,
                fontWeight: FontWeight.w400),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.white, width: 0.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.white, width: 0.5),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.white, width: 0.5),
            ),
            fillColor: Colors.white,
            filled: true,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.search_rounded,
                size: 20,
                color: ColorTheme.lightGrey,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(maxHeight: 20),
          ),
          cursorColor: Colors.black,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onSaved: (newValue) => topRatedController.searchController.text = newValue!,
        ),
      ),
      body: Obx(() {
        if(topRatedController.isLoading.value && topRatedController.movies.isEmpty){
          return const Center(
            child: CupertinoActivityIndicator(
              color: Color.fromARGB(255, 113, 85, 1),
            ),
          );
        }
         else if (topRatedController.errorMessage.value.isNotEmpty) {
          return Center(
              child: Text(
                topRatedController.errorMessage.value,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            );
            }else if(topRatedController.movies.isNotEmpty){
              final moviesList = topRatedController.movies;
              return SwipeRefresh.cupertino(
                stateStream: stream,
                onRefresh: refresh,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10),
                scrollController: scrollController,
                children: [
                  ...List.generate(
                      topRatedController.isLoading.value == true && moviesList.isNotEmpty
                          ? moviesList.length
                          : moviesList.length + 1, (index) {
                    return index >= moviesList.length
                        ? Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          )
                        : Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              topRatedController.deleteTopRatedMovie(index);
                            },
                            child: MovieContainer(movie: moviesList[index]));
                  })
                ]);
            }
        return Container();
      })
    );
  }
  Future<void> refresh() async {
    topRatedController.refreshTopRatedMovies();
    _controller.sink.add(SwipeRefreshState.hidden);
  }
}