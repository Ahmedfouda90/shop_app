class CategoriesModel {
  bool? status;
  CategoriesDateModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDateModel.fromJson(json['data']);

    // data = json['data'] != null ? CategoriesDateModel.fromJson(json['data']) : null;
  }
}

class CategoriesDateModel {
  int? currentIndex;
  List<DataModel>? data = [];

/*
  CategoriesDateModel.fromJson(Map<String, dynamic> json) {
    currentIndex = json['current_index'];
    json['data'].forEach((element) {
      data!.add(DataModel.fromJson(element));
    });
  }
*/
  CategoriesDateModel.fromJson(Map<String, dynamic> json) {
    currentIndex = json['current_page'];

      if (json['data'] != null) {
        data = List<DataModel>.from(
          json['data'].map((category) => DataModel.fromJson(category)),
        );
    }
}}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
