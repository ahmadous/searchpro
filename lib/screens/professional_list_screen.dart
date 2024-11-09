import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/professional_provider.dart';
import 'professional_detail_screen.dart';

class ProfessionalListScreen extends StatelessWidget {
  final String categoryId;

  ProfessionalListScreen({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final professionalProvider = Provider.of<ProfessionalProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Professionnels')),
      body: FutureBuilder<void>(
        future: professionalProvider.fetchProfessionalsByCategory(categoryId),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfessionalDetailScreen(professionalId: professional.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
