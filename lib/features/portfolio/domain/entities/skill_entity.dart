import 'package:equatable/equatable.dart';

class SkillEntity extends Equatable {
  final String name;
  final String iconGlyph;
  final int percentage;

  const SkillEntity({
    required this.name,
    required this.iconGlyph,
    required this.percentage,
  });

  @override
  List<Object?> get props => [name, iconGlyph, percentage];
}
