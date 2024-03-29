import 'dart:convert';
import 'package:gymfit_admin/models/photo.dart';
import 'package:gymfit_admin/utils/authorization.dart';
import '../helpers/constants.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;

class PhotoProvider extends BaseProvider<Photo> {
  PhotoProvider() : super('Photos/GetPaged');

  Future<List<String>> uploadImages(List<http.MultipartFile> images) async {
    var uri = Uri.parse('$apiUrl/Photos/Add');
    var headers = Authorization.createHeaders();

    try {
      var request = http.MultipartRequest('POST', uri)
        ..files.addAll(images);

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        List<dynamic> imageIds = jsonDecode(responseBody);
        return imageIds.map((id) => id.toString()).toList();
      } else {
        throw Exception('Failed to upload images');
      }
    } catch (e) {
      throw Exception('Error during image upload: $e');
    }
  }

  Future<String> getPhoto(String guidId) async {
  var uri = Uri.parse('$apiUrl/Photos/GetbyId');
  var headers = Authorization.createHeaders();
  final Map<String, String> queryParameters = {
    'id': guidId,
    'original': 'true',
  };
  uri = uri.replace(queryParameters: queryParameters);

  final response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    return '$apiUrl/Photos/GetbyId?id=${guidId}&original=true';
  } else {
    throw Exception('Failed to load data');
  }
}


  // Future<dynamic> edit(dynamic resource) async {
  //   var uri = Uri.parse('$apiUrl/Post');
  //   Map<String, String> headers = Authorization.createHeaders();

  //   var jsonRequest = jsonEncode(resource);
  //   var response = await http.put(uri, headers: headers, body: jsonRequest);

  //   if (response.statusCode == 200) {
  //     return "OK";
  //   } else {
  //     throw Exception('Greška prilikom unosa');
  //   }
  // }

  // Future<dynamic> delete(int id) async {
  //   var uri = Uri.parse('$apiUrl/Post/${id}');
  //   Map<String, String> headers = Authorization.createHeaders();

  //   var response = await http.delete(uri, headers: headers);

  //   if (response.statusCode == 200) {
  //     return "OK";
  //   } else {
  //     throw Exception('Greška prilikom unosa');
  //   }
  // }

  @override
  Photo fromJson(data) {
    return Photo.fromJson(data);
  }
}
