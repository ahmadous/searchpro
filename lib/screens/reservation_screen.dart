import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';
import '../models/reservation.dart';

class ReservationScreen extends StatefulWidget {
  final String userId;
  final String professionalId;
  final String professionalName;

  ReservationScreen({
    required this.userId,
    required this.professionalId,
    required this.professionalName,
  });

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  DateTime? selectedDate;
  final TextEditingController additionalInfoController = TextEditingController();

  // Méthode pour sélectionner la date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Méthode pour créer la réservation
  void _createReservation() async {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner une date pour la réservation')),
      );
      return;
    }

    final reservationProvider = Provider.of<ReservationProvider>(context, listen: false);
    await reservationProvider.createReservation(
      widget.userId,
      widget.professionalId,
      widget.professionalName,
      selectedDate!,
      'En attente', // Statut initial de la réservation
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Réservation confirmée')),
    );
    Navigator.pop(context); // Fermer l'écran après confirmation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réserver avec ${widget.professionalName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sélectionnez une date pour votre réservation',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'Aucune date sélectionnée'
                        : 'Date: ${selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Choisir la date'),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: additionalInfoController,
              decoration: InputDecoration(
                labelText: 'Informations supplémentaires',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createReservation,
              child: Text('Confirmer la réservation'),
            ),
          ],
        ),
      ),
    );
  }
}
