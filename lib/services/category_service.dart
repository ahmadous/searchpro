import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Méthode pour récupérer toutes les catégories depuis Firestore
  Future<List<Category>> fetchCategories() async {
    QuerySnapshot snapshot = await _firestore.collection('categories').get();
    return snapshot.docs
        .map((doc) => Category.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Ajouter une nouvelle catégorie dans Firestore
  Future<void> addCategory(Category category) async {
    await _firestore.collection('categories').add(category.toMap());
  }

  // Modifier une catégorie existante dans Firestore
  Future<void> updateCategory(String id, String newName) async {
    await _firestore.collection('categories').doc(id).update({
      'name': newName,
    });
  }

  // Supprimer une catégorie dans Firestore
  Future<void> deleteCategory(String id) async {
    await _firestore.collection('categories').doc(id).delete();
  }
}
