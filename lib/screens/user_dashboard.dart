import 'package:flutter/material.dart';
import 'category_list_screen.dart'; // Écran pour lister les catégories de services/ Écran pour la gestion du profil de l'utilisateur
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'auth_screen.dart';
import 'profile_Screen.dart';
import 'reservationHistoryScreen.dart';

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.user?.id;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de Bord Utilisateur'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authProvider.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            },
          ),
        ],
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
                  MaterialPageRoute(builder: (context) => CategoryListScreen()),
                );
              },
              child: Text('Explorer les Catégories de Services'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (userId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationHistoryScreen(userId: userId),
                    ),
                  );
                }
              },
              child: Text('Voir l\'Historique des Réservations'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (userId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(userId: userId)),
                  );
                }
              },
              child: Text('Gérer le Profil'),
            ),
          ],
        ),
      ),
    );
  }
}
