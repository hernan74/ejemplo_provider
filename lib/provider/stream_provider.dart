import 'dart:async';

class StreamProvider {
  
  final _numerosStreamController = StreamController<int>.broadcast();

  Function(int) get numerosSink => _numerosStreamController.sink.add;

  Stream<int> get numerosStream => _numerosStreamController.stream;

  void disposeStreams() {
    _numerosStreamController.close();
  }
}
