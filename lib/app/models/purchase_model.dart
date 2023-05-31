class Purchase {
  DateTime? created;
  int? stock;
  String? productId;
  String? id;
  String? state;
  String? clientId;
  String? productName;
  String? productUrl;
  String? shopId;

  Purchase({
    this.created,
    this.stock,
    this.productId,
    this.id,
    this.state,
    this.clientId,
    this.productName,
    this.productUrl,
    this.shopId,
  });

  Purchase.fromJson(Map<String, dynamic> json, {bool isGet = false}) {
    if (isGet) {
      created = json['created'].toDate();
    } else {
      created = json['created'];
    }
    stock = json['stock'];
    productId = json['productId'];
    id = json['id'];
    state = json['state'];
    clientId = json['clientId'];
    productName = json['productName'];
    productUrl = json['productUrl'];
    shopId = json['shopId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['created'] = created;
    data['stock'] = stock;
    data['productId'] = productId;
    data['id'] = id;
    data['state'] = state;
    data['clientId'] = clientId;
    data['productName'] = productName;
    data['productUrl'] = productUrl;
    data['shopId'] = shopId;
    return data;
  }
}
