part of 'demo_cubit.dart';

abstract class DemoState {}

class DemoStateInit extends DemoState {}

class DemoStateLoading extends DemoState {}

class DemoStateFailed extends DemoState {}

class DemoStateSuccess extends DemoState {
  final List<String> data;
  DemoStateSuccess({required this.data});
}
