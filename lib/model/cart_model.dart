class Cart {
  // late final int? id;
  final String? productId;
  final String? productName;
  final int? initialPrice;
  final int? productPrice;
  final int? quantity;
  final String? image;
  final String? unit;
  final String? deliverTime;
  final int? possibleMinit;

  Cart(
      {
        // required this.id ,
        required this.productId,
        required this.productName,
        required this.initialPrice,
        required this.productPrice,
        required this.quantity,
        required this.image,
        required this.unit,
        required this.deliverTime,
        required this.possibleMinit});

  Cart.fromMap(Map<dynamic, dynamic> res)
      :
  // id = res['id'],
        productId = res["productId"],
        productName = res["productName"],
        initialPrice = res["initialPrice"],
        productPrice = res["productPrice"],
        quantity = res["quantity"],
        image = res["image"],
        unit = res["unit"],
        deliverTime = res["deliveryTime"],
        possibleMinit = res["possibleMin"];

  Map<String, Object?> toMap() {
    return {
      //// 'id' : id ,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity,

      'image': image,
      'unit': unit,
      'deliveryTime': deliverTime,
      'possibleMin': possibleMinit,
    };
  }
}
