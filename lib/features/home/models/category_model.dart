
class CategoryModel {

  final String title;
  final String image;

  CategoryModel({required this.title, required this.image});
  
  static List<CategoryModel> get dummyList{
    return [
      CategoryModel(title: "Hoodies", image: "/img_category_1.png"),
      CategoryModel(title: "Shirts", image: "/img_category_2.png"),
      CategoryModel(title: "Formal", image: "/img_category_3.png"),
      CategoryModel(title: "T-Shirts", image: "/img_category_4.png"),
    ];
  }


}