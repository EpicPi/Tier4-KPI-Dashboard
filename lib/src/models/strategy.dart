import 'initiative.dart';

const String name2TagText = "name";
const String desc2TagText = "description";
const String initiativesTagText = "initiatives";

class Strategy {
  String key;
  String name;
  String description;
  List<Initiative> initiatives;

  Strategy(this.name, this.description, this.initiatives, [this.key]);

  Map toMap(Strategy strat) => {
        name2TagText: strat.name,
        desc2TagText: strat.description,
        initiativesTagText: strat.initiatives
      };

  num get percentage {
    var total = 0;
    for (var init in initiatives) {
      total += init.percentage;
    }
    return total ~/ initiatives.length ?? 0;
  }
}
