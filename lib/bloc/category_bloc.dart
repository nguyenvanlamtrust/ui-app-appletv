import 'dart:async';

import 'package:btl_kiemtra_flutter/data/categories.dart';
import 'package:btl_kiemtra_flutter/enums/category_type_enum.dart';
import 'package:btl_kiemtra_flutter/models/category_item.dart';

class CategoryBloc {
  CategoryType initCategory = CategoryType.channels;
  CategoryType activeCategory = CategoryType.channels;

  List<CategoryItem> initCategories = [];
  List<CategoryItem> categories = [];

  final StreamController<CategoryType> _categoryController = StreamController<CategoryType>.broadcast();
  Stream<CategoryType> get categoryStream => _categoryController.stream;

  final StreamController<List<CategoryItem>> _listCategoryItemController = StreamController<List<CategoryItem>>.broadcast();
  Stream<List<CategoryItem>> get listCategoryItemStream => _listCategoryItemController.stream;

  final StreamController<bool> _toggleLikeController = StreamController<bool>.broadcast();
  Stream<bool> get toggleLikeStream => _toggleLikeController.stream;

  CategoryBloc(){
    initCategories = categoriesChannel;
    categories = categoriesChannel;
  }

  void toggleLike(int idx) {
    List<CategoryItem> newCategories = List.from(categories);
    newCategories[idx].isLiked = !newCategories[idx].isLiked;
    _listCategoryItemController.sink.add(newCategories);
  }

  void changeCategory(CategoryType newCat) {
    activeCategory = newCat;
    switch (activeCategory) {
      
      case CategoryType.channels:
        categories = categoriesChannel;
        break;

      case CategoryType.trending:
        categories = categoriesTrending;
        break;

      case CategoryType.series:
        categories = categoriesSeries;
        break;

      default:
        categories = [];
    }
    _listCategoryItemController.sink.add(categories);
    _categoryController.sink.add(activeCategory);
  }

  void dispose() {
    _categoryController.close();
    _listCategoryItemController.close();
  }

}