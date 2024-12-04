class Package  {
  late int id;
  late String? name;
  late String? description;
  late double? price;
  late bool isSelected = false;

  Package({
    required this.id,
    required this.isSelected,
    this.name,
    this.description,
    this.price,
  });

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;

    return data;
  }
}
