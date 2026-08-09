import 'package:equatable/equatable.dart';

class TestimonialEntity extends Equatable {
  final String authorName;
  final String authorRole;
  final String initials;
  final String quote;

  const TestimonialEntity({
    required this.authorName,
    required this.authorRole,
    required this.initials,
    required this.quote,
  });

  @override
  List<Object?> get props => [authorName, authorRole, initials, quote];
}
