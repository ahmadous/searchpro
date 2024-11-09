import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../providers/category_provider.dart';

class CategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gérer les Catégories'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCategoryDialog(context, categoryProvider);
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: categoryProvider.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final categories = categoryProvider.categories;

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                title: Text(category.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showCategoryDialog(context, categoryProvider, category: category);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, categoryProvider, category.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Affiche une boîte de dialogue pour ajouter ou modifier une catégorie
  void _showCategoryDialog(BuildContext context, CategoryProvider categoryProvider, {Category? category}) {
    final TextEditingController nameController = TextEditingController(text: category?.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(category == null ? 'Ajouter une Catégorie' : 'Modifier la Catégorie'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nom de la Catégorie'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (category == null) {
                  categoryProvider.addCategory(nameController.text);
                } else {
                  categoryProvider.updateCategory(category.id, nameController.text);
                }
                Navigator.pop(context);
              },
              child: Text(category == null ? 'Ajouter' : 'Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  // Affiche une boîte de dialogue de confirmation pour la suppression
  void _showDeleteConfirmationDialog(BuildContext context, CategoryProvider categoryProvider, String categoryId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmer la suppression'),
          content: Text('Êtes-vous sûr de vouloir supprimer cette catégorie ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                categoryProvider.deleteCategory(categoryId);
                Navigator.pop(context);
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }
}
