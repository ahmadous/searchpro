import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/admin_dashboard.dart';
import 'screens/manager_dashboard.dart';
import 'screens/user_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'SearchPro',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Vérifie si l'utilisateur est connecté
    if (authProvider.user != null) {
      // Redirige vers le tableau de bord en fonction du rôle de l'utilisateur
      switch (authProvider.user!.role) {
        case 'admin':
          return AdminDashboard();
        case 'manager':
          return ManagerDashboard();
        default:
          return UserDashboard();
      }
    } else {
      // Si l'utilisateur n'est pas connecté, redirige vers l'écran d'authentification
      return AuthScreen();
    }
  }
}
