// part of 'FetchAddReview_bloc.dart';

import 'package:equatable/equatable.dart';

sealed class AddReviewEvent extends Equatable {
  const AddReviewEvent();

  @override
  List<Object> get props => [];
}

class AddReviewClickedEvent extends AddReviewEvent {
  // final String email;

  final String token;
  final String bookId;
  final String description;
  final String rate;

  // final bool rememberMe;
  const AddReviewClickedEvent({
    required this.token,
    required this.bookId,
    required this.description,
    required this.rate,
    // required this.rememberMe,
  });
}
