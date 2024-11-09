import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/professional_provider.dart';
import '../models/professional.dart';

class AddEditProfessionalScreen extends StatefulWidget {
  final Professional? professional;

  AddEditProfessionalScreen({this.professional});

  @override
  _AddEditProfessionalScreenState createState() => _AddEditProfessionalScreenState();
}

class _AddEditProfessionalScreenState extends State<AddEditProfessionalScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.professional != null) {
      nameController.text = widget.professional!.name;
      descriptionController.text = widget.professional!.description;
    }
  }

  void _saveProfessional() async {
    final professionalProvider = Provider.of<ProfessionalProvider>(context, listen: false);
    if (widget.professional == null) {
      // Ajouter un nouveau professionnel
      await professionalProvider.addProfessional(
          'Nom du professionnel',
          'Description',
          'ID de la catégorie',
          'URL de l’image de profil',
          ['Service 1', 'Service 2']
      );
    } else {
      // Modifier le professionnel existant
      await professionalProvider.updateProfessional(
          'ID du professionnel',
          'Nom du professionnel',
          'Description',
          'ID de la catégorie',
          'URL de l’image de profil',
          ['Service 1', 'Service 2']
      );

    }
    Navigator.pop(context); // Retourner à l'écran précédent
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.professional == null ? 'Ajouter un Professionnel' : 'Modifier le Professionnel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nom du Professionnel'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfessional,
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
