import 'dart:io';

import 'package:editor_app/core/di/service_locator.dart';
import 'package:editor_app/features/home/presentation/cubit/download_cubit.dart';
import 'package:editor_app/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    DesktopWindow.setMinWindowSize(const Size(1200, 800));
    DesktopWindow.setMaxWindowSize(Size.infinite);
  }
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => DownloadCubit(docxGenerator: sl(),),
        child: const MyHomePage(title: 'ERP'),
      ),
    );
  }
}
