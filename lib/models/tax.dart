class Tax {
  static const String nameKey = 'name';
  static const String valueKey = 'value';

  String _name;
  String _value;

  Tax(this._name, this._value);

  String get name => _name;

  String get value => _value;

  Map<String, dynamic> toMap() {
    return {
      nameKey: _name,
      valueKey: _value,
    };
  }
}
