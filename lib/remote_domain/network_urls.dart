import 'network_config.dart';

class NetworkUrls {
  final _baseUrl = NetworkConfig().baseUrl;

  //URL
  final String _posts = "posts";
  final String _createPost = "posts";
  final String _deletePost = "posts";

  //ENDPoint
  String get postsUrl => _baseUrl + _posts;
  String get deletePost => _baseUrl + _deletePost;
  String get createPost => _baseUrl + _createPost;
}
