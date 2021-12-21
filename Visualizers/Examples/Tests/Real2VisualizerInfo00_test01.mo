within AircraftDynamics.Visualizers.Examples.Tests;

model Real2VisualizerInfo00_test01
  extends Modelica.Icons.Example;
  AircraftDynamics.Interfaces.Real2VisualizerInfo00 Real2VisInfo(use_u_alpha = false,use_u_alt = false, use_u_beta = false, use_u_phi = true, use_u_psi = true, use_u_theta = true, use_u_xEast = false, use_u_xNorth = false)  annotation(
    Placement(visible = true, transformation(origin = {0.0724018, 20.2172}, extent = {{-6.4724, -19.4172}, {4.8543, 19.4172}}, rotation = 0)));
  AircraftDynamics.Visualizers.AnimRigidBodyAircraftAttitude00 AnimAircraft annotation(
    Placement(visible = true, transformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_phi(duration = 10, height = 30, offset = 0, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-80, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_theta(duration = 10, height = 20, offset = 0, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_psi(duration = 10, height = 180, offset = 0, startTime = 50) annotation(
    Placement(visible = true, transformation(origin = {-80, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-40, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg2 annotation(
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg3 annotation(
    Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Real2VisInfo.u_phi, from_deg1.y) annotation(
    Line(points = {{-5, 23}, {-12, 23}, {-12, 30}, {-28, 30}}, color = {0, 0, 127}));
  connect(from_deg3.y, Real2VisInfo.u_psi) annotation(
    Line(points = {{-28, -30}, {-12, -30}, {-12, 11}, {-5, 11}}, color = {0, 0, 127}));
  connect(from_deg2.y, Real2VisInfo.u_theta) annotation(
    Line(points = {{-28, 0}, {-16, 0}, {-16, 17}, {-5, 17}}, color = {0, 0, 127}));
  connect(Real2VisInfo.VisInfoOut, AnimAircraft.VisInfoIn) annotation(
    Line(points = {{3, 20}, {10, 20}}, color = {95, 95, 95}));
  connect(ramp_psi.y, from_deg3.u) annotation(
    Line(points = {{-68, -30}, {-54, -30}, {-54, -30}, {-52, -30}}, color = {0, 0, 127}));
  connect(ramp_theta.y, from_deg2.u) annotation(
    Line(points = {{-68, 0}, {-52, 0}, {-52, 0}, {-52, 0}}, color = {0, 0, 127}));
  connect(ramp_phi.y, from_deg1.u) annotation(
    Line(points = {{-68, 30}, {-54, 30}, {-54, 30}, {-52, 30}}, color = {0, 0, 127}));
annotation(
    experiment(StartTime = 0, StopTime = 70, Tolerance = 1e-6, Interval = 0.002));end Real2VisualizerInfo00_test01;
