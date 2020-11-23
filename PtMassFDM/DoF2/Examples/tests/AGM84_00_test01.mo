within AircraftDynamics.PtMassFDM.DoF2.Examples.tests;

model AGM84_00_test01
  extends Modelica.Icons.Example;
  package atmAir = Modelica.Media.Air.DryAirNasa;
  //redeclare package Medium = atmAir
  //----------
  AircraftDynamics.PtMassFDM.DoF2.Components.AircraftMassCenter aircraftMassCenter1(Vinit = 0.8 * 340, altInit = 50, gammaInit = 1.74533e-05, massBase = 519, nIn_FxBackward = 2, nIn_Fz = 2, switchDef_modeStabilityLongi = AircraftDynamics.Types.switches.switch_modeStabilityLongi.maintainPitch) annotation(
    Placement(visible = true, transformation(origin = {76, -10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-60, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wing(redeclare package Medium = atmAir, ARdes = (0.287 * 2) ^ 2 / (1 / 2 * wing.Sdes), ChRootDes = 0.7624113, ClmaxDes = 1.4, Sdes = 0.4730461, alpha4Cl0des = 0, alpha4ClmaxDes (displayUnit = "deg") = 0.261799, alpha4ClminDes (displayUnit = "deg") = -0.261799, alpha_CdpMinDes(displayUnit = ""), effOsDes = 0.9) annotation(
    Placement(visible = true, transformation(origin = {-35.7143, -10}, extent = {{-14.2857, -50}, {14.2857, 50}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.DragObjSimple00 dragObjSimple001(redeclare package Medium = atmAir, CDdes = 0.3, SrefDes = wing.Sdes) annotation(
    Placement(visible = true, transformation(origin = {143, -10.2}, extent = {{-17, -10.2}, {17, 10.2}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_thrust(duration = 10, height = 0, offset = 2.9 * 10e3, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = { -70, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-50, -128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_gammaCmd(duration = 5, height = 0, offset = 1, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-80, -128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(from_deg1.y, aircraftMassCenter1.busFltStates1.thetaCmd) annotation(
    Line(points = {{-39, -128}, {52, -128}, {52, -40}}, color = {0, 0, 127}));
  connect(ramp_gammaCmd.y, from_deg1.u) annotation(
    Line(points = {{-69, -128}, {-63, -128}}, color = {0, 0, 127}));
  connect(ramp_thrust.y, aircraftMassCenter1.u_FxForward[1]) annotation(
    Line(points = {{-59, -88}, {36, -88}, {36, -10}, {46, -10}}, color = {0, 0, 127}));
  connect(wing.y_Fx, aircraftMassCenter1.u_FxBackward[1]) annotation(
    Line(points = {{-20, -10}, {-13.6425, -10}, {-13.6425, 32}, {106, 32}, {106, -10}}, color = {0, 0, 127}));
  connect(wing.busFltStates1, aircraftMassCenter1.busFltStates1) annotation(
    Line(points = {{-43, -60}, {-43, -64}, {52.0003, -64}, {52.0003, -40}}, color = {255, 204, 51}, thickness = 0.5));
  connect(wing.y_Fz, aircraftMassCenter1.u_Fz[1]) annotation(
    Line(points = {{-34, 42}, {-34, 49.7857}, {76, 49.7857}, {76, 20}}, color = {0, 0, 127}));
  connect(boundary.ports[1], wing.port_amb) annotation(
    Line(points = {{-80, 50}, {-68, 50}, {-68, 40}, {-43, 40}}, color = {0, 127, 255}));
  connect(dragObjSimple001.busFltStates1, aircraftMassCenter1.busFltStates1) annotation(
    Line(points = {{127.7, -20.4}, {127.7, -58.4}, {51.7, -58.4}, {51.7, -40.4}}, color = {255, 204, 51}, thickness = 0.5));
  connect(boundary.ports[2], dragObjSimple001.port_amb) annotation(
    Line(points = {{-80, 50}, {-72, 50}, {-72, 66}, {128, 66}, {128, 0}}, color = {0, 127, 255}));
  connect(dragObjSimple001.y_Fx, aircraftMassCenter1.u_FxBackward[2]) annotation(
    Line(points = {{161.7, -10.2}, {167.7, -10.2}, {167.7, 17.8}, {105.7, 17.8}, {105.7, -10.2}, {105.7, -10.2}}, color = {0, 0, 127}));
  connect(dragObjSimple001.y_Fz, aircraftMassCenter1.u_Fz[2]) annotation(
    Line(points = {{143, 1.7}, {141, 1.7}, {141, 43.7}, {75, 43.7}, {75, 19.7}, {75, 19.7}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 300, Tolerance = 1e-06, Interval = 0.03),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-100, -300}, {180, 100}})),
    Icon(coordinateSystem(extent = {{-100, -120}, {140, 100}})),
    __OpenModelica_commandLineOptions = "");

end AGM84_00_test01;
