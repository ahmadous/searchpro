import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  // Récupérer les catégories depuis Firestore et mettre à jour l'état
  Future<void> fetchCategories() async {
    _categories = await _categoryService.fetchCategories();
    notifyListeners();
  }

  // Ajouter une nouvelle catégorie
  Future<void> addCategory(String name) async {
    final newCategory = Category(id: '', name: name);
    await _categoryService.addCategory(newCategory);
    await fetchCategories(); // Rafraîchir la liste des catégories après ajout
  }

  // Modifier une catégorie existante
  Future<void> updateCategory(String id, String newName) async {
    await _categoryService.updateCategory(id, newName);
    await fetchCategories(); // Rafraîchir la liste des catégories après modification
  }

  // Supprimer une catégorie
  Future<void> deleteCategory(String id) async {
    await _categoryService.deleteCategory(id);
    await fetchCategories(); // Rafraîchir la liste des catégories après suppression
  }
}
