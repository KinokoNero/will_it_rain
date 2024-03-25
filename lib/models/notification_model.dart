class Notification {
  final int _id;
  final String _title;
  String _body;

  Notification(this._id, this._title, this._body);

  String get body => _body;

  set body(String value) {
    _body = value;
  }

  String get title => _title;

  int get id => _id;
}