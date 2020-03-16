class Tax {
  static const String ownerIdKey = 'owner';
  static const String carInfoKey = 'carInfo';
  static const String titleKey = 'title';
  static const String valueKey = 'value';
  static const String currencyKey = 'currency';

  String _ownerId;
  String _carInfo;
  String _title;
  String _value;
  String _currency;

  Tax(this._ownerId, this._carInfo, this._title, this._value, this._currency);

  Tax.fromMap(Map<String, dynamic> map) {
    _ownerId = map[ownerIdKey];
    _carInfo = map[carInfoKey];
    _title = map[titleKey];
    _value = map[valueKey];
    _currency = map[currencyKey];
  }

  String get ownerId => _ownerId;

  String get carInfo => _carInfo;

  String get title => _title;

  String get value => _value;

  String get currency => _currency;

  Map<String, dynamic> toMap() {
    return {
      ownerIdKey: _ownerId,
      carInfoKey: _carInfo,
      titleKey: _title,
      valueKey: _value,
      currencyKey: _currency,
    };
  }
}
