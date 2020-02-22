class Tax {
  static const String titleKey = 'title';
  static const String valueKey = 'value';
  static const String currencyKey = 'currency';

  String _title;
  int _value;
  String _currency;

  Tax(this._title, this._value, this._currency);

  String get title => _title;

  int get value => _value;

  String get currency => _currency;

  Map<String, dynamic> toMap() {
    return {
      titleKey: _title,
      valueKey: _value,
      currencyKey: _currency,
    };
  }
}
