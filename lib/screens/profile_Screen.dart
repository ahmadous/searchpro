import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId;

  ProfileScreen({required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (widget.userId != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = await userProvider.fetchUserById(widget.userId!);
      setState(() {
        nameController.text = user?.name ?? '';
        emailController.text = user?.email ?? '';
        isLoading = false;
      });
    }
  }

  void _saveProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (widget.userId != null) {
      await userProvider.updateUserProfile(
        widget.userId!,
        nameController.text,
        emailController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil mis à jour avec succès')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Utilisateur'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text('Enregistrer les modifications'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Optionnel : Naviguer vers l'écran de changement de mot de passe
              },
              child: Text('Changer le mot de passe'),
            ),
          ],
        ),
      ),
    );
  }
}
