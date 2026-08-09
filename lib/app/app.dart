import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/theme/app_theme.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/cubit/navigation_cubit.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/pages/portfolio_page.dart';

class MahmoudPortfolioApp extends StatelessWidget {
  const MahmoudPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (_) => sl<NavigationCubit>(),
      child: MaterialApp(
        title: 'Mahmoud Shady | Flutter Developer Portfolio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const PortfolioPage(),
      ),
    );
  }
}
