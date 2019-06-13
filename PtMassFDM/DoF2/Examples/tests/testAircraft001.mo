within AircraftDynamics.PtMassFDM.DoF2.Examples.tests;

model testAircraft001
  extends Modelica.Icons.Example;
  package atmAir = Modelica.Media.Air.DryAirNasa;
  //redeclare package Medium = atmAir
  //----------
  AircraftDynamics.PtMassFDM.DoF2.Components.AircraftMassCenter aircraftMassCenter1(massBase = 1000) annotation(
    Placement(visible = true, transformation(origin = {38, 12}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 10 * 1000)  annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wingSimple001(redeclare package Medium = atmAir) annotation(
    Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(wingSimple001.y_Df, aircraftMassCenter1.u_drags[1]) annotation(
    Line(points = {{-18, -40}, {84, -40}, {84, 12}, {68, 12}, {68, 12}}, color = {0, 0, 127}));
  connect(wingSimple001.y_Lf, aircraftMassCenter1.u_lifts[1]) annotation(
    Line(points = {{-40, -18}, {-40, -18}, {-40, 52}, {38, 52}, {38, 42}, {38, 42}}, color = {0, 0, 127}));
  connect(boundary.ports[1], wingSimple001.port_amb) annotation(
    Line(points = {{-80, 50}, {-56, 50}, {-56, -20}}, color = {0, 127, 255}));
  connect(wingSimple001.busFltStates1, aircraftMassCenter1.busFltStates1) annotation(
    Line(points = {{-56, -60}, {-56, -66}, {14, -66}, {14, -18}}, color = {255, 204, 51}, thickness = 0.5));
  connect(const.y, aircraftMassCenter1.u_thrusts[1]) annotation(
    Line(points = {{-78, 10}, {-39, 10}, {-39, 12}, {8, 12}}, color = {0, 0, 127}));
end testAircraft001;
