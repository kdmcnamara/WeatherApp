class Temp {
  var day;
  var min;
  var max;
  var night;
  var eve;
  var morn;

  factory Temp(var day, var min, var max, var night, var eve, var morn) {
    return _cache.putIfAbsent(
        day.toString(), () => Temp._internal(day, min, max, night, eve, morn));
  }

  static final Map<String, Temp> _cache = <String, Temp>{};

  Temp._internal(this.day, this.min, this.max, this.night, this.eve, this.morn);
/*
  Temp(this.day, this.min, this.max, this.night, this.eve, this.morn);

  Temp.fromJson(Map<String, dynamic> parsedJson) {
    day = parsedJson['day'];
    min = parsedJson['min'];
    max = parsedJson['max'];
    night = parsedJson['night'];
    eve = parsedJson['eve'];
    morn = parsedJson['morn'];
  }
*/

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(json['day'], json['min'], json['max'], json['night'],
        json['eve'], json['morn']);
  }

  Map<String, dynamic> toJson() => {
        "day": this.day,
        "min": this.min,
        "max": this.max,
        "night": this.night,
        "eve": this.eve,
        "morn": this.morn,
      };
}
