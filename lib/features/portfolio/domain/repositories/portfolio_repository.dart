import '../entities/nav_item.dart';
import '../entities/stat_entity.dart';
import '../entities/experience_entity.dart';
import '../entities/skill_entity.dart';
import '../entities/project_entity.dart';
import '../entities/certificate_entity.dart';
import '../entities/testimonial_entity.dart';

abstract class PortfolioRepository {
  List<NavItem> getNavItems();
  List<StatEntity> getHeaderStats();
  List<StatEntity> getImpactStats();
  List<ExperienceEntity> getExperiences();
  List<SkillEntity> getSkills();
  List<ProjectEntity> getProjects();
  List<CertificateEntity> getCertificates();
  List<TestimonialEntity> getTestimonials();
  List<String> getAboutSkills();
}
