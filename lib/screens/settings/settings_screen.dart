import 'package:flutter/material.dart';
import 'package:lightmeter/generated/l10n.dart';
import 'package:lightmeter/res/dimens.dart';

import 'components/caffeine_tile.dart';
import 'components/haptics_tile.dart';
import 'components/fractional_stops/list_tile_fractional_stops.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: Dimens.grid168,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.all(Dimens.paddingM),
              title: Text(
                S.of(context).settings,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 24),
              ),
            ),
            actions: [
              IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const FractionalStopsListTile(),
                const CaffeineListTile(),
                const HapticsListTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
