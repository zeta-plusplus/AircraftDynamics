within AircraftDynamics.Visualizers.Examples.Samples;

model Real2VisualizerInfo00_ex01
  extends Modelica.Icons.Example;
  AircraftDynamics.Interfaces.Real2VisualizerInfo00 Real2VisInfo(use_u_alpha = true, use_u_alt = false, use_u_beta = true, use_u_phi = true, use_u_psi = true, use_u_theta = true, use_u_xEast = false, use_u_xNorth = false) annotation(
    Placement(visible = true, transformation(origin = {40.1945, 19.8238}, extent = {{-6.60354, -19.8106}, {4.95266, 19.8106}}, rotation = 0)));
  AircraftDynamics.Visualizers.AnimRigidBodyAircraftAttitude00 AnimAircraft annotation(
    Placement(visible = true, transformation(origin = {60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_phi(duration = 5, height = 30, offset = 0, startTime = 5) annotation(
    Placement(visible = true, transformation(origin = {-80, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_theta(duration = 5, height = 20, offset = 0, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_psi(duration = 5, height = 170, offset = 0, startTime = 15) annotation(
    Placement(visible = true, transformation(origin = {-80, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-40, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg2 annotation(
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg3 annotation(
    Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg annotation(
    Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_alpha(duration = 5, height = 5, offset = 0, startTime = 20) annotation(
    Placement(visible = true, transformation(origin = {-80, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg4 annotation(
    Placement(visible = true, transformation(origin = {-40, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_beta(duration = 5, height = 5, offset = 0, startTime = 25) annotation(
    Placement(visible = true, transformation(origin = {-80, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Real2VisInfo.u_phi, from_deg1.y) annotation(
    Line(points = {{35, 22}, {-12, 22}, {-12, 30}, {-28, 30}}, color = {0, 0, 127}));
  connect(from_deg3.y, Real2VisInfo.u_psi) annotation(
    Line(points = {{-28, -30}, {-12, -30}, {-12, 12}, {35, 12}}, color = {0, 0, 127}));
  connect(from_deg2.y, Real2VisInfo.u_theta) annotation(
    Line(points = {{-28, 0}, {-16, 0}, {-16, 17}, {35, 17}}, color = {0, 0, 127}));
  connect(Real2VisInfo.VisInfoOut, AnimAircraft.VisInfoIn) annotation(
    Line(points = {{43, 20}, {50, 20}}, color = {95, 95, 95}));
  connect(ramp_psi.y, from_deg3.u) annotation(
    Line(points = {{-68, -30}, {-54, -30}, {-54, -30}, {-52, -30}}, color = {0, 0, 127}));
  connect(ramp_theta.y, from_deg2.u) annotation(
    Line(points = {{-68, 0}, {-52, 0}, {-52, 0}, {-52, 0}}, color = {0, 0, 127}));
  connect(ramp_phi.y, from_deg1.u) annotation(
    Line(points = {{-68, 30}, {-54, 30}, {-54, 30}, {-52, 30}}, color = {0, 0, 127}));
  connect(ramp_alpha.y, from_deg.u) annotation(
    Line(points = {{-68, -60}, {-52, -60}}, color = {0, 0, 127}));
  connect(from_deg.y, Real2VisInfo.u_alpha) annotation(
    Line(points = {{-28, -60}, {-8, -60}, {-8, 7}, {35, 7}}, color = {0, 0, 127}));
  connect(ramp_beta.y, from_deg4.u) annotation(
    Line(points = {{-68, -90}, {-52, -90}}, color = {0, 0, 127}));
  connect(from_deg4.y, Real2VisInfo.u_beta) annotation(
    Line(points = {{-28, -90}, {-4, -90}, {-4, 2}, {35, 2}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.001));
end Real2VisualizerInfo00_ex01;
