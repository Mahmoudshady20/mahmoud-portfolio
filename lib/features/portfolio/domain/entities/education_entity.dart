import 'package:equatable/equatable.dart';

class EducationEntity extends Equatable {
  final String school;
  final String degree;
  final String period;

  const EducationEntity({
    required this.school,
    required this.degree,
    required this.period,
  });

  @override
  List<Object?> get props => [school, degree, period];
}
