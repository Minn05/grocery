import 'package:e_commerce/const.dart';
import 'package:http/http.dart' as http;

class RemoteProductService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/products';

  Future<dynamic> get() async {
    var response = await client.get(
      Uri.parse('$remoteUrl?populate[images]=true&populate[tags]=true'),
    );
    return response;
  }

  Future<dynamic> getByName({required String keyword}) async {
    var response = await client.get(
      Uri.parse(
          '$remoteUrl?populate[images]=true&populate[tags]=true&filters[name][\$contains]=$keyword'),
    );
    return response;
  }

  Future<dynamic> getByCategory({required int id}) async {
    var response = await client.get(
      Uri.parse(
          '$remoteUrl?populate[images]=true&populate[tags]=true&filters[category][id]=$id'),
    );
    return response;
  }
}
