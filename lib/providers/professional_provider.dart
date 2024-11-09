import 'package:flutter/material.dart';
import '../models/professional.dart';
import '../services/professional_service.dart';

class ProfessionalProvider with ChangeNotifier {
  final ProfessionalService _professionalService = ProfessionalService();
  List<Professional> _professionals = [];
  Professional? _selectedProfessional;

  List<Professional> get professionals => _professionals;
  Professional? get selectedProfessional => _selectedProfessional;
  // Récupérer tous les professionnels
  Future<void> fetchAllProfessionals() async {
    _professionals = await _professionalService.fetchAllProfessionals();
    notifyListeners();
  }
  // Récupérer les professionnels par catégorie
  Future<void> fetchProfessionalsByCategory(String categoryId) async {
    _professionals = await _professionalService.fetchProfessionalsByCategory(categoryId);
    notifyListeners();
  }

  // Récupérer un professionnel par son ID
  Future<void> fetchProfessionalById(String professionalId) async {
    _selectedProfessional = await _professionalService.fetchProfessionalById(professionalId);
    notifyListeners();
  }

  // Ajouter un professionnel
  Future<void> addProfessional(String name, String description, String categoryId, String profileImage, List<String> services) async {
    final professional = Professional(
      id: '', // ID généré automatiquement par Firestore
      name: name,
      description: description,
      categoryId: categoryId,
      profileImage: profileImage,
      services: services,
    );
    await _professionalService.addProfessional(professional);
    await fetchAllProfessionals(); // Rafraîchir la liste après ajout
  }


  // Mettre à jour un professionnel existant
  Future<void> updateProfessional(String id, String name, String description, String categoryId, String profileImage, List<String> services) async {
    final professional = Professional(
      id: id,
      name: name,
      description: description,
      categoryId: categoryId,
      profileImage: profileImage,
      services: services,
    );
    await _professionalService.updateProfessional(id, professional);
    await fetchAllProfessionals();
  }


  // Supprimer un professionnel
  Future<void> deleteProfessional(String id, String categoryId) async {
    await _professionalService.deleteProfessional(id);
    await fetchProfessionalsByCategory(categoryId);
  }
}
