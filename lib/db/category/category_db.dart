import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:money_management/models/category/category_model.dart';

const CATEGORY_DB_NAME = "category-database";

abstract class CategoryDbFunctions {
  Future<List<CategoryMOdel>> getCategories();
  Future<void> insertCategory(CategoryMOdel value);
  Future<void> deleteCategory(String CategoryID);
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryMOdel>> incomeCategoryListLisener =
      ValueNotifier([]);
  ValueNotifier<List<CategoryMOdel>> expenseCategoryListLisener =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryMOdel value) async {
    final _categoryDB = await Hive.openBox<CategoryMOdel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id,value);
    refreshUI();
  }

  @override
  Future<List<CategoryMOdel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryMOdel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    incomeCategoryListLisener.value.clear();
    expenseCategoryListLisener.value.clear();
    await Future.forEach(
      _allCategories,
      (CategoryMOdel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListLisener.value.add(category);
        } else {
          expenseCategoryListLisener.value.add(category);
        }
      },
    );
    incomeCategoryListLisener.notifyListeners();
    expenseCategoryListLisener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String CategoryID) async {
    final _categoryDB = await Hive.openBox<CategoryMOdel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(CategoryID);
    refreshUI();
  }
}
