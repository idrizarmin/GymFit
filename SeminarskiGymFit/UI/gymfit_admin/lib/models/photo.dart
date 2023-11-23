class Photo {
  late String data;
  late String contentType;

  Photo({
    required this.data,
    required this.contentType});

  Photo.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    data['contentType'] = contentType;
    return data;
  }
}