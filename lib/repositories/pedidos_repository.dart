import 'dart:async';

import 'package:pato_delivery_final/models/pedido_model.dart';

/// Repositorio responsable de obtener la información de los pedidos.
///
/// En un futuro próximo esta clase podrá conectarse con Firebase u otro
/// servicio remoto. Por ahora retorna datos simulados para mantener la
/// arquitectura desacoplada del origen de datos.
class PedidosRepository {
  const PedidosRepository();

  Future<List<Pedido>> obtenerPedidos() async {
    await Future.delayed(const Duration(seconds: 1));

    return const [
      Pedido(
        id: '001',
        restaurante: 'Restaurante El Pato Feliz',
        items: ['Hamburguesa', 'Papas Fritas', 'Gaseosa'],
        estado: 'Entregado',
        direccion: 'Calle 123',
        repartidor: 'Carlos Pérez',
        calificacion: 4.8,
        total: 25000.0,
      ),
      Pedido(
        id: '002',
        restaurante: 'Sushi Zen',
        items: ['Roll California', 'Miso Soup'],
        estado: 'En camino',
        direccion: 'Av. Central 45',
        repartidor: 'Laura Gómez',
        calificacion: 4.5,
        total: 32000.0,
      ),

      Pedido(
        id: '003',
        restaurante: 'Pizza Master',
        items: ['Pizza Pepperoni', 'Coca-Cola'],
        estado: 'Preparando',
        direccion: 'Boulevard 98',
        repartidor: 'Miguel Torres',
        calificacion: 4.7,
        total: 18000.0,
      ),
    ];
  }
}
