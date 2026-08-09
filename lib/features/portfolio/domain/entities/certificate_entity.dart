import 'package:equatable/equatable.dart';

class CertificateEntity extends Equatable {
  final String title;
  final String issuer;
  final String year;
  final String? url;

  const CertificateEntity({
    required this.title,
    required this.issuer,
    required this.year,
    this.url,
  });

  @override
  List<Object?> get props => [title, issuer, year, url];
}
