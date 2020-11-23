within AircraftDynamics.PtMassFDM.DoF2.Examples.tests;

model AGM84_00_test03
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
  Modelica.Blocks.Sources.Ramp ramp_thrust(duration = 10, height = 0, offset = 0.8, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = { -130, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_gammaCmd(duration = 5, height = -1, offset = 1, startTime = 5) annotation(
    Placement(visible = true, transformation(origin = {-140, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-70, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-30, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator1(initType = Modelica.Blocks.Types.Init.NoInit, k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-30, -220}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {10, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-110, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain2(k = 10) annotation(
    Placement(visible = true, transformation(origin = {-36, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum11(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {4, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator2(initType = Modelica.Blocks.Types.Init.NoInit, k = 100) annotation(
    Placement(visible = true, transformation(origin = {-36, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback2 annotation(
    Placement(visible = true, transformation(origin = {-76, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp_thrust.y, feedback2.u1) annotation(
    Line(points = {{-118, -110}, {-84, -110}, {-84, -110}, {-84, -110}}, color = {0, 0, 127}));
  connect(aircraftMassCenter1.busFltStates1.Mn, feedback2.u2) annotation(
    Line(points = {{52, -40}, {52, -40}, {52, -48}, {44, -48}, {44, -164}, {-76, -164}, {-76, -118}, {-76, -118}}, color = {0, 0, 127}));
  connect(sum11.y, aircraftMassCenter1.u_FxForward[1]) annotation(
    Line(points = {{16, -110}, {28, -110}, {28, -10}, {46, -10}, {46, -10}}, color = {0, 0, 127}));
  connect(feedback2.y, integrator2.u) annotation(
    Line(points = {{-66, -110}, {-58, -110}, {-58, -140}, {-48, -140}, {-48, -140}}, color = {0, 0, 127}));
  connect(integrator2.y, sum11.u[2]) annotation(
    Line(points = {{-24, -140}, {-16, -140}, {-16, -110}, {-8, -110}, {-8, -110}}, color = {0, 0, 127}));
  connect(gain2.y, sum11.u[1]) annotation(
    Line(points = {{-24, -110}, {-8, -110}, {-8, -110}, {-8, -110}}, color = {0, 0, 127}));
  connect(feedback2.y, gain2.u) annotation(
    Line(points = {{-66, -110}, {-50, -110}, {-50, -110}, {-48, -110}}, color = {0, 0, 127}));
  connect(feedback1.y, integrator1.u) annotation(
    Line(points = {{-61, -190}, {-53, -190}, {-53, -220}, {-43, -220}}, color = {0, 0, 127}));
  connect(integrator1.y, sum1.u[2]) annotation(
    Line(points = {{-19, -220}, {-11, -220}, {-11, -190}, {-3, -190}, {-3, -190}}, color = {0, 0, 127}));
  connect(gain1.y, sum1.u[1]) annotation(
    Line(points = {{-19, -190}, {-2, -190}}, color = {0, 0, 127}));
  connect(sum1.y, aircraftMassCenter1.busFltStates1.thetaCmd) annotation(
    Line(points = {{21, -190}, {52, -190}, {52, -40}}, color = {0, 0, 127}));
  connect(feedback1.y, gain1.u) annotation(
    Line(points = {{-61, -190}, {-43, -190}}, color = {0, 0, 127}));
  connect(aircraftMassCenter1.busFltStates1.gamma, feedback1.u2) annotation(
    Line(points = {{52, -40}, {53, -40}, {53, -52}, {66, -52}, {66, -254}, {-70, -254}, {-70, -198}}, color = {0, 0, 127}));
  connect(from_deg1.y, feedback1.u1) annotation(
    Line(points = {{-99, -190}, {-78, -190}}, color = {0, 0, 127}));
  connect(ramp_gammaCmd.y, from_deg1.u) annotation(
    Line(points = {{-129, -190}, {-122, -190}}, color = {0, 0, 127}));
  connect(aircraftMassCenter1.busFltStates1.gamma, aircraftMassCenter1.fltStates.gamma);
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

end AGM84_00_test03;
