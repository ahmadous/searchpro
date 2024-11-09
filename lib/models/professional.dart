class Professional {
  final String id;
  final String name;
  final String categoryId; // ID de la catégorie à laquelle il appartient
  final String profileImage; // URL de l'image de profil
  final String description;
  final List<String> services; // Liste des services proposés

  Professional({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.profileImage,
    required this.description,
    required this.services,
  });

  // Conversion d'un document Firestore en objet Professional
  factory Professional.fromMap(String id, Map<String, dynamic> data) {
    return Professional(
      id: id,
      name: data['name'],
      categoryId: data['categoryId'],
      profileImage: data['profileImage'],
      description: data['description'],
      services: List<String>.from(data['services']),
    );
  }

  // Conversion d'un objet Professional en map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryId': categoryId,
      'profileImage': profileImage,
      'description': description,
      'services': services,
    };
  }
}
