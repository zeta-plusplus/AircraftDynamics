within AircraftDynamics.Aerodynamics.Components;

model DragObjSimple00
  extends AircraftDynamics.Icons.Icon_DragObject;
  //----- imports -----
  import Modelica.Constants;
  /********************************************************
         Declaration
    ********************************************************/
  //********** Package **********
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  //********** Parameters **********
  parameter Real CDdes = 0.001 "drag coefficient" annotation(
    Dialog(group = "Characteristics"));
  parameter Modelica.SIunits.Area SrefDes = 0.1 "reference area" annotation(
    Dialog(group = "Geometry"));
  //********** Initialization Parameters **********
  //--- fluid_amb, port_amb ---
  parameter Modelica.SIunits.MassFlowRate m_flowAmb_init(displayUnit = "kg/s") = 0.0 "" annotation(
    Dialog(tab = "Initialization", group = "Fluid states"));
  parameter Modelica.SIunits.Pressure pAmb_init(displayUnit = "Pa") = 101.3 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "Fluid states"));
  parameter Modelica.SIunits.Temperature Tamb_init(displayUnit = "K") = 288.15 "" annotation(
    Dialog(tab = "Initialization", group = "Fluid states"));
  parameter Modelica.SIunits.SpecificEnthalpy hAmb_init(displayUnit = "J/kg") = 1.004 * 1000 * 288.15 "" annotation(
    Dialog(tab = "Initialization", group = "Fluid states"));
  //********** variables **********
  //---calculated parameters---
  Real CD(start = CDdes);
  Modelica.SIunits.Area Sref(start = SrefDes);
  //--- variables ---
  Modelica.SIunits.Force Df(start = 1.0);
  Modelica.SIunits.Force Fx;
  Modelica.SIunits.Force Fz;
  Modelica.SIunits.Velocity Vflow(start = 100);
  Real Mn(start = 0.5);
  Modelica.SIunits.Angle alpha;
  //--- objects ---
  Medium.BaseProperties fluid_amb(p.start = pAmb_init, T.start = Tamb_init, state.p.start = pAmb_init, state.T.start = Tamb_init, h.start = hAmb_init) "flow station of amb";
  //********** Interfaces **********
  Modelica.Fluid.Interfaces.FluidPort_a port_amb(redeclare package Medium = Medium, m_flow.start = m_flowAmb_init, h_outflow.start = hAmb_init) "" annotation(
    Placement(visible = true, transformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_Df annotation(
    Placement(visible = true, transformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus busFltStates1 annotation(
    Placement(visible = true, transformation(origin = {-90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_Fz annotation(
    Placement(visible = true, transformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput y_Fx annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
algorithm
//********** assignment, design parameter to variables (calculated parameters) **********
  CD := CDdes;
  Sref := SrefDes;
equation
  connect(alpha, busFltStates1.alpha) annotation(
    Line);
  connect(Mn, busFltStates1.Mn) annotation(
    Line);
//********** Connections, interface <-> internal variables **********
//-- port_amb --
  fluid_amb.p = port_amb.p;
  port_amb.h_outflow = fluid_amb.h;
  port_amb.Xi_outflow= fluid_amb.Xi;
  fluid_amb.h = actualStream(port_amb.h_outflow);
  fluid_amb.Xi = actualStream(port_amb.Xi_outflow);
  port_amb.m_flow = 1.0;
//-- else --
  y_Df = Df;
  y_Fx= Fx;
  y_Fz= Fz;
//********** Eqns describing physics **********
  Mn = Vflow / Medium.velocityOfSound(fluid_amb.state);
  Df = CD * Sref * 1 / 2 * fluid_amb.d * (sign(Vflow) * abs(Vflow) ^ 2.0);
  Fx= Df*cos(alpha);
  Fz= Df*sin(alpha);
  
  
  annotation(
    defaultComponentName="dragObj",
    Documentation(
    info = "<html>
<a href=\"modelica://AircraftDynamics/docs/Aerodynamics/Components/DragObjSimple00.html\"> Document html page</a>
<p> &emsp; </p>
<h4>example/demo models</h4>
  <ul>
  <li><a href=\"modelica://AircraftDynamics/Aerodynamics/Example/test/DragObjSimple00_test01\"> Aerodynamics/Example/test/DragObjSimple00_test01 </a> </li>
  </ul>
  
<h4>classes which this component call (those of MSL are not listed) </h4>
<p> -> none </p>
</html>"
    ),
    Icon(
      graphics = {Text(origin = {-6, -46}, extent = {{-94, 6}, {106, -4}}, textString = "%name"), Text(origin = {0, 53}, extent = {{-10, 5}, {10, -5}}, textString = "Fz"), Text(origin = {62, 0}, extent = {{38, -4}, {20, 6}}, textString = "Fx"), Text(origin = {62, 40}, extent = {{38, -4}, {20, 6}}, textString = "D"), Text(origin = {-90, 45}, extent = {{-10, 5}, {10, -5}}, textString = "amb")}, coordinateSystem(extent = {{-100, -60}, {100, 60}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}})),
    __OpenModelica_commandLineOptions = "");
  
  
end DragObjSimple00;
