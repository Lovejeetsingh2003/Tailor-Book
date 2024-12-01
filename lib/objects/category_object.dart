class CategoryObject {
  String? id;
  String? categoryName;
  String? categoryPic;
  String? categoryType;

  CategoryObject({
    this.id,
    this.categoryName,
    this.categoryPic,
    this.categoryType,
  });

  factory CategoryObject.fromJson(Map<String, dynamic> json) => CategoryObject(
        id: json["id"],
        categoryName: json["category_name"],
        categoryPic: json["category_pic"],
        categoryType: json["category_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "category_pic": categoryPic,
        "category_type": categoryType,
      };
}
