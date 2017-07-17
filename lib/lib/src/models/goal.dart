import 'package:angular2/core.dart';
import 'strategy.dart';
import 'dart:math';

const String nameTagText = "name";
const String stratTagText = "strategies";
const String descTagText = "description";


class Goal {
  String key;
  String name;
  String description;
  List<Strategy> strategies;

  Goal(this.name, this.description, this.strategies, [this.key]) {
  }


//  Goal.fromMap(Map map) :
//        this(map['name'], map['percent']);

  Map toMap(Goal item) =>
      {
        nameTagText: item.name,
        descTagText: item.description,
        stratTagText: item.strategies
      };
}


