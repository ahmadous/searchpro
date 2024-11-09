import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reservation.dart';

class ReservationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Méthode pour créer une réservation
  Future<void> createReservation(Reservation reservation) async {
    await _firestore.collection('reservations').add(reservation.toMap());
  }

  // Méthode pour récupérer les réservations d'un utilisateur
  Future<List<Reservation>> getUserReservations(String userId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('reservations')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => Reservation.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Méthode pour récupérer toutes les réservations
  Future<List<Reservation>> fetchAllReservations() async {
    QuerySnapshot snapshot = await _firestore.collection('reservations').get();
    return snapshot.docs
        .map((doc) => Reservation.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Méthode pour mettre à jour une réservation
  Future<void> updateReservation(String id, Map<String, dynamic> updatedData) async {
    await _firestore.collection('reservations').doc(id).update(updatedData);
  }

  // Méthode pour supprimer une réservation
  Future<void> deleteReservation(String id) async {
    await _firestore.collection('reservations').doc(id).delete();
  }
}
