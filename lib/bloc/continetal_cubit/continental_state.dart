import 'package:contintal/models/continental_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'continental_state.freezed.dart';

@freezed
class ContinentalState with _$ContinentalState {
  const factory ContinentalState.initial() = ContinetalStateInitial;
  const factory ContinentalState.loading() = ContinetalStateLoading;
  const factory ContinentalState.success(ContinentalModel contintalModel) =
      ContinentalStateSuccess;
  const factory ContinentalState.error(String message) = ContinetalStateError;
}
