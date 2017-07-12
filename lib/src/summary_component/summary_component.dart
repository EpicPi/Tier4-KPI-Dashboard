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

  @ViewChild('canvas1')
  ElementRef div;
  DivElement divElement;

  var goals;
  var chart;
  bool isOneEnabled = true;
  CanvasRenderingContext2D context;
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
    canvasElement.onClick.listen(printOnClick);
    divElement = div.nativeElement;
  }

  @override
  ngAfterViewInit() {
//    goals =
    chart = createGaugeChart(canvasElement,table);
  }

  num getIndex(MouseEvent e)
  {
    var rect = chart.context.canvas.getBoundingClientRect();
    var x = e.client.x - rect.left;
    var y = e.client.y - rect.top;
    return chart.getEntityGroupIndexGeneral(x, y);
  }
  void printOnClick(MouseEvent e)
  {
    //only one display open at a a time
    if(divElement.childNodes.length>1)
      divElement.childNodes.last.remove();

    var index = getIndex(e);

    var canvas2 = new CanvasElement();
    divElement.append(canvas2);

    createGaugeChart(canvas2, table);

  }

}