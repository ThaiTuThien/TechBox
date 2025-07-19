import 'package:equatable/equatable.dart';

class UpdateReviewDto extends Equatable{
  final int rating;
  final String comment;

  const UpdateReviewDto({
    required this.rating,
    required this.comment
  });

  Map<String, dynamic> toJson() => {
    'rating': rating,
    'comment': comment
  };

  @override
  List<Object?> get props => [rating, comment];
} 