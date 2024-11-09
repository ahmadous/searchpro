import 'package:flutter/material.dart';
import 'manage_users_screen.dart';         // Écran de gestion des utilisateurs
import 'manage_professionals_screen.dart'; // Écran de gestion des professionnels
import 'category_list_screen.dart';       // Écran de gestion des catégories
import 'view_reservations_screen.dart';   // Écran de consultation des réservations

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de Bord Administrateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageUsersScreen()),
                );
              },
              child: Text('Gérer les Utilisateurs'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageProfessionalsScreen()),
                );
              },
              child: Text('Gérer les Professionnels'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryListScreen()),
                );
              },
              child: Text('Gérer les Catégories'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewReservationsScreen()),
                );
              },
              child: Text('Consulter les Réservations'),
            ),
          ],
        ),
      ),
    );
  }
}
