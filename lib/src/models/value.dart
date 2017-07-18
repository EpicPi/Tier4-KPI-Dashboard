const String monthTagText = "month";
const String yTagText = "year";
const String valTagText = "value";

class Value {
  String key;
  String month;
  num year;
  num value;

  Value(this.month, this.year, this.value, [this.key]);

  Map toMap(Value val) =>
      {monthTagText: val.month, yTagText: val.year, valTagText: val.value};
}
