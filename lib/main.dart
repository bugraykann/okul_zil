import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'features/bell/presentation/providers/shared_preferences_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1024, 768),
    minimumSize: Size(1024, 768),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    title: 'Okul Zili',
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setPreventClose(true); // Prevent default close behavior
  });

  windowManager.addListener(AppWindowListener());

  await trayManager.setIcon(
    Platform.isWindows
        ? 'assets/icons/app_icon.ico'
        : 'assets/icons/app_icon.png',
  );

  Menu menu = Menu(
    items: [
      MenuItem(key: 'show_window', label: 'Arayüzü Göster'),
      MenuItem.separator(),
      MenuItem(key: 'exit_app', label: 'Çıkış'),
    ],
  );
  await trayManager.setContextMenu(menu);

  trayManager.addListener(TrayListenerImpl());

  try {
    launchAtStartup.setup(
      appName: 'Okul Zili',
      appPath: Platform.resolvedExecutable,
    );
    await launchAtStartup.enable();
  } catch (e) {
    debugPrint('Auto-start error: $e');
  }

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const OkulZilApp(),
    ),
  );
}

class TrayListenerImpl extends TrayListener {
  @override
  void onTrayIconMouseDown() {
    windowManager.show();
    windowManager.focus();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    if (menuItem.key == 'show_window') {
      windowManager.show();
      windowManager.focus();
    } else if (menuItem.key == 'exit_app') {
      windowManager.destroy(); // Properly exit
      exit(0);
    }
  }
}

class AppWindowListener extends WindowListener {
  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      windowManager.hide();
    }
  }
}

class OkulZilApp extends StatelessWidget {
  const OkulZilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Okul Zili',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
