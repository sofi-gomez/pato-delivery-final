import 'package:equatable/equatable.dart';
import 'package:pato_delivery_final/models/repartidor_model.dart';

class RankingResumen extends Equatable {
  final List<Repartidor> repartidores;
  final Repartidor usuarioActual;

  const RankingResumen({
    required this.repartidores,
    required this.usuarioActual,
  });

  List<Repartidor> get topTres => repartidores.take(3).toList();

  List<Repartidor> get resto => repartidores.length <= 3 ? [] : repartidores.sublist(3);

  @override
  List<Object?> get props => [repartidores, usuarioActual];
}
