
import 'package:moviesinfo/model/Ratings.dart';

class SearchMovieItem{

  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;
  final String totalResults;
  List<Ratings> mRataingsList = [];

  SearchMovieItem(this.title, this.year,this.imdbID,this.type,this.poster,this.totalResults);
}