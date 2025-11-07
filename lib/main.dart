
import 'package:flutter/material.dart';
import 'package:padosi/providers/user_profile_provider.dart';
import 'package:padosi/screens/comments_screen.dart';
import 'package:padosi/screens/home_screen.dart';
import 'package:padosi/screens/likes_screen.dart';
import 'package:padosi/screens/profile_screen.dart';
import 'package:padosi/screens/shares_screen.dart';
import 'package:padosi/screens/tadka_screen.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
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
    return ChangeNotifierProvider(
      create: (context) => UserProfileProvider(),
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

