import 'package:flutter/material.dart';
import 'add_edit_professional_screen.dart'; // Écran pour ajouter ou modifier un professionnel
import '../providers/professional_provider.dart';
import 'package:provider/provider.dart';

class ManageProfessionalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final professionalProvider = Provider.of<ProfessionalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gérer les Professionnels'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEditProfessionalScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: professionalProvider.fetchAllProfessionals(), // Méthode pour récupérer tous les professionnels
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final professionals = professionalProvider.professionals;

          return ListView.builder(
            itemCount: professionals.length,
            itemBuilder: (context, index) {
              final professional = professionals[index];
              return ListTile(
                title: Text(professional.name),
                subtitle: Text(professional.description),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditProfessionalScreen(professional: professional),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
