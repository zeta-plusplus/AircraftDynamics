within AircraftDynamics.PtMassFDM.DoF2.Examples.ExampleAircrafts;

model AGM84_ex02
  extends Modelica.Icons.Example;
  package atmAir = Modelica.Media.Air.DryAirNasa;
  //redeclare package Medium = atmAir
  //----------
  AircraftDynamics.PtMassFDM.DoF2.Components.AircraftMassCenter aircraftMassCenter1(Vinit = 0.5 * 340, altInit = 50, gammaInit = 1.74533e-05, massBase = 519, nIn_FxBackward = 2, nIn_Fz = 2, switchDef_modeStabilityLongi = AircraftDynamics.Types.switches.switch_modeStabilityLongi.maintainPitch) annotation(
    Placement(visible = true, transformation(origin = {76, -10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-60, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, nPorts = 3) annotation(
    Placement(visible = true, transformation(origin = {-150, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wing(redeclare package Medium = atmAir, ARdes = (0.287 * 2) ^ 2 / (1 / 2 * wing.Sdes), ChRootDes = 0.7624113, ClmaxDes = 1.4, Sdes = 1 / 2 * (0.4030733 + 0.7624113) * 0.287 * 4, alpha4Cl0des = 0, alpha4ClmaxDes (displayUnit = "deg") = 0.261799, alpha4ClminDes (displayUnit = "deg") = -0.261799, alpha_CdpMinDes(displayUnit = ""), effOsDes = 0.8) annotation(
    Placement(visible = true, transformation(origin = {-45.7143, 0}, extent = {{-14.2857, -50}, {14.2857, 50}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.DragObjSimple00 dragObjSimple001(redeclare package Medium = atmAir, CDdes = 0.3, SrefDes = Modelica.Constants.pi / 4.0 * 0.343 ^ 2) annotation(
    Placement(visible = true, transformation(origin = {143, -10.2}, extent = {{-17, -10.2}, {17, 10.2}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp r_Mn(duration = 5, height = 0.05, offset = 0.8, startTime = 300)  annotation(
    Placement(visible = true, transformation(origin = { -290, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp r_alt(duration = 10, height = -10, offset = 55, startTime = 100) annotation(
    Placement(visible = true, transformation(origin = {-290, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback_ctrl_pitch annotation(
    Placement(visible = true, transformation(origin = {-100, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain propGain_pitch(k = 10)  annotation(
    Placement(visible = true, transformation(origin = {-60, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integGain_pitch(initType = Modelica.Blocks.Types.Init.NoInit, k = 10)  annotation(
    Placement(visible = true, transformation(origin = {-60, -210}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum_ctrl_pitch(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {-20, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-130, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain propGain_thrust(k = 6) annotation(
    Placement(visible = true, transformation(origin = {-220, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum_ctrl_thrust(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {-180, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integGain_thrust(initType = Modelica.Blocks.Types.Init.NoInit, k = 0.3, y_start = 0.0) annotation(
    Placement(visible = true, transformation(origin = {-220, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback_ctrl_thrust annotation(
    Placement(visible = true, transformation(origin = {-260, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Sensors.Mach sensorMach annotation(
    Placement(visible = true, transformation(origin = {80, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  AircraftDynamics.Sensors.FlightPathAngle sensorGamma annotation(
    Placement(visible = true, transformation(origin = {100, -230}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Gain thrust_nominal(k = 2900) annotation(
    Placement(visible = true, transformation(origin = {-30, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain3(k = cos(45 * Modelica.Constants.pi / 180))  annotation(
    Placement(visible = true, transformation(origin = {5, 66}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter_pitch(limitsAtInit = true, uMax = 60.0 * Modelica.Constants.pi / 180.0, uMin = -30.0 * Modelica.Constants.pi / 180.0)  annotation(
    Placement(visible = true, transformation(origin = {10, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter_thrustLevel(limitsAtInit = true, uMax = 1.25, uMin = -0.25) annotation(
    Placement(visible = true, transformation(origin = {-60, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter_fltPath(limitsAtInit = true, uMax = 10, uMin = -10) annotation(
    Placement(visible = true, transformation(origin = {-160, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Sensors.Altitude sensorAltitude annotation(
    Placement(visible = true, transformation(origin = {120, -250}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-260, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain propGain_fltPath(k = 0.04) annotation(
    Placement(visible = true, transformation(origin = {-230, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integGain_fltPath(initType = Modelica.Blocks.Types.Init.NoInit, k = 0.015) annotation(
    Placement(visible = true, transformation(origin = {-230, -210}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {-190, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.SecondOrder delay_thrust(D = 1.0, k = 1, w = 1.0)  annotation(
    Placement(visible = true, transformation(origin = {10, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Derivative derivative1 annotation(
    Placement(visible = true, transformation(origin = {-150, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 0.1, uMin = -0.1) annotation(
    Placement(visible = true, transformation(origin = {-120, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator1 annotation(
    Placement(visible = true, transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(aircraftMassCenter1.FltStatesBus1, sensorAltitude.FltStatesBus1) annotation(
    Line(points = {{100, -40}, {100, -40}, {100, -92}, {120, -92}, {120, -240}, {120, -240}}, color = {170, 0, 127}, thickness = 0.5));
  connect(limiter_pitch.y, aircraftMassCenter1.InfoBus1.thetaCmd) annotation(
    Line(points = {{22, -180}, {52, -180}, {52, -40}, {52, -40}}, color = {0, 0, 127}));
  connect(sum_ctrl_pitch.y, limiter_pitch.u) annotation(
    Line(points = {{-9, -180}, {-2, -180}}, color = {0, 0, 127}));
  connect(propGain_pitch.y, sum_ctrl_pitch.u[1]) annotation(
    Line(points = {{-49, -180}, {-32, -180}}, color = {0, 0, 127}));
  connect(integGain_pitch.y, sum_ctrl_pitch.u[2]) annotation(
    Line(points = {{-49, -210}, {-43, -210}, {-43, -180}, {-33, -180}, {-33, -180}}, color = {0, 0, 127}));
  connect(feedback_ctrl_pitch.y, propGain_pitch.u) annotation(
    Line(points = {{-91, -180}, {-72, -180}}, color = {0, 0, 127}));
  connect(feedback_ctrl_pitch.y, integGain_pitch.u) annotation(
    Line(points = {{-91, -180}, {-83, -180}, {-83, -210}, {-72, -210}}, color = {0, 0, 127}));
  connect(from_deg1.y, feedback_ctrl_pitch.u1) annotation(
    Line(points = {{-119, -180}, {-108, -180}}, color = {0, 0, 127}));
  connect(feedback_ctrl_pitch.u2, sensorGamma.y_gamma) annotation(
    Line(points = {{-100, -188}, {-100, -230}, {88, -230}}, color = {0, 0, 127}));
  connect(limiter_fltPath.y, from_deg1.u) annotation(
    Line(points = {{-149, -180}, {-143, -180}}, color = {0, 0, 127}));
  connect(sum1.y, limiter_fltPath.u) annotation(
    Line(points = {{-179, -180}, {-175, -180}, {-175, -180}, {-173, -180}}, color = {0, 0, 127}));
  connect(integGain_fltPath.y, sum1.u[2]) annotation(
    Line(points = {{-219, -210}, {-213, -210}, {-213, -180}, {-203, -180}, {-203, -180}}, color = {0, 0, 127}));
  connect(feedback1.y, integGain_fltPath.u) annotation(
    Line(points = {{-251, -180}, {-248, -180}, {-248, -210}, {-242, -210}}, color = {0, 0, 127}));
  connect(propGain_fltPath.y, sum1.u[1]) annotation(
    Line(points = {{-219, -180}, {-205, -180}, {-205, -180}, {-203, -180}}, color = {0, 0, 127}));
  connect(r_alt.y, feedback1.u1) annotation(
    Line(points = {{-279, -180}, {-269, -180}}, color = {0, 0, 127}));
  connect(feedback1.y, propGain_fltPath.u) annotation(
    Line(points = {{-251, -180}, {-242, -180}}, color = {0, 0, 127}));
  connect(feedback1.u2, sensorAltitude.y_alt) annotation(
    Line(points = {{-260, -188}, {-260, -250}, {108, -250}}, color = {0, 0, 127}));
  connect(wing.y_Fx, aircraftMassCenter1.u_FxBackward[2]) annotation(
    Line(points = {{-30, 0}, {-16, 0}, {-16, 30}, {106, 30}, {106, -10}, {106, -10}}, color = {0, 0, 127}));
  connect(delay_thrust.y, aircraftMassCenter1.u_FxForward[1]) annotation(
    Line(points = {{22, -90}, {36, -90}, {36, -10}, {46, -10}}, color = {0, 0, 127}));
  connect(aircraftMassCenter1.InfoBus1.gamma, aircraftMassCenter1.fltStates.gamma) annotation(
    Line);
  connect(aircraftMassCenter1.FltStatesBus1, sensorMach.FltStatesBus1) annotation(
    Line(points = {{100, -40}, {100, -104}, {80, -104}, {80, -130}}, color = {170, 0, 127}, thickness = 0.5));
  connect(aircraftMassCenter1.FltStatesBus1, sensorGamma.FltStatesBus1) annotation(
    Line(points = {{100, -40}, {100, -220}}, color = {170, 0, 127}, thickness = 0.5));
  connect(wing.busFltStates1, aircraftMassCenter1.InfoBus1) annotation(
    Line(points = {{-53, -50}, {-53, -58}, {52, -58}, {52, -40}}, color = {255, 204, 51}, thickness = 0.5));
  connect(dragObjSimple001.busFltStates1, aircraftMassCenter1.InfoBus1) annotation(
    Line(points = {{127.7, -20.4}, {127.7, -48.8}, {51.4, -48.8}, {51.4, -40.8}}, color = {255, 204, 51}, thickness = 0.5));
  connect(dragObjSimple001.y_Fz, aircraftMassCenter1.u_Fz[1]) annotation(
    Line(points = {{143, 1.7}, {141, 1.7}, {141, 35.7}, {75, 35.7}, {75, 19.7}, {75, 19.7}}, color = {0, 0, 127}));
  connect(dragObjSimple001.y_Fx, aircraftMassCenter1.u_FxBackward[1]) annotation(
    Line(points = {{161.7, -10.2}, {165.7, -10.2}, {165.7, 25.8}, {105.7, 25.8}, {105.7, -10.2}}, color = {0, 0, 127}));
  connect(gain3.y, aircraftMassCenter1.u_Fz[2]) annotation(
    Line(points = {{10, 66}, {76, 66}, {76, 20}}, color = {0, 0, 127}));
  connect(sensorAltitude.FltStatesBus1, aircraftMassCenter1.FltStatesBus1) annotation(
    Line(points = {{100, -40}, {100, -40}}, color = {255, 204, 51}, thickness = 0.5));
  connect(boundary.ports[2], dragObjSimple001.port_amb) annotation(
    Line(points = {{-140, 90}, {128, 90}, {128, 0}}, color = {0, 127, 255}));
  connect(wing.y_Fz, gain3.u) annotation(
    Line(points = {{-46, 52}, {-46, 66}, {-1, 66}}, color = {0, 0, 127}));
  connect(boundary.ports[1], wing.port_amb) annotation(
    Line(points = {{-140, 90}, {-53, 90}, {-53, 50}}, color = {0, 127, 255}));
  connect(feedback_ctrl_thrust.y, integGain_thrust.u) annotation(
    Line(points = {{-251, -90}, {-247, -90}, {-247, -120}, {-232, -120}}, color = {0, 0, 127}));
  connect(derivative1.y, limiter1.u) annotation(
    Line(points = {{-138, -90}, {-134, -90}, {-134, -90}, {-132, -90}}, color = {0, 0, 127}));
  connect(sum_ctrl_thrust.y, derivative1.u) annotation(
    Line(points = {{-168, -90}, {-164, -90}, {-164, -90}, {-162, -90}}, color = {0, 0, 127}));
  connect(limiter1.y, integrator1.u) annotation(
    Line(points = {{-109, -90}, {-102, -90}}, color = {0, 0, 127}));
  connect(integrator1.y, limiter_thrustLevel.u) annotation(
    Line(points = {{-79, -90}, {-72, -90}}, color = {0, 0, 127}));
  connect(limiter_thrustLevel.y, thrust_nominal.u) annotation(
    Line(points = {{-49, -90}, {-42, -90}}, color = {0, 0, 127}));
  connect(thrust_nominal.y, delay_thrust.u) annotation(
    Line(points = {{-19, -90}, {-2, -90}}, color = {0, 0, 127}));
  connect(feedback_ctrl_thrust.u2, sensorMach.y_Mn) annotation(
    Line(points = {{-260, -98}, {-260, -140}, {68, -140}}, color = {0, 0, 127}));
  connect(integGain_thrust.y, sum_ctrl_thrust.u[2]) annotation(
    Line(points = {{-209, -120}, {-199, -120}, {-199, -90}, {-192, -90}}, color = {0, 0, 127}));
  connect(propGain_thrust.y, sum_ctrl_thrust.u[1]) annotation(
    Line(points = {{-209, -90}, {-192, -90}}, color = {0, 0, 127}));
  connect(feedback_ctrl_thrust.y, propGain_thrust.u) annotation(
    Line(points = {{-251, -90}, {-232, -90}}, color = {0, 0, 127}));
  connect(r_Mn.y, feedback_ctrl_thrust.u1) annotation(
    Line(points = {{-279, -90}, {-268, -90}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 0.05),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-300, -300}, {180, 140}})),
    Icon(coordinateSystem(extent = {{-100, -120}, {140, 100}})),
    __OpenModelica_commandLineOptions = "");

end AGM84_ex02;
