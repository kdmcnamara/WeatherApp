class Weather {
  var id;
  var main;
  var description;
  var icon;

/*
  Weather(this.id, this.main, this.description, this.icon);
*/

  factory Weather(var id, var main, var description, var icon) {
    return _cache.putIfAbsent(
        id.toString(),
        () => Weather._internal(
              id,
              main,
              description,
              icon,
            ));
  }
/*
  Weather.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    main = parsedJson['main'];
    description = parsedJson['description'];
    icon = parsedJson['icon'];
  }
*/

  static final Map<String, Weather> _cache = <String, Weather>{};

  Weather._internal(this.id, this.main, this.description, this.icon);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(json['id'], json['main'], json['description'], json['icon']);
  }

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "main": this.main,
        "description": this.description,
        "icon": this.icon,
      };
}
