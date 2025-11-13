import 'package:equatable/equatable.dart';

abstract class PedidosEvent extends Equatable {
  const PedidosEvent();

  @override
  List<Object?> get props => [];
}

class CargarPedidos extends PedidosEvent {}
