import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pato_delivery_final/bloc/ranking/ranking_event.dart';
import 'package:pato_delivery_final/bloc/ranking/ranking_state.dart';
import 'package:pato_delivery_final/repositories/ranking_repository.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  RankingBloc(this._rankingRepository) : super(const RankingInicial()) {
    on<CargarRanking>(_onCargarRanking);
  }

  final RankingRepository _rankingRepository;

  Future<void> _onCargarRanking(
    CargarRanking event,
    Emitter<RankingState> emit,
  ) async {
    emit(const RankingCargando());

    try {
      final resumen = await _rankingRepository.obtenerRanking();
      emit(RankingCargado(resumen));
    } catch (_) {
      emit(const RankingError('No fue posible cargar el ranking.'));
    }
  }
}
