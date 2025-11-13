import 'package:equatable/equatable.dart';

class Repartidor extends Equatable {
  final int rank;
  final String nombre;
  final int entregas;
  final double rating;
  final int tiempoPromedio;
  final String avatarUrl;

  const Repartidor({
    required this.rank,
    required this.nombre,
    required this.entregas,
    required this.rating,
    required this.tiempoPromedio,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [rank, nombre, entregas, rating, tiempoPromedio, avatarUrl];
}
