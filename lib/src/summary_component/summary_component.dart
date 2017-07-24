import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/pi_charts/pi_charts.dart';
import 'package:kpi_dash/src/models/year.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';

@Component(
    selector: 'my-summary',
    styleUrls: const ['summary_component.css'],
    templateUrl: 'summary_component.html',
    directives: const [materialDirectives,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES],
    providers: const [])
class SummaryComponent implements AfterContentInit, DoCheck{
  @Input()
  Year year;
  int yr = 2016;

  @ViewChild('canvasMain')
  ElementRef canvas;
  DivElement canvasElement;

  @ViewChild('canvas1')
  ElementRef div;
  DivElement divElement;

  List<List> data;
  final FirebaseService fbService;
  SummaryComponent(this.fbService);

  var goals;
  var chart;

  @override
  ngAfterContentInit() {
    canvasElement = canvas.nativeElement;
    canvasElement.onClick.listen(createSubGraph);
    divElement = div.nativeElement;
  }

  void createChart()
  {
    yr = year.year;
    List<List> data = new List<List>();
    data.add(["name", "value"]);

    for (var goal in year.goals) data.add([goal.name, goal.percentage]);

    var canvas2 = new CanvasElement();
    canvas2
//      ..style.width = "400px"
      ..style.height = "400px";

    canvasElement.append(canvas2);

    chart = createGaugeChart(canvas2, new DataTable(data));
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
    if (divElement.childNodes.length > 0) divElement.childNodes.last.remove();

    var canvas2 = new CanvasElement();
    divElement.hidden = false;
    divElement.append(canvas2);
    createGaugeChart(canvas2, year.goals[index].dataTable);

  }


  @override
  ngDoCheck() {
    if(yr!=year.year)
    {
      if(canvasElement == null)
      canvasElement = canvas.nativeElement;
      if(divElement == null)
      divElement = div.nativeElement;
      while (canvasElement.childNodes.length > 0) canvasElement.childNodes.last.remove();
      while (divElement.childNodes.length>0 )divElement.childNodes.last.remove();
      createChart();
      divElement.hidden = true;
    }

  }

}
