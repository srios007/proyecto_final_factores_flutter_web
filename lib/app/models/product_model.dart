class Product {
  String? id;
  String? shopId;
  String? description;
  String? imageUrl;
  String? name;
  int? price;
  int? stock;

  Product({
    this.id,
    this.shopId,
    this.description,
    this.imageUrl,
    this.name,
    this.price,
    this.stock,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shopId'];
    description = json['description'];
    imageUrl = json['image_url'];
    name = json['name'];
    price = json['price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['shopId'] = shopId;
    data['description'] = description;
    data['image_url'] = imageUrl;
    data['name'] = name;
    data['price'] = price;
    data['stock'] = stock;
    return data;
  }
}
