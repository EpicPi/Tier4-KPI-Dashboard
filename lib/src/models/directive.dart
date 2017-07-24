import 'value.dart';
import 'dart:core';

const String name4TagText = "name";
const String desc4TagText = "description";
const String maxValTagText = "max value";
const String valuesTagText = "values";

class Dir {
  String key;
  String name;
  String description;
  num maxValue;
  List<Value> values;

  Dir(this.name, this.description, this.maxValue, this.values, [this.key]);

  Map toMap(Dir dir) => {
    name4TagText: dir.name,
    desc4TagText: dir.description,
    maxValTagText: dir.maxValue,
    valuesTagText: dir.values
  };

  int get percentage
  {
    num total = 0;
    for(var val in values)
    {
      total +=val.value;
    }
    return values.length>0?(total/maxValue * 100).toInt() : 1;
  }
}


