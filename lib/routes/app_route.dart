import 'package:auto_route/annotations.dart';
import 'package:grimoire/features/wiki/presentation/pages/home_page.dart';

@MaterialAutoRouter(
    replaceInRouteName: 'Page,Route',
    routes: <AutoRoute>[AutoRoute(page: HomePage, initial: true)])
class $AppRouter {}
