import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/app/app.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MahmoudPortfolioApp());
}
