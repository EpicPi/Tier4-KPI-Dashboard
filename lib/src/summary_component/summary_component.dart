import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:kpi_dash/pi_charts/pi_charts.dart';

@Component(
  selector: 'graph-example',
  styleUrls: const ['summary_component.css'],
  templateUrl: 'summary_component.html',
)
class SummaryComponent implements AfterContentInit, AfterViewInit {
  @ViewChild('canvasMain')
  ElementRef canvas;
  CanvasElement canvasElement;

  var table = new DataTable([
    ['Browser', 'Share'],
    ['Goal1', 34],
    ['Goal2',67],
    ['Goal3', 97]
  ]);

  var insertRow = true;


  @override
  ngAfterContentInit() {
    canvasElement = canvas.nativeElement;
  }

  @override
  ngAfterViewInit() {
    createGaugeChart(canvasElement,table);

  }
}