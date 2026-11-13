import 'package:flutter/material.dart';

import 'app/theme.dart';
import 'os/device_canvas.dart';
import 'os/os_shell.dart';

void main() => runApp(const PhoneOS());

/// Корневой виджет визитки: «телефон» с экраном блокировки и рабочим столом.
class PhoneOS extends StatelessWidget {
  const PhoneOS({super.key, this.useGoogleFonts = true});

  final bool useGoogleFonts;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(useGoogleFonts: useGoogleFonts),
      darkTheme: AppTheme.dark(useGoogleFonts: useGoogleFonts),
      themeMode: ThemeMode.system,
      builder: (context, child) => Material(
        type: MaterialType.transparency,
        child: DeviceCanvas(child: child!),
      ),
      home: const OsShell(),
    );
  }
}
