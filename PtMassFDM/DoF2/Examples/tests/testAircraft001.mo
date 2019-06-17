within AircraftDynamics.PtMassFDM.DoF2.Examples.tests;

model testAircraft001
  extends Modelica.Icons.Example;
  package atmAir = Modelica.Media.Air.DryAirNasa;
  //redeclare package Medium = atmAir
  //----------
  AircraftDynamics.PtMassFDM.DoF2.Components.AircraftMassCenter aircraftMassCenter1(massBase = 500, switchDef_modeStabilityLongi = AircraftDynamics.Types.switches.switch_modeStabilityLongi.maintainAoA) annotation(
    Placement(visible = true, transformation(origin = {10, 10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0 * 1000) annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wingSimple001(redeclare package Medium = atmAir, ChRootDes = 2, Sdes = 50) annotation(
    Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 5 * Modelica.Constants.pi / 180) annotation(
    Placement(visible = true, transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(boundary.ports[1], wingSimple001.port_amb) annotation(
    Line(points = {{-80, 50}, {-56, 50}, {-56, -20}}, color = {0, 127, 255}));
  connect(wingSimple001.y_Df, aircraftMassCenter1.u_drags[1]) annotation(
    Line(points = {{-18, -40}, {84, -40}, {84, 10}, {40, 10}}, color = {0, 0, 127}));
  connect(wingSimple001.y_Lf, aircraftMassCenter1.u_lifts[1]) annotation(
    Line(points = {{-40, -18}, {-40, 52}, {10, 52}, {10, 40}}, color = {0, 0, 127}));
  connect(wingSimple001.busFltStates1, aircraftMassCenter1.busFltStates1) annotation(
    Line(points = {{-56, -60}, {-56, -66}, {-14, -66}, {-14, -20}}, color = {255, 204, 51}, thickness = 0.5));
  connect(const.y, aircraftMassCenter1.u_thrusts[1]) annotation(
    Line(points = {{-78, 10}, {-20, 10}}, color = {0, 0, 127}));
  connect(const1.y, aircraftMassCenter1.busFltStates1.alphaCmd) annotation(
    Line(points = {{-78, -90}, {-14, -90}, {-14, -20}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end testAircraft001;
