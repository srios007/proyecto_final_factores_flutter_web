class Product {
  String? description;
  String? imageUrl;
  String? name;
  int? price;

  Product({
    this.description,
    this.imageUrl,
    this.name,
    this.price,
  });

  Product.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    imageUrl = json['image_url'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['description'] = description;
    data['image_url'] = imageUrl;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
