class GlobalState {
  String? _word;

  static GlobalState instance = new GlobalState._();
  GlobalState._();

  set(String value) {
    _word = value;
  }

  get() => _word;
}
