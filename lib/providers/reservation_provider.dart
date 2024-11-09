import 'package:flutter/material.dart';
import '../models/reservation.dart';
import '../services/reservation_service.dart';

class ReservationProvider with ChangeNotifier {
  final ReservationService _reservationService = ReservationService();
  List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

  // Crée une réservation
  Future<void> createReservation(String userId, String professionalId, String professionalName, DateTime timestamp, String status) async {
    final reservation = Reservation(
      id: '',
      userId: userId,
      professionalId: professionalId,
      professionalName: professionalName,
      timestamp: timestamp,
      status: status,
    );
    await _reservationService.createReservation(reservation);
    await fetchUserReservations(userId); // Mise à jour de la liste des réservations après création
  }

  // Récupère les réservations de l'utilisateur connecté
  Future<void> fetchUserReservations(String userId) async {
    _reservations = await _reservationService.getUserReservations(userId);
    notifyListeners();
  }

  // Récupère toutes les réservations (pour l'administrateur)
  Future<void> fetchAllReservations() async {
    _reservations = await _reservationService.fetchAllReservations();
    notifyListeners();
  }

  // Mettre à jour une réservation
  Future<void> updateReservation(String reservationId, Map<String, dynamic> updatedData) async {
    await _reservationService.updateReservation(reservationId, updatedData);
    notifyListeners();
  }

  // Supprimer une réservation
  Future<void> deleteReservation(String reservationId) async {
    await _reservationService.deleteReservation(reservationId);
    _reservations.removeWhere((reservation) => reservation.id == reservationId);
    notifyListeners();
  }
}
