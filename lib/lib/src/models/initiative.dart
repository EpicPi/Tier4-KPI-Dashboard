import 'dir.dart';
import 'dart:math';


const String name3TagText = "name";
const String desc3TagText="description";
const String directivesTagText = "directives";

class Initiative{
  String key;
  String name;
  String description;
  List<Dir> directives;

  Initiative(this.name, this.description, this.directives, [this.key]);

  Map toMap(Initiative init) =>
      {
        name3TagText: init.name,
        desc3TagText: init.description,
        directivesTagText: init.directives
      };

}
