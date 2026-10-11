import '../../domain/entities/nav_item.dart';
import '../../domain/entities/stat_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/certificate_entity.dart';
import '../../domain/entities/education_entity.dart';

abstract class PortfolioLocalDataSource {
  List<NavItem> getNavItems();
  List<StatEntity> getHeaderStats();
  List<StatEntity> getImpactStats();
  List<ExperienceEntity> getExperiences();
  List<EducationEntity> getEducation();
  List<SkillEntity> getSkills();
  List<ProjectEntity> getProjects();
  List<CertificateEntity> getCertificates();
  List<String> getAboutSkills();
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  final Map<String, dynamic> data;
  PortfolioLocalDataSourceImpl(this.data);
  List<String> _strings(dynamic value) => List<String>.from(value as List);
  @override
  List<NavItem> getNavItems() => const [
    NavItem(label: 'Work', sectionKey: 'projects'),
    NavItem(label: 'About', sectionKey: 'about'),
    NavItem(label: 'Experience', sectionKey: 'experience'),
    NavItem(label: 'Expertise', sectionKey: 'skills'),
    NavItem(label: 'Contact', sectionKey: 'contact'),
  ];
  @override
  List<StatEntity> getHeaderStats() => const [];
  @override
  List<StatEntity> getImpactStats() => const [];
  @override
  List<CertificateEntity> getCertificates() => const [];
  @override
  List<String> getAboutSkills() => const [
    'Software engineering',
    'Mobile architecture',
    'Flutter & Dart',
    'Production delivery',
  ];

  @override
  List<EducationEntity> getEducation() => (data['education'] as List)
      .map(
        (x) => EducationEntity(
          school: x['school'],
          degree: x['degree'],
          period: x['period'],
        ),
      )
      .toList(growable: false);
  @override
  List<ExperienceEntity> getExperiences() => (data['experience'] as List)
      .map(
        (x) => ExperienceEntity(
          number: x['number'],
          role: x['role'],
          company: x['company'],
          period: x['period'],
          description: x['description'],
          technologies: _strings(x['technologies']),
        ),
      )
      .toList(growable: false);
  @override
  List<SkillEntity> getSkills() => (data['expertise'] as List)
      .map(
        (x) => SkillEntity(
          name: x['name'],
          description: x['description'],
          technologies: _strings(x['technologies']),
        ),
      )
      .toList(growable: false);
  @override
  List<ProjectEntity> getProjects() => (data['projects'] as List)
      .map(
        (x) => ProjectEntity(
          number: x['number'],
          slug: x['slug'],
          title: x['title'],
          category: x['category'],
          status: x['status'],
          heading: x['heading'],
          description: x['description'],
          ownership: x['ownership'],
          features: _strings(x['features']),
          challenge: x['challenge'],
          outcome: x['outcome'],
          techStack: _strings(x['techStack']),
          visual: _strings(x['visual']),
          color: x['color'],
          playStoreUrl: x['playStoreUrl'],
          appStoreUrl: x['appStoreUrl'],
        ),
      )
      .toList(growable: false);
}
