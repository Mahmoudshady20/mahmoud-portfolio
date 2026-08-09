import 'package:get_it/get_it.dart';
import '../../features/portfolio/data/datasources/portfolio_local_data_source.dart';
import '../../features/portfolio/data/repositories/portfolio_repository_impl.dart';
import '../../features/portfolio/domain/repositories/portfolio_repository.dart';
import '../../features/portfolio/presentation/cubit/navigation_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Data sources
  sl.registerLazySingleton<PortfolioLocalDataSource>(
    () => PortfolioLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(localDataSource: sl()),
  );

  // Cubits / State
  sl.registerFactory<NavigationCubit>(
    () => NavigationCubit(),
  );
}
