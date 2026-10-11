import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String number,
      slug,
      title,
      category,
      status,
      heading,
      description,
      ownership,
      challenge,
      outcome;
  final List<String> features, techStack, visual;
  final int color;
  final String? liveDemoUrl, githubUrl, playStoreUrl, appStoreUrl;
  const ProjectEntity({
    required this.number,
    required this.title,
    required this.category,
    required this.description,
    required this.features,
    required this.techStack,
    this.slug = '',
    this.status = '',
    this.heading = '',
    this.ownership = '',
    this.challenge = '',
    this.outcome = '',
    this.visual = const [],
    this.color = 0xffded2ed,
    this.liveDemoUrl,
    this.githubUrl,
    this.playStoreUrl,
    this.appStoreUrl,
  });
  @override
  List<Object?> get props => [
    number,
    slug,
    title,
    category,
    status,
    heading,
    description,
    ownership,
    features,
    challenge,
    outcome,
    techStack,
    color,
    visual,
    liveDemoUrl,
    githubUrl,
    playStoreUrl,
    appStoreUrl,
  ];
}
