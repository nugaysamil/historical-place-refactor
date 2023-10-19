import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsuygulama/marker_list.dart';
import 'package:mapsuygulama/feature/data_provider/auth_provider.dart';
import 'package:mapsuygulama/google.dart';

import '../../product/slack/slack_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final _authState = ref.watch(authStateProvider);

    return _authState.when(
      data: (user) {
        if (user != null) {
          return CustomMarkerInfoWindow(
              markers: markers,
              customInfoWindowController: customInfoWindowController);
        } else {
          return SlackScreen();
        }
      },
      error: (e, trace) => const SlackScreen(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
