
class UserPackageSearchObject {
  bool? expired;
  int? PageNumber;
  int? PageSize;
  int? userId;


  UserPackageSearchObject(
      { this.PageNumber, this.PageSize, this.expired, this.userId });

  UserPackageSearchObject.fromJson(Map<String, dynamic> json) {
    expired = json['expired'];
    userId = json['userId'];
    PageNumber = json['PageNumber'];
    PageSize = json['PageSize'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['expired'] = expired;
    data['PageNumber'] = PageNumber;
    data['PageSize'] = PageSize;
    return data;
  }
}
