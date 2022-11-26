import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lightmeter/screens/settings/settings_page_route_builder.dart';

import 'generated/l10n.dart';
import 'models/photography_value.dart';
import 'res/dimens.dart';
import 'res/theme.dart';
import 'screens/metering/metering_bloc.dart';
import 'screens/metering/metering_screen.dart';
import 'utils/stop_type_provider.dart';

void main() {
  runApp(const Application());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final _settingsRouteObserver = _SettingsRouteObserver(onPush: _onSettingsPush, onPop: _onSettingsPop);

  @override
  void initState() {
    super.initState();
    // 0 - collapsed
    // 1 - expanded
    _animationController = AnimationController(
      value: 0,
      duration: Dimens.durationM,
      reverseDuration: Dimens.durationSM,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StopTypeProvider(
      child: BlocProvider(
        create: (context) => MeteringBloc(context.read<StopType>()),
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          navigatorObservers: [_settingsRouteObserver],
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: MeteringScreen(animationController: _animationController),
        ),
      ),
    );
  }

  void _onSettingsPush() {
    if (!_animationController.isAnimating && _animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    }
  }

  void _onSettingsPop() {
    Future.delayed(Dimens.durationSM).then((_) {
      if (!_animationController.isAnimating && _animationController.status != AnimationStatus.dismissed) {
        _animationController.reverse();
      }
    });
  }
}

class _SettingsRouteObserver extends RouteObserver<SettingsPageRouteBuilder> {
  final VoidCallback onPush;
  final VoidCallback onPop;

  _SettingsRouteObserver({
    required this.onPush,
    required this.onPop,
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is SettingsPageRouteBuilder) {
      onPush();
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is SettingsPageRouteBuilder) {
      onPop();
    }
  }
}
