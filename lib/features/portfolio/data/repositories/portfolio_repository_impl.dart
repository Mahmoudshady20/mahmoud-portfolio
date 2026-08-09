import '../../domain/entities/nav_item.dart';
import '../../domain/entities/stat_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/certificate_entity.dart';
import '../../domain/entities/testimonial_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  PortfolioRepositoryImpl({required this.localDataSource});

  @override
  List<NavItem> getNavItems() => localDataSource.getNavItems();

  @override
  List<StatEntity> getHeaderStats() => localDataSource.getHeaderStats();

  @override
  List<StatEntity> getImpactStats() => localDataSource.getImpactStats();

  @override
  List<ExperienceEntity> getExperiences() => localDataSource.getExperiences();

  @override
  List<SkillEntity> getSkills() => localDataSource.getSkills();

  @override
  List<ProjectEntity> getProjects() => localDataSource.getProjects();

  @override
  List<CertificateEntity> getCertificates() => localDataSource.getCertificates();

  @override
  List<TestimonialEntity> getTestimonials() => localDataSource.getTestimonials();

  @override
  List<String> getAboutSkills() => localDataSource.getAboutSkills();
}
