import 'package:equatable/equatable.dart';

class StatEntity extends Equatable {
  final String iconGlyph;
  final String value;
  final String label;

  const StatEntity({
    required this.iconGlyph,
    required this.value,
    required this.label,
  });

  @override
  List<Object?> get props => [iconGlyph, value, label];
}
