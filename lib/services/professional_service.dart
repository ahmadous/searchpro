import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/professional.dart';

class ProfessionalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Méthode pour récupérer tous les professionnels sans filtrage
  Future<List<Professional>> fetchAllProfessionals() async {
    QuerySnapshot snapshot = await _firestore.collection('professionals').get();
    return snapshot.docs
        .map((doc) => Professional.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }
  // Récupérer la liste des professionnels par catégorie
  Future<List<Professional>> fetchProfessionalsByCategory(String categoryId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('professionals')
        .where('categoryId', isEqualTo: categoryId)
        .get();

    return snapshot.docs.map((doc) => Professional.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
  }

  // Récupérer un professionnel par son ID
  Future<Professional?> fetchProfessionalById(String professionalId) async {
    DocumentSnapshot doc = await _firestore.collection('professionals').doc(professionalId).get();
    if (doc.exists) {
      return Professional.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Ajouter un nouveau professionnel
  Future<void> addProfessional(Professional professional) async {
    await _firestore.collection('professionals').add(professional.toMap());
  }

  // Mettre à jour un professionnel existant
  Future<void> updateProfessional(String id, Professional professional) async {
    await _firestore.collection('professionals').doc(id).update(professional.toMap());
  }

  // Supprimer un professionnel
  Future<void> deleteProfessional(String id) async {
    await _firestore.collection('professionals').doc(id).delete();
  }
}
