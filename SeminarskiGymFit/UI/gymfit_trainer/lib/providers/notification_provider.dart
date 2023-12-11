import 'package:gymfit_trainer/models/notification.dart';
import 'package:gymfit_trainer/models/seaarchObjects/notification_search_object.dart';
import 'package:gymfit_trainer/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/constants.dart';
import '../utils/authorization.dart';

class NotificationProvider extends BaseProvider<Notifications> {
  NotificationProvider() : super('Notifications/GetPaged');

  Future<List<Notifications>> getPaged(
      {NotificationsSearchObject? searchObject}) async {
    var uri = Uri.parse('$apiUrl/Notifications/GetPaged');
    var headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};
    if (searchObject != null) {
      if (searchObject.content != null) {
        queryParameters['content'] = searchObject.content!;
      }

      if (searchObject.userId != null) {
        queryParameters['userId'] = searchObject.userId.toString();
      }

      if (searchObject.seen != null) {
        queryParameters['seen'] = searchObject.seen.toString();
      }
      if (searchObject.PageNumber != null) {
        queryParameters['PageNumber'] = searchObject.PageNumber.toString();
      }
      if (searchObject.PageSize != null) {
        queryParameters['PageSize'] = searchObject.PageSize.toString();
      }
    }
    uri = uri.replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['items'];
      return items.map((d) => fromJson(d)).cast<Notifications>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> setAsSeen(int id) async {
    var uri = Uri.parse('$apiUrl/Notifications/SetNotificationsAsSeen');
    Map<String, String> headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};
    queryParameters['id'] = id.toString();
    var response = await http.put(uri, headers: headers);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future<dynamic> setAsDeleted(int id) async {
    var uri = Uri.parse('$apiUrl/Notifications/SetNotificationAsDeleted');
    Map<String, String> headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};
    queryParameters['id'] = id.toString();
    uri = uri.replace(queryParameters: queryParameters);

    var response = await http.put(uri, headers: headers);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future<dynamic> delete(int id) async {
    var uri = Uri.parse('$apiUrl/Notifications/${id}');
    Map<String, String> headers = Authorization.createHeaders();

    var response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }
  Future<dynamic> edit(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/Notifications');
    Map<String, String> headers = Authorization.createHeaders();
    var jsonRequest = jsonEncode(resource);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }
  @override
  Notifications fromJson(data) {
    return Notifications.fromJson(data);
  }
}