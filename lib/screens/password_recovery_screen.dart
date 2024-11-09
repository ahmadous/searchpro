import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  void _submit(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.recoverPassword(emailController.text);

    // Afficher une notification indiquant que l'email de réinitialisation a été envoyé
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Un email de réinitialisation a été envoyé.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Réinitialiser le mot de passe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Entrez votre email pour recevoir un lien de réinitialisation.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submit(context),
              child: Text('Envoyer l\'email de réinitialisation'),
            ),
          ],
        ),
      ),
    );
  }
}
