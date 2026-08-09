import '../../domain/entities/nav_item.dart';
import '../../domain/entities/stat_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/certificate_entity.dart';

abstract class PortfolioLocalDataSource {
  List<NavItem> getNavItems();
  List<StatEntity> getHeaderStats();
  List<StatEntity> getImpactStats();
  List<ExperienceEntity> getExperiences();
  List<SkillEntity> getSkills();
  List<ProjectEntity> getProjects();
  List<CertificateEntity> getCertificates();
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
      StatEntity(iconGlyph: "◈", value: "2+", label: "Years Experience"),
      StatEntity(iconGlyph: "◉", value: "10+", label: "Published Apps"),
      StatEntity(iconGlyph: "◎", value: "3M+", label: "App Downloads"),
      StatEntity(iconGlyph: "◆", value: "3", label: "Companies Worked"),
      StatEntity(iconGlyph: "⬡", value: "22+", label: "Technologies"),
      StatEntity(iconGlyph: "✦", value: "6", label: "Certificates"),
    ];
  }

  @override
  List<StatEntity> getImpactStats() {
    return const [
      StatEntity(iconGlyph: "◈", value: "2+", label: "Years Experience"),
      StatEntity(iconGlyph: "◉", value: "10+", label: "Apps Published"),
      StatEntity(iconGlyph: "◆", value: "3", label: "Companies"),
      StatEntity(iconGlyph: "◎", value: "3M+", label: "Downloads"),
      StatEntity(iconGlyph: "⬡", value: "22+", label: "Technologies"),
      StatEntity(iconGlyph: "✦", value: "6", label: "Certificates"),
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
      SkillEntity(name: "Flutter", iconGlyph: "⬡", percentage: 100),
      SkillEntity(name: "Dart", iconGlyph: "◆", percentage: 100),
      SkillEntity(name: "Firebase", iconGlyph: "🔥", percentage: 90),
      SkillEntity(name: "Supabase", iconGlyph: "⚡", percentage: 90),
      SkillEntity(name: "Bloc", iconGlyph: "◉", percentage: 95),
      SkillEntity(name: "Cubit", iconGlyph: "◎", percentage: 95),
      SkillEntity(name: "Provider", iconGlyph: "◈", percentage: 95),
      SkillEntity(name: "REST API", iconGlyph: "⇄", percentage: 95),
      SkillEntity(name: "Dio", iconGlyph: "⟳", percentage: 95),
      SkillEntity(name: "Git", iconGlyph: "⑂", percentage: 90),
      SkillEntity(name: "Android", iconGlyph: "◉", percentage: 90),
      SkillEntity(name: "Java", iconGlyph: "☕", percentage: 90),
      SkillEntity(name: "Hive", iconGlyph: "▣", percentage: 90),
      SkillEntity(name: "SQLite", iconGlyph: "◧", percentage: 85),
      SkillEntity(name: "MVVM", iconGlyph: "⊞", percentage: 95),
      SkillEntity(name: "Clean Arch", iconGlyph: "◍", percentage: 95),
      SkillEntity(name: "SOLID", iconGlyph: "◑", percentage: 95),
      SkillEntity(name: "Animations", iconGlyph: "✦", percentage: 80),
      SkillEntity(name: "Responsive UI", iconGlyph: "▤", percentage: 90),
      SkillEntity(name: "Localization", iconGlyph: "◎", percentage: 85),
      SkillEntity(name: "Dep. Injection", iconGlyph: "◉", percentage: 90),
      SkillEntity(name: "Figma", iconGlyph: "◈", percentage: 90),
    ];
  }

  @override
  List<ProjectEntity> getProjects() {
    return const [
      ProjectEntity(
        number: "01",
        title: "RosyCalc",
        category: "Women's Health & Wellness",
        description:
            "RosyCalc is a women's health companion designed to help users track their menstrual cycles, understand their health patterns, and stay connected through a supportive community. It combines smart cycle predictions, symptom tracking, health articles, social features, and intelligent notifications in a privacy-focused experience.",
        features: [
          "Smart Cycle Tracking",
          "Interactive Calendar",
          "Symptom Tracking",
          "Health Articles",
          "Community Platform",
          "Smart Notifications",
          "Multi-Language Support",
          "Profile Customization",
        ],
        techStack: [
          "Flutter",
          "Bloc",
          "Clean Architecture",
          "Firebase",
          "Hive",
          "Dio",
          "GetIt",
          "GoRouter",
        ],
        liveDemoUrl: "https://github.com/mahmoudshady255",
        githubUrl: "https://github.com/mahmoudshady255",
        playStoreUrl: "https://play.google.com",
      ),
      ProjectEntity(
        number: "02",
        title: "Qudratuh",
        category: "Education & Self Growth",
        description:
            "Qudratuh is a gamified aptitude preparation platform designed for Saudi students preparing for the national Qudrat test. It combines AI-powered assessments, daily challenges, personalized practice, advanced gamification, performance analytics, and competitive leaderboards to help students build sustainable learning habits and improve their cognitive performance.",
        features: [
          "AI-Powered Adaptive Placement",
          "Daily Challenges",
          "Precision Skill Training",
          "Advanced Gamification",
          "Performance Analytics",
          "Global Leaderboards",
        ],
        techStack: [
          "Flutter",
          "Dio",
          "Bloc",
          "Clean Architecture",
          "Firebase",
          "Hive",
          "GetIt",
          "Secure Storage",
        ],
        liveDemoUrl: "https://github.com/Mahmoudshady20/Qudratuhh",
        githubUrl: "https://github.com/Mahmoudshady20/Qudratuhh",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=cc.hayah.qdrato",
      ),

      ProjectEntity(
        number: "03",
        title: "Rejeemat",
        category: "Health & Lifestyle",
        description:
            "Rejeemat is a smart, culturally localized food and diet planning application designed for the Saudi market. It provides personalized weekly meal plans, intelligent meal swapping, automated grocery lists, leftover suggestions, behavioral tracking, and detailed progress analytics while adapting recipes and ingredients to local dietary preferences.",
        features: [
          "Intelligent Weekly Meal Planning",
          "Smart Meal Swapping",
          "Automated Grocery Lists",
          "Leftover Saver",
          "Energy Window Tracking",
          "Progress Analytics",
          "Localized Ingredients",
        ],
        techStack: [
          "Flutter",
          "Dio",
          "Bloc",
          "Clean Architecture",
          "Firebase",
          "Hive",
          "GetIt",
          "Secure Storage",
        ],
        liveDemoUrl: "https://github.com/Mahmoudshady20/Rejeematt",
        githubUrl: "https://github.com/Mahmoudshady20/Rejeematt",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=cc.hayah.rogemat",
      ),

      ProjectEntity(
        number: "04",
        title: "Green Egypt Eco System",
        category: "Environmental & IoT Platform",
        description:
            "Green Egypt Eco System is an end-to-end recycling platform consisting of multiple Flutter applications that work together with smart recycling machines. The ecosystem handles user accounts, recycling transactions, QR code processing, points and cashback, object detection, Bluetooth communication, Arduino signals, and real-time machine interactions.",
        features: [
          "Recycling Management",
          "IoT Machine Integration",
          "AI Object Detection",
          "QR Code Transactions",
          "Points & Cashback System",
          "Bluetooth Communication",
          "Responsive UI",
        ],
        techStack: [
          "Flutter",
          "Firebase",
          "Bloc",
          "Hive",
          "TFLite",
          "Google ML Kit",
          "Bluetooth",
          "Arduino",
        ],
        liveDemoUrl: "https://github.com/Mohamad-Daif/GE_Eco_System",
        githubUrl: "https://github.com/Mohamad-Daif/GE_Eco_System",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.daif.recycling_eco_system",
      ),

      ProjectEntity(
        number: "05",
        title: "Islami",
        category: "Islamic Lifestyle",
        description:
            "Islami is a mobile Islamic lifestyle companion designed to help users stay connected with their daily religious practices through prayer time calculations, Quran content, Qibla direction, daily reminders, localization, and a smooth mobile experience.",
        features: [
          "Prayer Time Calculations",
          "Holy Quran",
          "Qibla Direction",
          "Daily Reminders",
          "Arabic & English Localization",
          "Smooth Animations",
        ],
        techStack: ["Flutter", "Hive", "SQLite", "Localization", "Animations"],
        liveDemoUrl: "https://github.com/Mahmoudshady20/Islami-App",
        githubUrl: "https://github.com/Mahmoudshady20/Islami-App",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.example.muslim.islami_app",
      ),

      ProjectEntity(
        number: "06",
        title: "Doa2k",
        category: "Medication Management",
        description:
            "Doa2k is a Flutter-based medication management application designed to help users organize their medications, schedule smart reminders, track dosage history, and monitor adherence through an intuitive and scalable architecture.",
        features: [
          "Smart Medication Reminders",
          "Medication Logs",
          "Adherence Analytics",
          "Dark Mode",
          "Cross-Device Synchronization",
          "Background Task Scheduling",
          "Local Notifications",
        ],
        techStack: [
          "Flutter",
          "Bloc",
          "Hive",
          "Firebase",
          "GetIt",
          "Local Notifications",
          "WorkManager",
          "Timezone",
        ],
        liveDemoUrl: "https://github.com/Mahmoudshady20/doa2k",
        githubUrl: "https://github.com/Mahmoudshady20/doa2k",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.example.doaa",
      ),

      ProjectEntity(
        number: "07",
        title: "Sba7o Rz3",
        category: "Football Trivia Game",
        description:
            "Sba7o Rz3 is an interactive football challenge game designed for football fans. It combines trivia questions, dynamic gameplay, real-time feedback, leaderboards, custom animations, and adaptive layouts to create an engaging football knowledge experience.",
        features: [
          "Football Trivia Questions",
          "Interactive Gameplay",
          "Real-Time Feedback",
          "Leaderboards",
          "Dynamic Content",
          "Dark Mode",
          "Custom Animations",
        ],
        techStack: [
          "Flutter",
          "Cubit",
          "Hive",
          "Provider",
          "Google Fonts",
          "Animations",
          "Localization",
        ],
        liveDemoUrl: "https://github.com/Mahmoudshady20/Sba7o-Rz3-ReadMe",
        githubUrl: "https://github.com/Mahmoudshady20/Sba7o-Rz3-ReadMe",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.example.sba7o_rz3_new_ui",
      ),

      ProjectEntity(
        number: "08",
        title: "Greena",
        category: "E-Commerce",
        description:
            "Greena is a feature-rich e-commerce application built with Flutter to provide a fast, responsive, and seamless shopping experience. It supports product discovery, personalized recommendations, wishlists, secure payments, order tracking, reviews, location-based services, and multi-language support.",
        features: [
          "Seamless Shopping",
          "Personalized Recommendations",
          "Wishlist & Favorites",
          "Secure Payments",
          "Order Tracking",
          "Product Reviews & Ratings",
          "Google Maps Integration",
          "Multi-Language Support",
        ],
        techStack: [
          "Flutter",
          "Bloc",
          "GetX",
          "Firebase",
          "Hive",
          "Google Maps",
          "Tabby",
          "REST API",
        ],
        liveDemoUrl: "https://github.com/Mahmoudshady20/greena-app",
        githubUrl: "https://github.com/Mahmoudshady20/greena-app",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.example.greena_app",
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
        url: "https://github.com/mahmoudshady20",
      ),
      CertificateEntity(
        title: "ITI Android Java",
        issuer: "Information Technology Institute",
        year: "2023",
        url: "https://github.com/mahmoudshady20",
      ),
      CertificateEntity(
        title: "Flutter Bloc & MVVM",
        issuer: "Udemy",
        year: "2024",
        url: "https://github.com/mahmoudshady20",
      ),
      CertificateEntity(
        title: "Responsive UI Design",
        issuer: "Coursera",
        year: "2023",
        url: "https://github.com/mahmoudshady20",
      ),
    ];
  }

  @override
  List<String> getAboutSkills() {
    return const [
      "Flutter",
      "Dart",
      "Java",
      "Android",
      "Cubit",
      "Provider",
      "GetIt",
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
