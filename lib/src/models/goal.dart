import 'package:kpi_dash/pi_charts/src/datatable.dart';
import 'strategy.dart';

const String nameTagText = "name";
const String stratTagText = "strategies";
const String descTagText = "description";

class Goal {
  String key;
  String name;
  String description;
  List<Strategy> strategies;

  Goal(this.name, this.description, this.strategies, [this.key]) {}

  Map toMap(Goal item) => {
        nameTagText: item.name,
        descTagText: item.description,
        stratTagText: item.strategies
      };

  DataTable get dataTable {
    List<List> data = new List<List>();
    data.add(["name", "value"]);

    for (var strat in strategies) data.add([strat.name, strat.percentage]);

    return new DataTable(data);
  }

  num get percentage {
//    return val;
    var total = 0;
    for (var strat in strategies) {
      total += strat.percentage;
    }
    return total ~/ strategies.length ?? 10;
  }
}
