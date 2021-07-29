within AircraftDynamics.RigidBodyFDM.Examples.tests;

model AttitudeVelocity2Position00_ex01
  extends Modelica.Icons.Example;
  AircraftDynamics.RigidBodyFDM.Components.AttitudeVelocity2Position00 Body2Global annotation(
    Placement(visible = true, transformation(origin = {-3.55271e-15, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const[3](k = {3.0, 5.0, 0.0})  annotation(
    Placement(visible = true, transformation(origin = {-80, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1[3] annotation(
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1[3](k = {100.0, 5.0, 2.0}) annotation(
    Placement(visible = true, transformation(origin = {-80, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  model BodyAngularRate2AttitudeAngularRate00_ex01
    extends Modelica.Icons.Example;
  equation

  end BodyAngularRate2AttitudeAngularRate00_ex01;
equation
  connect(from_deg1[1].y, Body2Global.busAttitude.phi) annotation(
    Line(points = {{-38, 30}, {-30, 30}, {-30, 12}, {-20, 12}}, color = {0, 0, 127}, thickness = 0.5));
  connect(from_deg1[2].y, Body2Global.busAttitude.theta) annotation(
    Line(points = {{-38, 30}, {-30, 30}, {-30, 12}, {-20, 12}}, color = {0, 0, 127}, thickness = 0.5));
  connect(from_deg1[3].y, Body2Global.busAttitude.psi) annotation(
    Line(points = {{-38, 30}, {-30, 30}, {-30, 12}, {-20, 12}}, color = {0, 0, 127}, thickness = 0.5));
  connect(const1[1].y, Body2Global.busVelocityAlongBody.u) annotation(
    Line(points = {{-69, -20}, {-38, -20}, {-38, -12}, {-20, -12}}, color = {0, 0, 127}, thickness = 0.5));
  connect(const1[2].y, Body2Global.busVelocityAlongBody.v) annotation(
    Line(points = {{-69, -20}, {-38, -20}, {-38, -12}, {-20, -12}}, color = {0, 0, 127}));
  connect(const1[3].y, Body2Global.busVelocityAlongBody.w) annotation(
    Line(points = {{-69, -20}, {-38, -20}, {-38, -12}, {-20, -12}}, color = {0, 0, 127}));
  connect(const.y, from_deg1.u) annotation(
    Line(points = {{-68, 30}, {-64, 30}, {-64, 30}, {-62, 30}}, color = {0, 0, 127}, thickness = 0.5));
annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.1),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));

end AttitudeVelocity2Position00_ex01;
