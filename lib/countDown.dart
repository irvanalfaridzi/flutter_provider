import 'dart:async';

enum StartTime { to_0, to_9 }

class CountDownBloc {
  int _to = 9;

  StreamController<StartTime> _eventController =
      StreamController<StartTime>.broadcast();
  StreamSink<StartTime> get eventSink => _eventController.sink;

  StreamController<int> _stateController = StreamController<int>.broadcast();
  StreamSink<int> get _stateSink => _stateController.sink;
  Stream<int> get stateStream => _stateController.stream;

  void _mapEventToState(StartTime startTime) {
    if (startTime == StartTime.to_0) {
      _to = 0;
    } else if (startTime == StartTime.to_9) {
      _to = 9;
    }
    _stateSink.add(_to);
  }

  CountDownBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
