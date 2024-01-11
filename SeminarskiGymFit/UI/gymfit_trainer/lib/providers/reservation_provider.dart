

import 'package:gymfit_trainer/models/reservation.dart';
import 'package:gymfit_trainer/models/seaarchObjects/reservation_search_object.dart';
import 'package:gymfit_trainer/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/constants.dart';
import '../utils/authorization.dart';

class ReservationProvider extends BaseProvider<Reservation> {
  ReservationProvider() : super('Reservations/GetPaged');

  Future<List<Reservation>> getAll(
      {ReservationSearchObject? searchObject}) async {
    var uri = Uri.parse('$apiUrl/Reservations/GetAllFiltered');
    var headers = Authorization.createHeaders();
    final Map<String, String> queryParameters = {};
    if (searchObject != null) {
      if (searchObject.userId != null) {
        queryParameters['userId'] = searchObject.userId.toString();
      }
      if (searchObject.spol != null) {
        queryParameters['spol'] = searchObject.spol.toString();
      }
      if (searchObject.trainerId != null) {
        queryParameters['trainerId'] = searchObject.trainerId.toString();
      }
      if (searchObject.PageNumber != null) {
        queryParameters['PageNumber'] = searchObject.PageNumber.toString();
      }
      if (searchObject.PageSize != null) {
        queryParameters['PageSize'] = searchObject.PageSize.toString();
      }
        if (searchObject.status != null) {
        queryParameters['status'] = searchObject.status.toString();
      }
    }
    uri = uri.replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data;
      return items.map((d) => fromJson(d)).cast<Reservation>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
 
 Future<dynamic> setReservationAsCanceled(int id) async {
    var uri = Uri.parse('$apiUrl/Reservations/status/${id}');
    Map<String, String> headers = Authorization.createHeaders();
    
    var response = await http.put(uri, headers: headers);
    print( response);
    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }
Future<dynamic> setToCanceledFromCreated(int id) async {
    var uri = Uri.parse('$apiUrl/Reservations/toCanceled/${id}');
    Map<String, String> headers = Authorization.createHeaders();
    
    var response = await http.put(uri, headers: headers);
    print( response);
    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  @override
  Future<dynamic> insert(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/Reservations');
    Map<String, String> headers = Authorization.createHeaders();
    var jsonRequest = jsonEncode(resource);
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future<dynamic> edit(dynamic resource) async {
    var uri = Uri.parse('$apiUrl/Reservations');
    Map<String, String> headers = Authorization.createHeaders();
    var jsonRequest = jsonEncode(resource);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  Future<dynamic> delete(int id) async {
    var uri = Uri.parse('$apiUrl/Reservations/${id}');
    Map<String, String> headers = Authorization.createHeaders();

    var response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Greška prilikom unosa');
    }
  }

  @override
  Reservation fromJson(data) {
    return Reservation.fromJson(data);
  }
}
