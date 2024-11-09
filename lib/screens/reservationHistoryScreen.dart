import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';

class ReservationHistoryScreen extends StatelessWidget {
  final String userId;

  ReservationHistoryScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    final reservationProvider = Provider.of<ReservationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Historique des Réservations'),
      ),
      body: FutureBuilder<void>(
        future: reservationProvider.fetchUserReservations(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final reservations = reservationProvider.reservations;

          if (reservations.isEmpty) {
            return Center(
              child: Text('Aucune réservation trouvée.'),
            );
          }

          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final reservation = reservations[index];
              return ListTile(
                title: Text('Réservé avec ${reservation.professionalName}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: ${reservation.timestamp.toLocal()}'.split(' ')[0]),
                    Text('Statut: ${reservation.status}'),
                  ],
                ),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}
