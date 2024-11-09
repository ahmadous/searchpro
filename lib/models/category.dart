class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  // Méthode pour créer une catégorie à partir d'un document Firestore
  factory Category.fromMap(String id, Map<String, dynamic> data) {
    return Category(
      id: id,
      name: data['name'],
    );
  }

  // Méthode pour convertir une catégorie en map (utile pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
