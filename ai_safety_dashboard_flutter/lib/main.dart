import 'package:ai_safety_dashboard_flutter/models/incident_model.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_incident_screen.dart';
import 'screens/incident_detail_screen.dart';
import 'screens/help_screen.dart';
import 'package:provider/provider.dart';
import 'providers/incident_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IncidentProvider(),
      child: MaterialApp(
        title: 'AI Safety App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/home': (context) => HomeScreen(),
          '/add-incident': (context) => AddIncidentScreen(),
          '/incident-detail': (context) => IncidentDetailScreen(incident: ModalRoute.of(context)?.settings.arguments as Incident),
          '/help': (context) => HelpScreen(),
        },
      ),
    );
  }
}
