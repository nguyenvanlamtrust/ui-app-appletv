import 'dart:async';

import 'package:btl_kiemtra_flutter/enums/category_type_enum.dart';
import 'package:flutter/material.dart';

class DashboardBloc {

  int initActivePage = 0;
  int activePage = 0;

  CategoryType initCategoryType = CategoryType.featured;
  CategoryType categoryType = CategoryType.featured;

  final PageController pageController = PageController(viewportFraction: 1.0, initialPage: 0);

  List<String> featuredImages = [
    "https://lumiere-a.akamaihd.net/v1/images/p_avengersendgame_19751_e14a0104.jpeg",
    "https://moviereviewmom.com/wp-content/uploads/2019/05/John-Wick-3-movie-poster.jpeg",
  ];
  List<String> get newReleaseImages => [
    "https://upload.wikimedia.org/wikipedia/vi/3/30/Ant-Man_and_the_Wasp_Quantumania_poster.jpg",
    "https://upload.wikimedia.org/wikipedia/en/4/45/Mission_Majnu.jpg",
  ];
  List<String> get seriesImages => [
    "https://www.omdbapi.com/src/poster.jpg",
    "https://i0.wp.com/moviesandmania.com/wp-content/uploads/2022/07/The-Flood-movie-film-action-horror-alligator-in-prison-2023-Nicky-Whelan-Casper-Van-Dien-Brandon-Slagle-poster.jpg?resize=680%2C1024&ssl=1",
  ];

  List<String> images = [];

  DashboardBloc() {
    images = featuredImages;
  }

  final StreamController<int> _controllerActivePage = StreamController<int>.broadcast();
  Stream<int> get streamActivePage => _controllerActivePage.stream;

  final StreamController<CategoryType> _controllerCategoryType = StreamController<CategoryType>.broadcast();
  Stream<CategoryType> get streamCategoryType => _controllerCategoryType.stream;

  final StreamController<List<String>> _controllerImage = StreamController<List<String>>.broadcast();
  Stream<List<String>> get streamImage => _controllerImage.stream;

  void changeActivePage(int newVal) {
    activePage = newVal;
    _controllerActivePage.sink.add(activePage);
  }

  void changeCategoryType(CategoryType newVal) {
    categoryType = newVal;
    switch (categoryType) {
      case CategoryType.featured:
        images = featuredImages;
        break;

      case CategoryType.newRelease:
        images = newReleaseImages;
        break;

      case CategoryType.series:
        images = seriesImages;
        break;

      default:
        images = [];
    }
    activePage = 0;
    pageController.jumpToPage(activePage);
    _controllerActivePage.sink.add(activePage);
    _controllerImage.sink.add(images);
    _controllerCategoryType.sink.add(categoryType);
  }

  void dispose() {
    _controllerActivePage.close();
    _controllerCategoryType.close();
    _controllerImage.close();
  }
}