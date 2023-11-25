import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/models/movie_models.dart';
import '../utils/constant_images.dart';

class MoviesDetailsScreen extends StatefulWidget {
  final MovieModel movie;
  const MoviesDetailsScreen({super.key, required this.movie});

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  String backdropPath = "https://image.tmdb.org/t/p/original";
 @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final date = DateFormat('yyyy-MM-dd').parse(widget.movie.releaseDate!);
    final movieDetails = widget.movie;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "$backdropPath${movieDetails.backdropPath}"))),
        child: Column(
          children: [
            Container(
              width: size.width,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.65)),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        )),
                    SizedBox(width: size.width * 0.05),
                    const Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView(
              reverse: true,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: size.height * 0.02),
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(6)),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.035),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieDetails.title!,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Text(
                        DateFormat('MMMM d, y').format(date),
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70),
                      ),
                      SizedBox(
                        height: size.height * 0.006,
                      ),
                      Row(
                        children: [
                          const Image(
                              width: 22,
                              height: 22,
                              image: AssetImage(ConstantImages.crown)),
                          const SizedBox(width: 8),
                          Text(
                            "${(movieDetails.voteAverage! * 10).toStringAsFixed(2)}%",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.006,
                      ),
                      Text(
                        movieDetails.overview!,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70),
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}