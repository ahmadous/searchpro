import 'package:flutter/material.dart';
import 'category_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accueil')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryListScreen()),
            );
          },
          child: Text('Voir les catégories'),
        ),
      ),
    );
  }
}
