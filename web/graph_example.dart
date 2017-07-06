import 'dart:html';
import 'package:modern_charts/modern_charts.dart';
import 'dart:math';

final random = new Random();

int rand(int min, int max) => random.nextInt(max - min) + min;

void main() {
  createGaugeChart();
}

Element createContainer() {
  var e = new DivElement()
    ..style.height = '400px'
    ..style.width = '800px'
    ..style.maxWidth = '100%'
    ..style.marginBottom = '50px';
  document.body.append(e);
  return e;
}

void createGaugeChart() {
  var changeDataButton = new ButtonElement()..text = 'Change data';
  document.body.append(changeDataButton);

  var insertRemoveRowButton = new ButtonElement()
    ..text = 'Insert/remove data row';
  document.body.append(insertRemoveRowButton);

  var container = createContainer();
  var table = new DataTable([
    ['Browser', 'Share'],
    ['Memory', 25],
    ['CPU', 75],
    ['Disk', 40]
  ]);
  var chart = new GaugeChart(container);
  chart.draw(table, {
    'animation': {
      'easing': (double t) {
        t = 4 * t - 2;
        return (t * t * t - t) / 12 + .5;
      },
      'onEnd': () {
        changeDataButton.disabled = false;
        insertRemoveRowButton.disabled = false;
      }
    },
    'gaugeLabels': {'enabled': false},
    'title': {'text': 'Gauge Chart Demo'},
  });

  void disableAllButtons() {
    changeDataButton.disabled = true;
    insertRemoveRowButton.disabled = true;
  }

  changeDataButton.onClick.listen((_) {
    disableAllButtons();
    for (var row in table.rows) {
      for (var i = 1; i < table.columns.length; i++) {
        row[i] = rand(0, 101);
      }
    }
    chart.update();
  });

  var insertRow = true;
  insertRemoveRowButton.onClick.listen((_) {
    insertRemoveRowButton.disabled = true;
    if (insertRow) {
      var values = ['New', rand(0, 101)];
      table.rows.insert(1, values);
    } else {
      table.rows.removeAt(1);
    }
    insertRow = !insertRow;
    chart.update();
  });
}