within AircraftDynamics.PtMassFDM.DoF2.Examples.tests;

model testAircraft001
  extends Modelica.Icons.Example;
  package atmAir = Modelica.Media.Air.DryAirNasa;
  //redeclare package Medium = atmAir
  //----------
  AircraftDynamics.PtMassFDM.DoF2.Components.AircraftMassCenter aircraftMassCenter1(Vinit = 70, gammaInit = 1.74533e-05,massBase = 1160, nIn_FxBackward = 2, switchDef_modeStabilityLongi = AircraftDynamics.Types.switches.switch_modeStabilityLongi.maintainAoA) annotation(
    Placement(visible = true, transformation(origin = {30, -10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-60, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.0 * 2600) annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 2) annotation(
    Placement(visible = true, transformation(origin = {-90, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = Modelica.Constants.pi / 180)  annotation(
    Placement(visible = true, transformation(origin = {-60, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wingSimple001(redeclare package Medium = atmAir, ARdes = 7.5625, ChRootDes = 1.455, ClmaxDes = 1.3, Sdes = 16, alpha4Cl0des = -0.000913853, alpha4ClmaxDes = 0.00396003, alpha4ClminDes = -0.00365542, alpha_CdpMinDes(displayUnit = "")) annotation(
    Placement(visible = true, transformation(origin = {-45.7143, -10}, extent = {{-14.2857, -50}, {14.2857, 50}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.DragObjSimple00 dragObjSimple001(redeclare package Medium = atmAir, CDdes = 0.005, SrefDes = 16) annotation(
    Placement(visible = true, transformation(origin = {97, -10.2}, extent = {{-17, -10.2}, {17, 10.2}}, rotation = 0)));
equation
  connect(dragObjSimple001.y_Fx, aircraftMassCenter1.u_FxBackward[2]) annotation(
    Line(points = {{116, -10}, {122, -10}, {122, 18}, {60, 18}, {60, -10}, {60, -10}}, color = {0, 0, 127}));
  connect(const1.y, gain1.u) annotation(
    Line(points = {{-79, -110}, {-73, -110}}, color = {0, 0, 127}));
  connect(gain1.y, aircraftMassCenter1.busFltStates1.alphaCmd) annotation(
    Line(points = {{-49, -110}, {6, -110}, {6, -40}}, color = {0, 0, 127}));
  connect(wingSimple001.busFltStates1, aircraftMassCenter1.busFltStates1) annotation(
    Line(points = {{-56.4286, -60}, {-56.4286, -64}, {6.00019, -64}, {6.00019, -40}}, color = {255, 204, 51}, thickness = 0.5));
  connect(const.y, aircraftMassCenter1.u_FxForward[1]) annotation(
    Line(points = {{-79, -70}, {-9, -70}, {-9, -10}, {0, -10}}, color = {0, 0, 127}));
  connect(wingSimple001.y_Fx, aircraftMassCenter1.u_FxBackward[1]) annotation(
    Line(points = {{-29.6429, -10}, {-21.6426, -10}, {-21.6426, 32}, {60, 32}, {60, -10}}, color = {0, 0, 127}));
  connect(boundary.ports[2], dragObjSimple001.port_amb) annotation(
    Line(points = {{-80, 50}, {-72, 50}, {-72, 66}, {82, 66}, {82, 0}}, color = {0, 127, 255}));
  connect(dragObjSimple001.busFltStates1, aircraftMassCenter1.busFltStates1) annotation(
    Line(points = {{82, -20}, {82, -58}, {6, -58}, {6, -40}}, color = {255, 204, 51}, thickness = 0.5));
  connect(wingSimple001.y_Fz, aircraftMassCenter1.u_Fz[1]) annotation(
    Line(points = {{-45.7143, 41.7857}, {-45.7143, 49.7857}, {30, 49.7857}, {30, 20}}, color = {0, 0, 127}));
  connect(boundary.ports[1], wingSimple001.port_amb) annotation(
    Line(points = {{-80, 50}, {-68, 50}, {-68, 40}, {-56, 40}}, color = {0, 127, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
  Diagram(coordinateSystem(extent = {{-100, -120}, {140, 100}}, initialScale = 0.1), graphics = {Text(origin = {-88, -53}, extent = {{-8, 3}, {8, -3}}, textString = "Thrust Source"), Text(origin = {-85, -93}, extent = {{-13, 3}, {13, -3}}, textString = "AoA to be sustained")}),
  Icon(coordinateSystem(extent = {{-100, -120}, {140, 100}})),
  __OpenModelica_commandLineOptions = "");
end testAircraft001;
