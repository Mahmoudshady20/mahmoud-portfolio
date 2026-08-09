import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String number;
  final String title;
  final String category;
  final String description;
  final List<String> features;
  final List<String> techStack;
  final String? liveDemoUrl;
  final String? githubUrl;
  final String? playStoreUrl;

  const ProjectEntity({
    required this.number,
    required this.title,
    required this.category,
    required this.description,
    required this.features,
    required this.techStack,
    this.liveDemoUrl,
    this.githubUrl,
    this.playStoreUrl,
  });

  @override
  List<Object?> get props => [
        number,
        title,
        category,
        description,
        features,
        techStack,
        liveDemoUrl,
        githubUrl,
        playStoreUrl,
      ];
}
