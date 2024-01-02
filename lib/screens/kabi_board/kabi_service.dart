import 'package:kabi_task/remote_domain/network_manager.dart';
import 'package:kabi_task/remote_domain/network_urls.dart';

class KabiService {
  Future<NetworkResponse> getPosts() async {
    var url = NetworkUrls().postsUrl;
    return await NetworkManager().makeRequest(url);
  }

  Future<NetworkResponse> deletePost({required int id}) async {
    var url = NetworkUrls().deletePost;
    return await NetworkManager().makeRequest('$url/$id');
  }
//   {
//   title: 'foo',
//   body: 'bar',
//   userId: 1,
// }
  Future<NetworkResponse> createPost({required dynamic body}) async {
    var url = NetworkUrls().createPost;
    return await NetworkManager().makeRequest(url,body:body);
  }
}
