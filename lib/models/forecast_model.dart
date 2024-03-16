class ForecastDay {
  late final DateTime dateTime;
  late final int dayIconId;
  late final String dayIconPhrase;
  late final int nightIconId;
  late final String nightIconPhrase;
  late final double minTemperature;
  late final double maxTemperature;

  ForecastDay(dynamic dayEntry) {
    try {
      dateTime = DateTime.parse(dayEntry['Date']);
      dayIconId = dayEntry['Day']['Icon'];
      dayIconPhrase = dayEntry['Day']['IconPhrase'];
      nightIconId = dayEntry['Night']['Icon'];
      nightIconPhrase = dayEntry['Night']['IconPhrase'];
      minTemperature = dayEntry['Temperature']['Minimum']['Value'];
      maxTemperature = dayEntry['Temperature']['Maximum']['Value'];
    }
    catch (e) {
      print('Caught an exception: $e');
      rethrow;
    }
  }
}