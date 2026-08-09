import '../../domain/entities/nav_item.dart';
import '../../domain/entities/stat_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/certificate_entity.dart';
import '../../domain/entities/testimonial_entity.dart';

abstract class PortfolioLocalDataSource {
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

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  @override
  List<NavItem> getNavItems() {
    return const [
      NavItem(label: "Home", sectionKey: "home"),
      NavItem(label: "About", sectionKey: "about"),
      NavItem(label: "Experience", sectionKey: "experience"),
      NavItem(label: "Projects", sectionKey: "projects"),
      NavItem(label: "Skills", sectionKey: "skills"),
      NavItem(label: "Certificates", sectionKey: "certificates"),
      NavItem(label: "Testimonials", sectionKey: "testimonials"),
      NavItem(label: "Contact", sectionKey: "contact"),
    ];
  }

  @override
  List<StatEntity> getHeaderStats() {
    return const [
      StatEntity(iconGlyph: "◈", value: "4+", label: "Years Experience"),
      StatEntity(iconGlyph: "◉", value: "10+", label: "Published Apps"),
      StatEntity(iconGlyph: "◎", value: "1M+", label: "App Downloads"),
      StatEntity(iconGlyph: "◆", value: "3", label: "Companies Worked"),
      StatEntity(iconGlyph: "⬡", value: "22+", label: "Technologies"),
      StatEntity(iconGlyph: "✦", value: "4", label: "Certificates"),
    ];
  }

  @override
  List<StatEntity> getImpactStats() {
    return const [
      StatEntity(iconGlyph: "◈", value: "4+", label: "Years Experience"),
      StatEntity(iconGlyph: "◉", value: "10+", label: "Apps Published"),
      StatEntity(iconGlyph: "◆", value: "3", label: "Companies"),
      StatEntity(iconGlyph: "◎", value: "1M+", label: "Downloads"),
      StatEntity(iconGlyph: "⬡", value: "22+", label: "Technologies"),
      StatEntity(iconGlyph: "✦", value: "4", label: "Certificates"),
    ];
  }

  @override
  List<ExperienceEntity> getExperiences() {
    return const [
      ExperienceEntity(
        number: "01",
        role: "Flutter Developer",
        company: "TARA Company",
        period: "Jul 2025 – Present",
        description:
            "Leading Flutter development for enterprise-grade mobile applications, architecting robust scalable codebases, and collaborating with cross-functional teams to deliver exceptional digital experiences.",
        technologies: [
          "Flutter",
          "Dart",
          "Bloc",
          "Firebase",
          "Clean Architecture",
          "REST API",
        ],
      ),
      ExperienceEntity(
        number: "02",
        role: "Flutter Developer",
        company: "Phlera Company",
        period: "Mar 2024 – Jun 2025",
        description:
            "Built and shipped multiple cross-platform applications with complex state management, realtime cloud integrations, offline caching, and intuitive reactive user interfaces.",
        technologies: [
          "Flutter",
          "Firebase",
          "Supabase",
          "Provider",
          "Cubit",
          "Dio",
        ],
      ),
      ExperienceEntity(
        number: "03",
        role: "Flutter Trainee",
        company: "Shbaak Company",
        period: "Aug 2023 – Jan 2024",
        description:
            "Intensive hands-on training in Flutter development, mastering Clean Architecture, local database management with Hive and SQLite, and building responsive production-ready UIs.",
        technologies: [
          "Flutter",
          "Dart",
          "Git",
          "Hive",
          "SQLite",
          "Responsive UI",
        ],
      ),
    ];
  }

  @override
  List<SkillEntity> getSkills() {
    return const [
      SkillEntity(name: "Flutter", iconGlyph: "⬡", percentage: 95),
      SkillEntity(name: "Dart", iconGlyph: "◆", percentage: 93),
      SkillEntity(name: "Firebase", iconGlyph: "🔥", percentage: 88),
      SkillEntity(name: "Supabase", iconGlyph: "⚡", percentage: 82),
      SkillEntity(name: "Bloc", iconGlyph: "◉", percentage: 90),
      SkillEntity(name: "Cubit", iconGlyph: "◎", percentage: 88),
      SkillEntity(name: "Provider", iconGlyph: "◈", percentage: 85),
      SkillEntity(name: "REST API", iconGlyph: "⇄", percentage: 87),
      SkillEntity(name: "Dio", iconGlyph: "⟳", percentage: 85),
      SkillEntity(name: "Git", iconGlyph: "⑂", percentage: 88),
      SkillEntity(name: "Android", iconGlyph: "◉", percentage: 80),
      SkillEntity(name: "Java", iconGlyph: "☕", percentage: 75),
      SkillEntity(name: "Hive", iconGlyph: "▣", percentage: 83),
      SkillEntity(name: "SQLite", iconGlyph: "◧", percentage: 80),
      SkillEntity(name: "MVVM", iconGlyph: "⊞", percentage: 90),
      SkillEntity(name: "Clean Arch", iconGlyph: "◍", percentage: 92),
      SkillEntity(name: "SOLID", iconGlyph: "◑", percentage: 88),
      SkillEntity(name: "Animations", iconGlyph: "✦", percentage: 85),
      SkillEntity(name: "Responsive UI", iconGlyph: "▤", percentage: 91),
      SkillEntity(name: "Localization", iconGlyph: "◎", percentage: 85),
      SkillEntity(name: "Dep. Injection", iconGlyph: "◉", percentage: 87),
      SkillEntity(name: "Figma", iconGlyph: "◈", percentage: 78),
    ];
  }

  @override
  List<ProjectEntity> getProjects() {
    return const [
      ProjectEntity(
        number: "01",
        title: "Qudratuh",
        category: "Productivity & Self-Growth Platform",
        description:
            "A comprehensive self-improvement application built to empower users with personalized habit tracking, goal milestones, comprehensive progress analytics, and smart notifications.",
        features: [
          "Habit streak tracking",
          "Goal analytics dashboard",
          "Push notifications",
          "Offline-first storage",
        ],
        techStack: [
          "Flutter",
          "Firebase",
          "Bloc",
          "Clean Architecture",
          "Hive",
        ],
        liveDemoUrl: "https://github.com/mahmoudshady25",
        githubUrl: "https://github.com/mahmoudshady25",
        playStoreUrl: "https://play.google.com",
      ),
      ProjectEntity(
        number: "02",
        title: "Rejeemat",
        category: "E-Commerce & Marketplace App",
        description:
            "Full-featured marketplace application with real-time inventory management, localized payment gateways, instant messaging between buyers and sellers, and bilingual RTL/LTR interface.",
        features: [
          "Real-time inventory",
          "Secure payments",
          "RTL/LTR support",
          "Live chat",
        ],
        techStack: [
          "Flutter",
          "REST API",
          "Dio",
          "Provider",
          "Firebase",
          "Localization",
        ],
        liveDemoUrl: "https://github.com/mahmoudshady25",
        githubUrl: "https://github.com/mahmoudshady25",
        playStoreUrl: "https://play.google.com",
      ),
      ProjectEntity(
        number: "03",
        title: "Green Egypt Eco System",
        category: "Environmental Monitoring Platform",
        description:
            "End-to-end ecosystem management app for environmental data gathering, interactive IoT sensor mapping, live dashboards, automated PDF report generation, and native hardware integration.",
        features: [
          "Sensor data collection",
          "Live dashboards",
          "Geo-mapping",
          "PDF reporting",
        ],
        techStack: [
          "Flutter",
          "Firebase",
          "Bloc",
          "Native Integration",
          "Charts",
        ],
        liveDemoUrl: "https://github.com/mahmoudshady25",
        githubUrl: "https://github.com/mahmoudshady25",
        playStoreUrl: "https://play.google.com",
      ),
      ProjectEntity(
        number: "04",
        title: "Islami",
        category: "Islamic Lifestyle Companion",
        description:
            "Award-winning Islamic lifestyle app with accurate prayer times calculations, complete Holy Quran with recitation audio streaming, Qibla direction compass, and daily smart reminders.",
        features: [
          "Prayer time calculations",
          "Full Quran with audio",
          "Qibla compass",
          "Smart notifications",
        ],
        techStack: [
          "Flutter",
          "Hive",
          "Localization",
          "Animations",
          "SQLite",
        ],
        liveDemoUrl: "https://github.com/mahmoudshady25",
        githubUrl: "https://github.com/mahmoudshady25",
        playStoreUrl: "https://play.google.com",
      ),
      ProjectEntity(
        number: "05",
        title: "HUB Spare Parts",
        category: "B2B Auto Parts Marketplace",
        description:
            "Specialized B2B platform for automotive spare parts sourcing, part number instant verification, bulk quotation requests, supplier dashboards, and live shipment tracking.",
        features: [
          "Part number search",
          "Bulk ordering",
          "Supplier dashboard",
          "Order tracking",
        ],
        techStack: [
          "Flutter",
          "REST API",
          "Dio",
          "Bloc",
          "Firebase",
        ],
        liveDemoUrl: "https://github.com/mahmoudshady25",
        githubUrl: "https://github.com/mahmoudshady25",
        playStoreUrl: "https://play.google.com",
      ),
      ProjectEntity(
        number: "06",
        title: "Doa2k",
        category: "Duas & Supplications App",
        description:
            "Elegant prayer supplications app with categorized Athkar, high-quality audio recitation recordings, customizable bookmarks, favorites synchronization, and offline mode.",
        features: [
          "Audio recitation",
          "Offline access",
          "Daily reminders",
          "Favorites sync",
        ],
        techStack: [
          "Flutter",
          "Hive",
          "Animations",
          "Localization",
          "Responsive UI",
        ],
        liveDemoUrl: "https://github.com/mahmoudshady25",
        githubUrl: "https://github.com/mahmoudshady25",
        playStoreUrl: "https://play.google.com",
      ),
    ];
  }

  @override
  List<CertificateEntity> getCertificates() {
    return const [
      CertificateEntity(
        title: "Route Flutter Course",
        issuer: "Route Academy",
        year: "2024",
        url: "https://github.com/mahmoudshady25",
      ),
      CertificateEntity(
        title: "ITI Android Java",
        issuer: "Information Technology Institute",
        year: "2023",
        url: "https://github.com/mahmoudshady25",
      ),
      CertificateEntity(
        title: "Flutter Bloc & MVVM",
        issuer: "Udemy",
        year: "2024",
        url: "https://github.com/mahmoudshady25",
      ),
      CertificateEntity(
        title: "Responsive UI Design",
        issuer: "Coursera",
        year: "2023",
        url: "https://github.com/mahmoudshady25",
      ),
    ];
  }

  @override
  List<TestimonialEntity> getTestimonials() {
    return const [
      TestimonialEntity(
        authorName: "Ahmed Hassan",
        authorRole: "CTO · TARA Company",
        initials: "AH",
        quote:
            "Mahmoud is one of the most talented Flutter developers I've worked with. His mastery of Clean Architecture, rapid feature turnaround, and deep attention to UI pixel precision made our enterprise launch an overwhelming success.",
      ),
      TestimonialEntity(
        authorName: "Sara Khalil",
        authorRole: "Product Manager · Phlera Company",
        initials: "SK",
        quote:
            "Working with Mahmoud was a pleasure. He quickly grasped complex requirements, proposed optimal architectural solutions, and delivered smooth cross-platform experiences ahead of schedule.",
      ),
      TestimonialEntity(
        authorName: "Omar Fathy",
        authorRole: "Lead Developer · Shbaak Company",
        initials: "OF",
        quote:
            "Mahmoud's Clean Architecture approach and code quality are outstanding. He writes clean, self-documenting code with great testing discipline and brings tremendous passion to every engineering challenge.",
      ),
    ];
  }

  @override
  List<String> getAboutSkills() {
    return const [
      "Flutter",
      "Dart",
      "Firebase",
      "Bloc",
      "Supabase",
      "REST API",
      "Clean Arch",
      "MVVM",
      "SOLID",
    ];
  }
}
