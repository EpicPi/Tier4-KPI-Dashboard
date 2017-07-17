import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:kpi_dash/pi_charts/pi_charts.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';

@Component(
    selector: 'my-summary',
    styleUrls: const ['summary_component.css'],
    templateUrl: 'summary_component.html',
    providers: const [])
class SummaryComponent implements AfterContentInit, AfterViewInit {
  @ViewChild('canvasMain')
  ElementRef canvas;
  CanvasElement canvasElement;

  @ViewChild('canvas1')
  ElementRef div;
  DivElement divElement;

  final FirebaseService fbService;
  SummaryComponent(this.fbService);

  var goals;
  var chart;
  bool isOneEnabled = true;
  CanvasRenderingContext2D context;

  @override
  ngAfterContentInit() {
    canvasElement = canvas.nativeElement;
    canvasElement.onClick.listen(createSubGraph);
    divElement = div.nativeElement;
  }

  @override
  ngAfterViewInit() {
    List<List> data = new List<List>();
    data.add(["name", "value"]);

    for (var goal in fbService.goals) data.add([goal.name, goal.percentage]);

    chart = createGaugeChart(canvasElement, new DataTable(data));
  }

  num getIndex(MouseEvent e) {
    var rect = chart.context.canvas.getBoundingClientRect();
    var x = e.client.x - rect.left;
    var y = e.client.y - rect.top;
    return chart.getEntityGroupIndexGeneral(x, y);
  }

  // TODO: need to make this create multiple rows if necessary
  void createSubGraph(MouseEvent e) {
    //if you didn't click on a graph, do nothing
    var index = getIndex(e);
    if (index < 0) return;

    //only one display open at a a time
    if (divElement.childNodes.length > 1) divElement.childNodes.last.remove();

    var canvas2 = new CanvasElement();
    divElement.append(canvas2);

    createGaugeChart(canvas2, fbService.goals[index].dataTable);
  }
}
