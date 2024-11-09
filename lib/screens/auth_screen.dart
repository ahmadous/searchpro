import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'password_recovery_screen.dart'; // Import de l'écran de réinitialisation de mot de passe

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLogin = true;
  String role = 'user'; // Rôle par défaut
  bool isLoading = false; // Indicateur de chargement

  void _submit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      if (isLogin) {
        await authProvider.signIn(emailController.text, passwordController.text);
      } else {
        await authProvider.register(emailController.text, passwordController.text, role: role);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${error.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Connexion' : 'Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            if (!isLogin)
              DropdownButton<String>(
                value: role,
                onChanged: (String? newRole) {
                  setState(() {
                    role = newRole!;
                  });
                },
                items: <String>['user', 'manager', 'admin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator() // Indicateur de chargement
                : ElevatedButton(
              onPressed: _submit,
              child: Text(isLogin ? 'Connexion' : 'Inscription'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(isLogin ? 'Créer un compte' : 'Se connecter'),
            ),
            if (isLogin) // Affiche le lien uniquement pour la page de connexion
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordRecoveryScreen()),
                  );
                },
                child: Text('Mot de passe oublié ?'),
              ),
          ],
        ),
      ),
    );
  }
}
