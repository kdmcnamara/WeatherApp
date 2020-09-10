class FeelsLike {
  var day;
  var night;
  var eve;
  var morn;
  factory FeelsLike(var day, var night, var eve, var morn) {
    return _cache.putIfAbsent(
        day.toString(), () => FeelsLike._internal(day, night, eve, morn));
  }

  static final Map<String, FeelsLike> _cache = <String, FeelsLike>{};

  FeelsLike._internal(this.day, this.night, this.eve, this.morn);
  /*
  FeelsLike(this.day, this.night, this.eve, this.morn);

  
  FeelsLike.fromJson(Map<String, dynamic> parsedJson) {
    day = parsedJson['day'];
    night = parsedJson['night'];
    eve = parsedJson['eve'];
    morn = parsedJson['morn'];
  }
  */

  factory FeelsLike.fromJson(Map<String, dynamic> json) {
    return FeelsLike(json['day'], json['night'], json['eve'], json['morn']);
  }

  Map<String, dynamic> toJson() => {
        "day": this.day,
        "night": this.night,
        "eve": this.eve,
        "morn": this.morn,
      };
}
