import 'dart:html';
import 'package:modern_charts/modern_charts.dart';
import 'dart:math';

final random = new Random();

int rand(int min, int max) => random.nextInt(max - min) + min;
var chart;
var table = new DataTable([
  ['Browser', 'Share'],
  ['Goal #1', 25,37],
  ['CPU', 75],
  ['Disk', 40]
]);

var insertRow = true;
Element createContainer() {
  var f = document.getElementById("hi");
  var e = new DivElement()
    ..style.height = '400px'
    ..style.width = '800px'
    ..style.maxWidth = '100%'
    ..style.marginBottom = '50px'
  ..className = "hii";
  document.body.append(e);
  return f;
}

void createGaugeChart() {
  var container = createContainer();
  
  chart = new GaugeChart(container);
  chart.draw(table, {
    'animation': {
      'easing': (double t) {
        t = 4 * t - 2;
        return (t * t * t - t) / 12 + .5;
      },
    },
    'gaugeLabels': {'enabled': true},
    'title': {'text': 'Gauge Chart Demo'},
  });
}