import 'dart:convert';
import 'dart:ffi';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.status,
    this.msg,
    this.discription,
    this.data,
  });

  int? status;
  String? msg;
  String? discription;
  Data? data;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    status: json["status"],
    msg: json["msg"],
    discription: json["discription"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "discription": discription,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.perPage,
    this.from,
    this.to,
    this.total,
    this.currentPage,
    this.lastPage,
    this.prevPageUrl,
    this.firstPageUrl,
    this.nextPageUrl,
    this.lastPageUrl,
    this.popularProduct,
  });

  int? perPage;
  int? from;
  int? to;
  int? total;
  int? currentPage;
  int? lastPage;
  dynamic? prevPageUrl;
  String? firstPageUrl;
  dynamic? nextPageUrl;
  String? lastPageUrl;
  List<PopularProduct>? popularProduct;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    perPage: json["per_page"],
    from: json["from"],
    to: json["to"],
    total: json["total"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    prevPageUrl: json["prev_page_url"],
    firstPageUrl: json["first_page_url"],
    nextPageUrl: json["next_page_url"],
    lastPageUrl: json["last_page_url"],
    popularProduct: List<PopularProduct>.from(json["popular_product"].map((x) => PopularProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "per_page": perPage,
    "from": from,
    "to": to,
    "total": total,
    "current_page": currentPage,
    "last_page": lastPage,
    "prev_page_url": prevPageUrl,
    "first_page_url": firstPageUrl,
    "next_page_url": nextPageUrl,
    "last_page_url": lastPageUrl,
    "popular_product": List<dynamic>.from(popularProduct!.map((x) => x.toJson())),
  };
}

class PopularProduct {
  PopularProduct({
    this.branchProduct,
    this.productName,
    this.branchName,
    this.categoryName,
    this.subCategoryName,
    this.categoryId,
    this.subcategoryId,
    this.productImage,
  });

  BranchProduct? branchProduct;
  String? productName;
  BranchName? branchName;
  CategoryName? categoryName;
  String? subCategoryName;
  int? categoryId;
  int? subcategoryId;
  String? productImage;

  factory PopularProduct.fromJson(Map<String, dynamic> json) => PopularProduct(
    branchProduct: BranchProduct.fromJson(json["branch_product"]),
    productName: json["product_name"],
    branchName: branchNameValues.map![json["branch_name"]],
    categoryName: categoryNameValues.map![json["category_name"]],
    subCategoryName: json["sub_category_name"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "branch_product": branchProduct!.toJson(),
    "product_name": productName,
    "branch_name": branchNameValues.reverse[branchName],
    "category_name": categoryNameValues.reverse[categoryName],
    "sub_category_name": subCategoryName,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "product_image": productImage,
  };
}

enum BranchName { DHANMONDHI_BRANCH }

final branchNameValues = EnumValues({
  "Dhanmondhi Branch": BranchName.DHANMONDHI_BRANCH
});

class BranchProduct {
  BranchProduct({
    this.id,
    this.productId,
    this.branchId,
    this.brandId,
    this.categoryId,
    this.isPopular,
    this.isDealsOfTheDay,
    this.purchasePrice,
    this.productPrice,
    this.vatPercentage,
    this.salePrice,
    this.wholesalePrice,
    this.purchaseQty,
    this.saleQty,
    this.availableQty,
    this.productAlertQty,
    this.wholesaleMinQty,
    this.discountAmount,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.deleted,
    this.deletedAt,
    this.deletedBy,
    this.discountPrc,
  });

  int? id;
  int? productId;
  int? branchId;
  int? brandId;
  int? categoryId;
  int? isPopular;
  int? isDealsOfTheDay;
  String? purchasePrice;
  String? productPrice;
  String? vatPercentage;
  String? salePrice;
  String? wholesalePrice;
  String? purchaseQty;
  String? saleQty;
  String? availableQty;
  String? productAlertQty;
  String? wholesaleMinQty;
  String? discountAmount;
  int? status;
  DateTime? createdAt;
  int? createdBy;
  DateTime? updatedAt;
  int? updatedBy;
  int? deleted;
  dynamic? deletedAt;
  dynamic? deletedBy;
  int? discountPrc;

  factory BranchProduct.fromJson(Map<String, dynamic> json) => BranchProduct(
    id: json["id"],
    productId: json["product_id"],
    branchId: json["branch_id"],
    brandId: json["brand_id"],
    categoryId: json["category_id"],
    isPopular: json["is_popular"],
    isDealsOfTheDay: json["is_deals_of_the_day"],
    purchasePrice: json["purchase_price"],
    productPrice: json["product_price"],
    vatPercentage: json["vat_percentage"],
    salePrice: json["sale_price"],
    wholesalePrice: json["wholesale_price"],
    purchaseQty: json["purchase_qty"],
    saleQty: json["sale_qty"],
    availableQty: json["available_qty"],
    productAlertQty: json["product_alert_qty"],
    wholesaleMinQty: json["wholesale_min_qty"],
    discountAmount: json["discount_amount"] == null ? null : json["discount_amount"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"] == null ? null : json["updated_by"],
    deleted: json["deleted"],
    deletedAt: json["deleted_at"],
    deletedBy: json["deleted_by"],
    discountPrc: json["discount_prc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "branch_id": branchId,
    "brand_id": brandId,
    "category_id": categoryId,
    "is_popular": isPopular,
    "is_deals_of_the_day": isDealsOfTheDay,
    "purchase_price": purchasePrice,
    "product_price": productPrice,
    "vat_percentage": vatPercentage,
    "sale_price": salePrice,
    "wholesale_price": wholesalePrice,
    "purchase_qty": purchaseQty,
    "sale_qty": saleQty,
    "available_qty": availableQty,
    "product_alert_qty": productAlertQty,
    "wholesale_min_qty": wholesaleMinQty,
    "discount_amount": discountAmount == null ? null : discountAmount,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "created_by": createdBy,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "updated_by": updatedBy == null ? null : updatedBy,
    "deleted": deleted,
    "deleted_at": deletedAt,
    "deleted_by": deletedBy,
    "discount_prc": discountPrc,
  };
}

enum CategoryName { BEVERAGES, COOKING, CANDY_CHOCOLATE }

final categoryNameValues = EnumValues({
  "Beverages": CategoryName.BEVERAGES,
  "Candy-Chocolate": CategoryName.CANDY_CHOCOLATE,
  "Cooking": CategoryName.COOKING
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
