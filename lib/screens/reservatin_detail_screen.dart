import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';

class ReservationDetailScreen extends StatelessWidget {
  final String reservationId;

  ReservationDetailScreen({required this.reservationId});

  @override
  Widget build(BuildContext context) {
    final reservationProvider = Provider.of<ReservationProvider>(context);

    // Détail de la réservation actuelle
    final reservation = reservationProvider.reservations.firstWhere((res) => res.id == reservationId);

    return Scaffold(
      appBar: AppBar(title: Text('Détail de la Réservation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Réservé avec ${reservation.professionalName}'),
            Text('Date: ${reservation.timestamp}'),
            Text('Statut: ${reservation.status}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showUpdateDialog(context, reservationProvider, reservationId);
              },
              child: Text('Modifier la Réservation'),
            ),
            ElevatedButton(
              onPressed: () {
                _showDeleteConfirmationDialog(context, reservationProvider, reservationId);
              },
              child: Text('Supprimer la Réservation'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, ReservationProvider reservationProvider, String reservationId) {
    final TextEditingController statusController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifier la Réservation'),
          content: TextField(
            controller: statusController,
            decoration: InputDecoration(labelText: 'Nouveau statut'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                reservationProvider.updateReservation(reservationId, {'status': statusController.text});
                Navigator.pop(context);
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, ReservationProvider reservationProvider, String reservationId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmer la suppression'),
          content: Text('Êtes-vous sûr de vouloir supprimer cette réservation ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                reservationProvider.deleteReservation(reservationId);
                Navigator.pop(context);
                Navigator.pop(context); // Fermer l'écran de détail
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }
}
