import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';

class ViewReservationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reservationProvider = Provider.of<ReservationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Réservations'),
      ),
      body: FutureBuilder<void>(
        future: reservationProvider.fetchAllReservations(), // Méthode pour récupérer toutes les réservations
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final reservations = reservationProvider.reservations;

          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final reservation = reservations[index];
              return ListTile(
                title: Text('Réservation par ${reservation.userId}'),
                subtitle: Text('Professionnel ID: ${reservation.professionalId}\nDate: ${reservation.timestamp}'),
              );
            },
          );
        },
      ),
    );
  }
}
