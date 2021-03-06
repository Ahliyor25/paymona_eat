import 'package:dart_lesson/library/widgets/Inherited/provider.dart';
import 'package:dart_lesson/ui/widgets/auth/auth_model.dart';
import 'package:dart_lesson/ui/widgets/auth/auth_widget.dart';
import 'package:dart_lesson/ui/widgets/eats_details/eat_details.dart';
import 'package:dart_lesson/ui/widgets/eats_details/eat_details_model.dart';
import 'package:dart_lesson/ui/widgets/main_screen/main_screen_model.dart';
import 'package:dart_lesson/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:dart_lesson/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:flutter/material.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const eatsDetails = '/eat_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) => NotifierProvider(
          create: () => AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRouteNames.mainScreen: (context) => NotifierProvider(
        create: () => MainScreenModel(), child: const MainScreenWidget()),
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;

        return MaterialPageRoute(
          builder: (context) => MovieDetailsWidget(movieId: movieId),
        );
      case MainNavigationRouteNames.eatsDetails:
        final arguments = settings.arguments;
        final eatsId = arguments is int ? arguments : 0;
        return MaterialPageRoute(builder: (context) => NotifierProvider(
        create: () => EatDetailsModel(eatsId), child: EatsDetails())
        );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
