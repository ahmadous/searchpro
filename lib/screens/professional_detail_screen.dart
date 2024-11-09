import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/professional_provider.dart';

class ProfessionalDetailScreen extends StatelessWidget {
  final String professionalId;

  ProfessionalDetailScreen({required this.professionalId});

  @override
  Widget build(BuildContext context) {
    final professionalProvider = Provider.of<ProfessionalProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Détails du Professionnel')),
      body: FutureBuilder<void>(
        future: professionalProvider.fetchProfessionalById(professionalId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final professional = professionalProvider.selectedProfessional;
          if (professional == null) {
            return Center(child: Text('Professionnel non trouvé.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(professional.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Description:', style: TextStyle(fontSize: 18)),
                Text(professional.description),
                SizedBox(height: 16),
                Text('Services Offerts:', style: TextStyle(fontSize: 18)),
                ...professional.services.map((service) => Text('- $service')).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
