import 'package:equatable/equatable.dart';
import 'package:pato_delivery_final/models/ranking_resumen.dart';

abstract class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object?> get props => [];
}

class RankingInicial extends RankingState {
  const RankingInicial();
}

class RankingCargando extends RankingState {
  const RankingCargando();
}

class RankingCargado extends RankingState {
  final RankingResumen resumen;

  const RankingCargado(this.resumen);

  @override
  List<Object?> get props => [resumen];
}

class RankingError extends RankingState {
  final String mensaje;

  const RankingError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}
