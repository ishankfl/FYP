import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class ProviderSignupUserEvent extends Equatable {
  const ProviderSignupUserEvent();

  @override
  List<Object> get props => [];
}

class ProviderSignupUserClickEvent extends ProviderSignupUserEvent {
  final String email;
  final String service_type;
  final String experience;
  final File? profile;
  final File? certificate;
  ProviderSignupUserClickEvent(
      {required this.email,
      required this.service_type,
      required this.experience,
      this.profile,
      this.certificate}) {}
}
