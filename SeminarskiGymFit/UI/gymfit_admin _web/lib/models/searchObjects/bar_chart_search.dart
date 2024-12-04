import 'package:gymfit_admin/models/searchObjects/base_search.dart';

class BarChartSearchObject extends BaseSearchObject {
  int? year;
  

  BarChartSearchObject(
      {this.year});

  BarChartSearchObject.fromJson(Map<String, dynamic> json) {
    year = json['year'];
  
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['year'] = year;
   
    return data;
  }
}
