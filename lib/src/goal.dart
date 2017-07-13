import 'package:kpi_dash/pi_charts/pi_charts.dart';
import 'package:kpi_dash/src/strategy.dart';

class Goal {
  String name;
  String detail;
  var strategies;
  num val;
  Goal(this.name, this.detail, [this.val]) {
    strategies = new List<Strategy>();
  }
  num get percentage {
//    return val;
    var total = 0;
    for (var strat in strategies) {
      total += strat.percentage;
    }
    return total ~/ strategies.length ?? 0;
  }

  DataTable get dataTable {
    List<List> data = new List<List>();
    data.add(["name","value"]);

    for(num i=0; i<strategies.length; i++)
      data.add([strategies[i].name,strategies[i].percentage]);

    return new DataTable(data);
  }
}
