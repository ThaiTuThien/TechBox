import 'package:equatable/equatable.dart';

class ExchangePointVoucherDto extends Equatable{
  final int pointsToUse;

  const ExchangePointVoucherDto({
    required this.pointsToUse
  });

  Map<String, dynamic> toJson() => {
    'pointsToUse': pointsToUse
  };

  @override
  List<Object?> get props => [pointsToUse];
}