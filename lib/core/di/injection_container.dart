import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import '../../features/portfolio/data/datasources/portfolio_local_data_source.dart';
import '../../features/portfolio/data/repositories/portfolio_repository_impl.dart';
import '../../features/portfolio/domain/repositories/portfolio_repository.dart';
import '../../features/portfolio/presentation/cubit/navigation_cubit.dart';

final sl = GetIt.instance;
Future<void> initDependencies() async {
  if (sl.isRegistered<PortfolioRepository>()) return;
  final data =
      jsonDecode(await rootBundle.loadString('assets/data/profile.json'))
          as Map<String, dynamic>;
  sl.registerLazySingleton<PortfolioLocalDataSource>(
    () => PortfolioLocalDataSourceImpl(data),
  );
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(localDataSource: sl()),
  );
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());
}
