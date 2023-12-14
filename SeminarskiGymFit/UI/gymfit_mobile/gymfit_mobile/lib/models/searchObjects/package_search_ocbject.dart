
class PackageSearchObject {
  String? name;
  int? PageNumber;
  int? PageSize;


  PackageSearchObject(
      {this.name, this.PageNumber, this.PageSize });

  PackageSearchObject.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    PageNumber = json['PageNumber'];
    PageSize = json['PageSize'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['PageNumber'] = PageNumber;
    data['PageSize'] = PageSize;
    return data;
  }
}
