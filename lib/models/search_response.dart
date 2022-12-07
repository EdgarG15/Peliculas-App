// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas/models/models.dart';

class SearchResponse {
  SearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory SearchResponse.fromJson(String str) =>
      SearchResponse.fromMap(json.decode(str));

  factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: json['results'] != null
            ? List<Movie>.from(json["results"].map((x) => Movie.fromMap(x)))
                .toList()
            : [],
        totalPages: json["total_pages"] ?? null,
        totalResults: json["total_results"] ?? null,
      );
}
