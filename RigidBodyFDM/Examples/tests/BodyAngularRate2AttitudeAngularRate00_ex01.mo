within AircraftDynamics.RigidBodyFDM.Examples.tests;

model BodyAngularRate2AttitudeAngularRate00_ex01
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant const[3](k = {3.0, 5.0, 1.0})  annotation(
    Placement(visible = true, transformation(origin = {-80, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1[3] annotation(
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  model BodyAngularRate2AttitudeAngularRate00_ex01
    extends Modelica.Icons.Example;
  equation

  end BodyAngularRate2AttitudeAngularRate00_ex01;

  AircraftDynamics.RigidBodyFDM.Components.BodyAngularRate2AttitudeAngularRate00 Body2Global annotation(
    Placement(visible = true, transformation(origin = {-3.55271e-15, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(from_deg1[3].y, Body2Global.busBodyAngularRate.r) annotation(
    Line(points = {{-38, 30}, {-28, 30}, {-28, 20}, {-20, 20}, {-20, 20}}, color = {0, 0, 127}, thickness = 0.5));
  connect(from_deg1[2].y, Body2Global.busBodyAngularRate.q) annotation(
    Line(points = {{-38, 30}, {-28, 30}, {-28, 20}, {-20, 20}, {-20, 20}}, color = {0, 0, 127}, thickness = 0.5));
  connect(from_deg1[1].y, Body2Global.busBodyAngularRate.p) annotation(
    Line(points = {{-38, 30}, {-28, 30}, {-28, 20}, {-20, 20}, {-20, 20}}, color = {0, 0, 127}, thickness = 0.5));
  
  connect(const.y, from_deg1.u) annotation(
    Line(points = {{-68, 30}, {-64, 30}, {-64, 30}, {-62, 30}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.1),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
    
end BodyAngularRate2AttitudeAngularRate00_ex01;
