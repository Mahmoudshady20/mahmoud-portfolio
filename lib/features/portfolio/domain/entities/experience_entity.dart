import 'package:equatable/equatable.dart';

class ExperienceEntity extends Equatable {
  final String number;
  final String role;
  final String company;
  final String period;
  final String description;
  final List<String> technologies;

  const ExperienceEntity({
    required this.number,
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.technologies,
  });

  @override
  List<Object?> get props => [number, role, company, period, description, technologies];
}
