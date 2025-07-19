import 'package:equatable/equatable.dart';

class CreateReviewDto extends Equatable{
  final String variant;
  final int rating;
  final String comment;

  const CreateReviewDto({
    required this.variant,
    required this.rating,
    required this.comment
  });

  Map<String, dynamic> toJson() => {
    'variant': variant, 
    'rating': rating,
    'comment': comment
  };

  @override
  List<Object?> get props => [variant, rating, comment];
} 