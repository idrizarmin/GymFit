class UserPackageSearchObject {
  bool? expired;
  int? PageNumber;
  int? PageSize;
  int? userId;
  int? packageId;
  DateTime? fromDate;
  DateTime? toDate;

  UserPackageSearchObject(
      {this.PageNumber,
      this.PageSize,
      this.expired,
      this.userId,
      this.packageId,
      this.fromDate,
      this.toDate});

  UserPackageSearchObject.fromJson(Map<String, dynamic> json) {
    expired = json['expired'];
    userId = json['userId'];
    packageId = json['packageId'];
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
