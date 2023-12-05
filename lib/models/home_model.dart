class  HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel>  banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = List<BannerModel>.from(
        json['banners'].map((banner) => BannerModel.fromJson(banner)),
      );
    }

    if (json['products'] != null) {
      products = List<ProductModel>.from(
        json['products'].map((product) => ProductModel.fromJson(product)),
      );
    }


 /*   json['banners'].forEach((element) {
      banners.add(element);
    });
    json['products'].forEach((element) {
      products.add(element);
    });*/
/*
    if (json['banners'] != null) {
      json['banners'].forEach((element) {
        banners.add(BannerModel.fromJson(element));
      });}else{
      print('banners are empty');
    }

    if (json['products'] != null) {
      json['products'].forEach((element) {
        products.add(ProductModel.fromJson(element));
      });
    }*/
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  String? image;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
