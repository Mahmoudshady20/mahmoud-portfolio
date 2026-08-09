import 'package:equatable/equatable.dart';

class NavItem extends Equatable {
  final String label;
  final String sectionKey;

  const NavItem({
    required this.label,
    required this.sectionKey,
  });

  @override
  List<Object?> get props => [label, sectionKey];
}
