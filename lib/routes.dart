import 'package:flutter/material.dart';
import 'package:psmnn/screens/Register_screen.dart';
import 'package:psmnn/screens/add_post_dcreen.dart';
import 'package:psmnn/screens/eventos_screen.dart';
import 'package:psmnn/screens/dashboard_screen.dart';
import 'package:psmnn/screens/list_favorites_cloud.dart';
import 'package:psmnn/screens/list_popular_videos.dart';
import 'package:psmnn/screens/login_screen.dart';
import 'package:psmnn/screens/map_screen.dart';
import 'package:psmnn/screens/pages/profile_screen.dart';
import 'package:psmnn/screens/themeSelector_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => const LoginScreen(),
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/theme': (BuildContext context) => const ThemeSelectorScreen(),
    '/add': (BuildContext context) => AddPostScreen(),
    '/eventos': (BuildContext context) => const EventosScreen(),
    '/popular': (BuildContext context) => const ListPopularVideos(),
    '/profile': (BuildContext context) => ProfileScreen(),
    '/favorites': (BuildContext context) => const ListFavoritesCloud(),
    '/maps': (BuildContext context) => const MapSample(),
  };
}
