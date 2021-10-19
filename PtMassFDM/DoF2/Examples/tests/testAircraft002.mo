within AircraftDynamics.PtMassFDM.DoF2.Examples.tests;

model testAircraft002
  extends Modelica.Icons.Example;
  package atmAir = Modelica.Media.Air.DryAirNasa;
  //redeclare package Medium = atmAir
  //----------
  AircraftDynamics.PtMassFDM.DoF2.Components.AircraftMassCenter aircraftMassCenter1(Vinit = 70, gammaInit = 1.74533e-05, massBase = 1160, nIn_FxBackward = 2, nIn_Fz = 2, switchDef_modeStabilityLongi = AircraftDynamics.Types.switches.switch_modeStabilityLongi.maintainAoA) annotation(
    Placement(visible = true, transformation(origin = {76, -10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-60, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 2) annotation(
    Placement(visible = true, transformation(origin = {-90, -170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = Modelica.Constants.pi / 180) annotation(
    Placement(visible = true, transformation(origin = {-60, -170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wingSimple001(redeclare package Medium = atmAir, ARdes = 7.5625, ChRootDes = 1.455, ClmaxDes = 1.3, Sdes = 16, alpha4Cl0des = -0.000913853, alpha4ClmaxDes = 0.00396003, alpha4ClminDes = -0.00365542, alpha_CdpMinDes(displayUnit = "")) annotation(
    Placement(visible = true, transformation(origin = {0.285702, -10}, extent = {{-14.2857, -50}, {14.2857, 50}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.DragObjSimple00 dragObjSimple001(redeclare package Medium = atmAir, CDdes = 0.005, SrefDes = 16) annotation(
    Placement(visible = true, transformation(origin = {143, -10.2}, extent = {{-17, -10.2}, {17, 10.2}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_thrust(duration = 1, height = 500, offset = 1500, startTime = 50)  annotation(
    Placement(visible = true, transformation(origin = { -70,-90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(gain1.y, aircraftMassCenter1.InfoBus1.alphaCmd) annotation(
    Line(points = {{-49, -170}, {52, -170}, {52, -40}}, color = {255, 170, 0}));
  connect(ramp_thrust.y, aircraftMassCenter1.u_FxForward[1]) annotation(
    Line(points = {{-58, -90}, {36, -90}, {36, -10}, {46, -10}, {46, -10}}, color = {0, 0, 127}));
  connect(boundary.ports[1], wingSimple001.port_amb) annotation(
    Line(points = {{-80, 50}, {-68, 50}, {-68, 40}, {-10, 40}}, color = {0, 127, 255}));
  connect(wingSimple001.y_Fz, aircraftMassCenter1.u_Fz[1]) annotation(
    Line(points = {{0.285702, 41.7857}, {0.285702, 49.7857}, {76, 49.7857}, {76, 20}}, color = {0, 0, 127}));
  connect(wingSimple001.y_Fx, aircraftMassCenter1.u_FxBackward[1]) annotation(
    Line(points = {{16.3571, -10}, {24.3575, -10}, {24.3575, 32}, {106, 32}, {106, -10}}, color = {0, 0, 127}));
  connect(wingSimple001.busFltStates1, aircraftMassCenter1.InfoBus1) annotation(
    Line(points = {{-10.4286, -60}, {-10.4286, -64}, {52.0003, -64}, {52.0003, -40}}, color = {255, 204, 51}, thickness = 0.5));
  connect(dragObjSimple001.busFltStates1, aircraftMassCenter1.InfoBus1) annotation(
    Line(points = {{127.7, -20.4}, {127.7, -58.4}, {51.7, -58.4}, {51.7, -40.4}}, color = {255, 204, 51}, thickness = 0.5));
  connect(boundary.ports[2], dragObjSimple001.port_amb) annotation(
    Line(points = {{-80, 50}, {-72, 50}, {-72, 66}, {128, 66}, {128, 0}}, color = {0, 127, 255}));
  connect(dragObjSimple001.y_Fx, aircraftMassCenter1.u_FxBackward[2]) annotation(
    Line(points = {{161.7, -10.2}, {167.7, -10.2}, {167.7, 17.8}, {105.7, 17.8}, {105.7, -10.2}, {105.7, -10.2}}, color = {0, 0, 127}));
  connect(dragObjSimple001.y_Fz, aircraftMassCenter1.u_Fz[2]) annotation(
    Line(points = {{143, 1.7}, {141, 1.7}, {141, 43.7}, {75, 43.7}, {75, 19.7}, {75, 19.7}}, color = {0, 0, 127}));
  connect(const1.y, gain1.u) annotation(
    Line(points = {{-79, -170}, {-73, -170}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 300, Tolerance = 1e-06, Interval = 0.03),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-100, -200}, {180, 100}}), graphics = {Text(origin = {-85, -153}, extent = {{-13, 3}, {13, -3}}, textString = "AoA to be sustained")}),
    Icon(coordinateSystem(extent = {{-100, -120}, {140, 100}})),
    __OpenModelica_commandLineOptions = "");

end testAircraft002;
