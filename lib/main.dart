
import 'package:flutter/material.dart';
import 'package:padosi/providers/user_profile_provider.dart';
import 'package:padosi/screens/comments_screen.dart';
import 'package:padosi/screens/home_screen.dart';
import 'package:padosi/screens/likes_screen.dart';
import 'package:padosi/screens/profile_screen.dart';
import 'package:padosi/screens/shares_screen.dart';
import 'package:padosi/screens/tadka_screen.dart';
import 'package:padosi/screens/wrapper.dart';
import 'package:padosi/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Wrapper();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: 'tadka',
          builder: (BuildContext context, GoRouterState state) {
            return const TadkaScreen();
          },
        ),
        GoRoute(
          path: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileScreen();
          },
        ),
        GoRoute(
          path: 'likes',
          builder: (BuildContext context, GoRouterState state) {
            return const LikesScreen();
          },
        ),
        GoRoute(
          path: 'comments',
          builder: (BuildContext context, GoRouterState state) {
            return const CommentsScreen();
          },
        ),
        GoRoute(
          path: 'shares',
          builder: (BuildContext context, GoRouterState state) {
            return const SharesScreen();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProfileProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Padosi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
