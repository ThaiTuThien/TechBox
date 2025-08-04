import 'package:equatable/equatable.dart';

class SlugDto extends Equatable{
  final String slug;

  const SlugDto({
    required this.slug
  });

  Map<String, dynamic> toJson() =>{
    'slug': slug
  };

  @override 
  List<Object?> get props => [slug];
}