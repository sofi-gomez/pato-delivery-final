import 'package:equatable/equatable.dart';
import 'package:pato_delivery_final/models/pedido_model.dart';

abstract class PedidosState extends Equatable {
  const PedidosState();

  @override
  List<Object?> get props => [];
}

class PedidosInicial extends PedidosState {}

class PedidosCargando extends PedidosState {}

class PedidosCargados extends PedidosState {
  final List<Pedido> pedidos;

  const PedidosCargados(this.pedidos);

  @override
  List<Object?> get props => [pedidos];
}

class PedidosError extends PedidosState {
  final String mensaje;

  const PedidosError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}
