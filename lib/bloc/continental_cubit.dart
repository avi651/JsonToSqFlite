import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:contintal/bloc/continental_state.dart';

import '../helpers/custom_error.dart';
import '../repository/continental_repository.dart';

class ContinentalCubit extends Cubit<ContinentalState> {
  final ContinentalRepository continentalRepository;

  ContinentalCubit({required this.continentalRepository})
      : super(const ContinentalState.initial());

  Future<void> fetchContintinentalData() async {
    emit(const ContinetalStateLoading());
    try {
      await continentalRepository.fetchContintalData().then((continentalData) {
        emit(ContinentalStateSuccess(continentalData));
      });
    } on CustomError catch (e) {
      emit(ContinetalStateError(e.toString()));
    }
    log(state.toString());
  }
}
