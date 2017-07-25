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

  double width;

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

  var options1={
    // String - The background color of the gauges.
    'gaugeBackgroundColor': '#dbdbdb',

    // Map - An object that controls the gauge labels.
    'gaugeLabels': {
      // bool - Whether to show the labels.
      'enabled': true,

      // Map - An object that controls the styling of the gauge labels.
      'style': {
        'color': '#212121',
        'fontSize': 17,
        'fontStyle': 'normal'
      }
    }
  };
  var options2={
    // String - The background color of the gauges.
    'gaugeBackgroundColor': '#dbdbdb',

    // Map - An object that controls the gauge labels.
    'gaugeLabels': {
      // bool - Whether to show the labels.
      'enabled': true,

      // Map - An object that controls the styling of the gauge labels.
      'style': {
        'color': '#212121',
        'fontSize': 13,
        'fontStyle': 'normal'
      }
    }
  };
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
    canvas2.style..width = "80%";
   var text = new HeadingElement.h1();
   text.innerHtml=year.year.toString();
   canvasElement.append(text);
    canvasElement.append(canvas2);

    chart = createGaugeChart(canvas2, new DataTable(data), options1);
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
    while (divElement.childNodes.length > 0) divElement.childNodes.last.remove();

    var canvas2 = new CanvasElement();
    canvas2.style
      ..width = "80%";
//    ..height="250px%";
    divElement.hidden = false;
    var text = new HeadingElement.h2();
    text
      ..innerHtml = year.goals[index].name;
    divElement.append(text);
    divElement.append(canvas2);
    createGaugeChart(canvas2, year.goals[index].dataTable, options2);

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
