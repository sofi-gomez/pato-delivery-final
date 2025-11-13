import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pato_delivery_final/bloc/pedidos/pedidos_event.dart';
import 'package:pato_delivery_final/bloc/pedidos/pedidos_state.dart';
import 'package:pato_delivery_final/repositories/pedidos_repository.dart';

class PedidosBloc extends Bloc<PedidosEvent, PedidosState> {
  PedidosBloc(this._pedidosRepository) : super(PedidosInicial()) {
    on<CargarPedidos>(_onCargarPedidos);
  }

  final PedidosRepository _pedidosRepository;

  Future<void> _onCargarPedidos(
      CargarPedidos event, Emitter<PedidosState> emit) async {
    emit(PedidosCargando());

    try {
      final pedidos = await _pedidosRepository.obtenerPedidos();
      emit(PedidosCargados(pedidos));
    } catch (e) {
      emit(PedidosError('Error al cargar los pedidos'));
    }
  }
}
