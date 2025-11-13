import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pato_delivery_final/bloc/pedidos/pedidos_bloc.dart';
import 'package:pato_delivery_final/bloc/pedidos/pedidos_state.dart';
import 'package:pato_delivery_final/models/pedido_model.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<PedidosBloc, PedidosState>(
        builder: (context, state) {
          if (state is PedidosCargando || state is PedidosInicial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PedidosCargados) {
            if (state.pedidos.isEmpty) {
              return const Center(
                child: Text(
                  'Todavía no registras pedidos.',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.pedidos.length,
              itemBuilder: (context, index) {
                final pedido = state.pedidos[index];
                return _buildPedidoCard(pedido);
              },
            );
          } else if (state is PedidosError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.mensaje,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildPedidoCard(Pedido pedido) {
    return Card(
      color: Colors.black87,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pedido.restaurante,
                style: const TextStyle(
                    color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 4),
            Text('Estado: ${pedido.estado}', style: const TextStyle(color: Colors.white70)),
            Text('Dirección: ${pedido.direccion}', style: const TextStyle(color: Colors.white70)),
            Text('Repartidor: ${pedido.repartidor}', style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 6),
            Text('Total: \$${pedido.total.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
