import 'package:flutter_bloc/flutter_bloc.dart';

part "demo_state.dart";

class DemoCubit extends Cubit<DemoState> {
  DemoCubit() : super(DemoStateInit());
  final data = ['girl', "manchi", "30b", "manny"];

  void success() async {
    emit(DemoStateLoading());
    await Future.delayed(
        const Duration(seconds: 3), () => emit(DemoStateSuccess(data: data)));
  }

  void failed() async {
    emit(DemoStateLoading());
    await Future.delayed(
        const Duration(seconds: 3), () => emit(DemoStateFailed()));
  }
}
