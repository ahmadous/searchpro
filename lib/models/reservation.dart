import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  final String id;
  final String userId;
  final String professionalId;
  final String professionalName;
  final DateTime timestamp;
  final String status;

  Reservation({
    required this.id,
    required this.userId,
    required this.professionalId,
    required this.professionalName,
    required this.timestamp,
    required this.status,
  });

  // Conversion d'une réservation en map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'professionalId': professionalId,
      'professionalName': professionalName,
      'timestamp': timestamp,
      'status': status,
    };
  }

  // Création d'une réservation à partir d'un document Firestore
  factory Reservation.fromMap(String id, Map<String, dynamic> data) {
    return Reservation(
      id: id,
      userId: data['userId'],
      professionalId: data['professionalId'],
      professionalName: data['professionalName'] ?? 'Inconnu',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      status: data['status'] ?? 'En attente',
    );
  }
}
