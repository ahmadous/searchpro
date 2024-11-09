class AppUser {
  final String id;
  final String name;       // Propriété pour le nom de l'utilisateur
  final String email;
  final String role;
  final String password;

  AppUser({
    required this.id,
    required this.name,    // Initialiser le nom de l'utilisateur
    required this.email,
    required this.role,
    this.password = '',
  });

  // Convertir l'objet AppUser en map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,         // Inclure le nom dans le map
      'email': email,
      'role': role,
    };
  }

  // Créer un AppUser à partir d'un document Firestore
  static AppUser fromMap(String id, Map<String, dynamic> data) {
    return AppUser(
      id: id,
      name: data['name'] ?? '',         // Récupérer le nom de Firestore
      email: data['email'],
      role: data['role'],
    );
  }
}
