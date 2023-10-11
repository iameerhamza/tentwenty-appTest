import 'package:mobile_app/Models/UpcomingMoviesModel/upcomingMoviesModel.dart';

class SearchedMoviesResponseModel {
  List<Results>? results;

  SearchedMoviesResponseModel({this.results});

  SearchedMoviesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
