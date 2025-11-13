import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 🔹 BLoCs
import 'package:pato_delivery_final/bloc/auth/auth_bloc.dart';
import 'package:pato_delivery_final/bloc/auth/auth_event.dart';
import 'package:pato_delivery_final/bloc/pedidos/pedidos_bloc.dart';
import 'package:pato_delivery_final/bloc/pedidos/pedidos_event.dart';
import 'package:pato_delivery_final/bloc/ranking/ranking_bloc.dart';
import 'package:pato_delivery_final/bloc/ranking/ranking_event.dart';

// 🔹 Repositorios
import 'package:pato_delivery_final/repositories/pedidos_repository.dart';
import 'package:pato_delivery_final/repositories/ranking_repository.dart';

// 🔹 Pantallas
import 'screens/auth/auth_gate.dart';
import 'home_screen.dart';
import 'pedidos_screen.dart';
import 'perfil_screen.dart';
import 'ranking_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // 🔥 Asegura la inicialización de Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => const PedidosRepository()),
        RepositoryProvider(create: (_) => const RankingRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          // 🔸 Bloc de Autenticación
          BlocProvider(
            create: (context) =>
            AuthBloc(FirebaseAuth.instance)..add(const AuthSubscriptionRequested()),
          ),

          // 🔸 Bloc de Pedidos
          BlocProvider(
            create: (context) =>
            PedidosBloc(context.read<PedidosRepository>())..add(CargarPedidos()),
          ),

          // 🔸 Bloc de Ranking
          BlocProvider(
            create: (context) =>
            RankingBloc(context.read<RankingRepository>())..add(const CargarRanking()),
          ),
        ],
        child: MaterialApp(
          title: 'Pato Delivery',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.amber,
              brightness: Brightness.light,
              primary: Colors.amber,
              secondary: Colors.amber.shade700,
              surface: Colors.grey.shade900,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.amber,
              brightness: Brightness.dark,
              primary: Colors.amber,
              secondary: Colors.amber.shade700,
              surface: Colors.grey.shade900,
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              onSurface: Colors.white,
            ),
          ),
          home: const AuthGate(),
        ),
      ),
    );
  }
}

// 🔹 Pantalla principal con barra inferior
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = const [
      HomeScreen(),
      PedidosScreen(),
      RankingPage(),
      PerfilScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Ranking'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
