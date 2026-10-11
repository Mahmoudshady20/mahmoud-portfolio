import 'package:equatable/equatable.dart';

class SkillEntity extends Equatable {
  final String name, description;
  final List<String> technologies;
  const SkillEntity({
    required this.name,
    required this.description,
    required this.technologies,
  });
  @override
  List<Object?> get props => [name, description, technologies];
}
