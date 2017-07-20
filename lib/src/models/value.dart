const String monthTagText = "month";
const String valTagText = "value";

class Value {
  String key;
  String month;
  num value;

  Value(this.month, this.value, [this.key]);

  Map toMap(Value val) => {
    monthTagText: val.month,
    valTagText: val.value
  };
}

