class Notification {
  final int _id;
  final String? _title;
  final String? _body;

  Notification(this._id, this._title, this._body);

  String? get body => _body;

  String? get title => _title;

  int get id => _id;
}