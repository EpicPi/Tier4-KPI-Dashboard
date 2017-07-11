import 'dart:html';
import 'package:angular2/angular2.dart';
import 'dart:math';
import 'package:kpi_dash/pi_charts/pi_charts.dart';

final random = new Random();

@Component(
  selector: 'graph-example',
  styleUrls: const ['summary_component.css'],
  templateUrl: 'summary_component.html',
)
class GraphExampleComponent implements AfterContentInit, AfterViewInit {
  @ViewChild('canvasMain')
  ElementRef canvas;
  CanvasElement canvasElement;

  int rand(int min, int max) => random.nextInt(max - min) + min;
  var chart;
  var table = new DataTable([
    ['Browser', 'Share'],
    ['Memory', 25],
  ]);

  var insertRow = true;


  void createGaugeChart(CanvasElement canvasElement, DataTable table) {
    chart = new GaugeChart(canvasElement)..draw(table, {
      'animation': {'easing': (t) => t}
    });
  }
  @override
  ngAfterContentInit() {
    canvasElement = canvas.nativeElement;
  }

  @override
  ngAfterViewInit() {
    createGaugeChart(canvasElement,table);
  }
}