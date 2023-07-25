import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'magic_ball_response.g.dart';

@JsonSerializable()
class MagicBallResponse extends Equatable {
  final String reading;

  const MagicBallResponse({
    required this.reading,
  });

  factory MagicBallResponse.fromJson(Map<String, dynamic> json) => _$MagicBallResponseFromJson(json);

  @override
  List<Object?> get props => [reading];
}
