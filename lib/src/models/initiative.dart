import 'directive.dart';

const String name3TagText = "name";
const String desc3TagText = "description";
const String directivesTagText = "directives";

class Initiative {
  String key;
  String name;
  String description;
  List<Dir> directives;

  Initiative(this.name, this.description, this.directives, [this.key]);

  Map toMap(Initiative init) => {
    name3TagText: init.name,
    desc3TagText: init.description,
    directivesTagText: init.directives
  };

  double get percentage {
    double total = 0.0;
    for (var dir in directives) {

      total += dir.percentage;
    }

    return directives.length>0? (total / (directives.length.toDouble())).toDouble() : 1;
  }
}

