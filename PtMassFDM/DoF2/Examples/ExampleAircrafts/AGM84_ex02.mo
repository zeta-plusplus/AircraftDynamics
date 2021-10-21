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
    Placement(visible = true, transformation(origin = {-45.7143, -10}, extent = {{-14.2857, -50}, {14.2857, 50}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.DragObjSimple00 dragObjSimple001(redeclare package Medium = atmAir, CDdes = 0.3, SrefDes = Modelica.Constants.pi / 4.0 * 0.343 ^ 2) annotation(
    Placement(visible = true, transformation(origin = {143, -10.2}, extent = {{-17, -10.2}, {17, 10.2}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp r_Mn(duration = 10, height = 0.05, offset = 0.8, startTime = 300)  annotation(
    Placement(visible = true, transformation(origin = { -164, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp r_alt(duration = 1, height = 0, offset = 60, startTime = 40) annotation(
    Placement(visible = true, transformation(origin = {-270, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback_ctrl_pitch annotation(
    Placement(visible = true, transformation(origin = {-80, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain propGain_pitch(k = 10)  annotation(
    Placement(visible = true, transformation(origin = {-40, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integGain_pitch(initType = Modelica.Blocks.Types.Init.NoInit, k = 10)  annotation(
    Placement(visible = true, transformation(origin = {-40, -210}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum_ctrl_pitch(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {0, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-110, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain propGain_thrust(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-90, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum_ctrl_thrust(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {-50, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integGain_thrust(initType = Modelica.Blocks.Types.Init.NoInit, k = 0.001, y_start = 0.0) annotation(
    Placement(visible = true, transformation(origin = {-90, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback_ctrl_thrust annotation(
    Placement(visible = true, transformation(origin = {-130, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Sensors.Mach sensorMach annotation(
    Placement(visible = true, transformation(origin = {80, -150}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  AircraftDynamics.Sensors.FlightPathAngle sensorGamma annotation(
    Placement(visible = true, transformation(origin = {100, -230}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Gain thrust_nominal(k = 2.9 * 10e3) annotation(
    Placement(visible = true, transformation(origin = {10, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain3(k = cos(45 * Modelica.Constants.pi / 180))  annotation(
    Placement(visible = true, transformation(origin = {5, 66}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter_pitch(limitsAtInit = true, uMax = 60.0 * Modelica.Constants.pi / 180.0, uMin = -30.0 * Modelica.Constants.pi / 180.0)  annotation(
    Placement(visible = true, transformation(origin = {30, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter_thrustLevel(limitsAtInit = true, uMax = 1.5, uMin = -0.1) annotation(
    Placement(visible = true, transformation(origin = {-20, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter_fltPath(limitsAtInit = true, uMax = 10, uMin = -10) annotation(
    Placement(visible = true, transformation(origin = {-140, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Sensors.Altitude sensorAltitude annotation(
    Placement(visible = true, transformation(origin = {120, -250}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-240, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain propGain_fltPath(k = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-210, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integGain_fltPath(initType = Modelica.Blocks.Types.Init.NoInit, k = 0.001) annotation(
    Placement(visible = true, transformation(origin = {-210, -210}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {-170, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sensorAltitude.FltStatesBus1, aircraftMassCenter1.FltStatesBus1) annotation(
    Line(points = {{100, -40}, {100, -40}, {100, -80}, {120, -80}, {120, -240}, {120, -240}}, color = {255, 204, 51}, thickness = 0.5));
  connect(feedback1.u2, sensorAltitude.y_alt) annotation(
    Line(points = {{-240, -188}, {-240, -250}, {108, -250}}, color = {0, 0, 127}));
  connect(feedback1.y, integGain_fltPath.u) annotation(
    Line(points = {{-231, -180}, {-228, -180}, {-228, -210}, {-222, -210}}, color = {0, 0, 127}));
  connect(feedback1.y, propGain_fltPath.u) annotation(
    Line(points = {{-231, -180}, {-222, -180}}, color = {0, 0, 127}));
  connect(r_alt.y, feedback1.u1) annotation(
    Line(points = {{-258, -180}, {-248, -180}}, color = {0, 0, 127}));
  connect(integGain_fltPath.y, sum1.u[2]) annotation(
    Line(points = {{-198, -210}, {-192, -210}, {-192, -180}, {-182, -180}, {-182, -180}}, color = {0, 0, 127}));
  connect(propGain_fltPath.y, sum1.u[1]) annotation(
    Line(points = {{-198, -180}, {-184, -180}, {-184, -180}, {-182, -180}}, color = {0, 0, 127}));
  connect(sum1.y, limiter_fltPath.u) annotation(
    Line(points = {{-158, -180}, {-154, -180}, {-154, -180}, {-152, -180}}, color = {0, 0, 127}));
  connect(limiter_fltPath.y, from_deg1.u) annotation(
    Line(points = {{-129, -180}, {-123, -180}}, color = {0, 0, 127}));
  connect(integGain_pitch.y, sum_ctrl_pitch.u[2]) annotation(
    Line(points = {{-28, -210}, {-22, -210}, {-22, -180}, {-12, -180}, {-12, -180}}, color = {0, 0, 127}));
  connect(feedback_ctrl_pitch.u2, sensorGamma.y_gamma) annotation(
    Line(points = {{-80, -188}, {-80, -230}, {88, -230}}, color = {0, 0, 127}));
  connect(from_deg1.y, feedback_ctrl_pitch.u1) annotation(
    Line(points = {{-99, -180}, {-88, -180}}, color = {0, 0, 127}));
  connect(feedback_ctrl_pitch.y, integGain_pitch.u) annotation(
    Line(points = {{-71, -180}, {-63, -180}, {-63, -210}, {-52, -210}}, color = {0, 0, 127}));
  connect(feedback_ctrl_pitch.y, propGain_pitch.u) annotation(
    Line(points = {{-71, -180}, {-52, -180}}, color = {0, 0, 127}));
  connect(propGain_pitch.y, sum_ctrl_pitch.u[1]) annotation(
    Line(points = {{-29, -180}, {-12, -180}}, color = {0, 0, 127}));
  connect(sum_ctrl_pitch.y, limiter_pitch.u) annotation(
    Line(points = {{11, -180}, {18, -180}}, color = {0, 0, 127}));
  connect(sum_ctrl_thrust.y, limiter_thrustLevel.u) annotation(
    Line(points = {{-38, -100}, {-34, -100}, {-34, -100}, {-32, -100}}, color = {0, 0, 127}));
  connect(limiter_thrustLevel.y, thrust_nominal.u) annotation(
    Line(points = {{-8, -100}, {-4, -100}, {-4, -100}, {-2, -100}}, color = {0, 0, 127}));
  connect(thrust_nominal.y, aircraftMassCenter1.u_FxForward[1]) annotation(
    Line(points = {{21, -100}, {32, -100}, {32, -10}, {46, -10}}, color = {0, 0, 127}));
  connect(propGain_thrust.y, sum_ctrl_thrust.u[1]) annotation(
    Line(points = {{-79, -100}, {-63, -100}, {-63, -100}, {-63, -100}}, color = {0, 0, 127}));
  connect(integGain_thrust.y, sum_ctrl_thrust.u[2]) annotation(
    Line(points = {{-79, -130}, {-71, -130}, {-71, -100}, {-63, -100}, {-63, -100}}, color = {0, 0, 127}));
  connect(feedback_ctrl_thrust.y, integGain_thrust.u) annotation(
    Line(points = {{-121, -100}, {-113, -100}, {-113, -130}, {-103, -130}, {-103, -130}}, color = {0, 0, 127}));
  connect(feedback_ctrl_thrust.y, propGain_thrust.u) annotation(
    Line(points = {{-121, -100}, {-105, -100}, {-105, -100}, {-103, -100}}, color = {0, 0, 127}));
  connect(feedback_ctrl_thrust.u2, sensorMach.y_Mn) annotation(
    Line(points = {{-130, -108}, {-130, -150}, {68, -150}}, color = {0, 0, 127}));
  connect(r_Mn.y, feedback_ctrl_thrust.u1) annotation(
    Line(points = {{-153, -100}, {-138, -100}}, color = {0, 0, 127}));
  connect(limiter_pitch.y, aircraftMassCenter1.InfoBus1.thetaCmd) annotation(
    Line(points = {{42, -180}, {52, -180}, {52, -40}, {52, -40}}, color = {0, 0, 127}));
  connect(boundary.ports[1], wing.port_amb) annotation(
    Line(points = {{-140, 90}, {-53, 90}, {-53, 40}}, color = {0, 127, 255}));
  connect(boundary.ports[2], dragObjSimple001.port_amb) annotation(
    Line(points = {{-140, 90}, {128, 90}, {128, 0}}, color = {0, 127, 255}));
  connect(wing.y_Df, aircraftMassCenter1.u_FxBackward[2]) annotation(
    Line(points = {{-30, -18}, {-10, -18}, {-10, 24}, {106, 24}, {106, -10}, {106, -10}}, color = {0, 0, 127}));
  connect(gain3.y, aircraftMassCenter1.u_Fz[2]) annotation(
    Line(points = {{10, 66}, {76, 66}, {76, 20}, {76, 20}}, color = {0, 0, 127}));
  connect(dragObjSimple001.y_Fx, aircraftMassCenter1.u_FxBackward[1]) annotation(
    Line(points = {{162, -10}, {170, -10}, {170, 26}, {106, 26}, {106, -10}, {106, -10}}, color = {0, 0, 127}));
  connect(dragObjSimple001.y_Fz, aircraftMassCenter1.u_Fz[1]) annotation(
    Line(points = {{144, 2}, {142, 2}, {142, 36}, {76, 36}, {76, 20}, {76, 20}}, color = {0, 0, 127}));
  connect(dragObjSimple001.busFltStates1, aircraftMassCenter1.InfoBus1) annotation(
    Line(points = {{128, -20}, {128, -58.4}, {51.7, -58.4}, {51.7, -40.4}}, color = {255, 204, 51}, thickness = 0.5));
  connect(wing.y_Fz, gain3.u) annotation(
    Line(points = {{-46, 42}, {-46, 66}, {-1, 66}}, color = {0, 0, 127}));
  connect(wing.busFltStates1, aircraftMassCenter1.InfoBus1) annotation(
    Line(points = {{-53, -60}, {-53, -64}, {52.0003, -64}, {52.0003, -40}}, color = {255, 204, 51}, thickness = 0.5));
  connect(aircraftMassCenter1.FltStatesBus1, sensorGamma.FltStatesBus1) annotation(
    Line(points = {{100, -40}, {100, -40}, {100, -220}, {100, -220}, {100, -220}}, color = {170, 0, 127}, thickness = 0.5));
  connect(aircraftMassCenter1.FltStatesBus1, sensorMach.FltStatesBus1) annotation(
    Line(points = {{100, -40}, {100, -40}, {100, -104}, {80, -104}, {80, -140}, {80, -140}}, color = {170, 0, 127}, thickness = 0.5));
  connect(aircraftMassCenter1.InfoBus1.gamma, aircraftMassCenter1.fltStates.gamma);
  annotation(
    experiment(StartTime = 0, StopTime = 300, Tolerance = 1e-06, Interval = 0.03),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-280, -300}, {180, 140}})),
    Icon(coordinateSystem(extent = {{-100, -120}, {140, 100}})),
    __OpenModelica_commandLineOptions = "");

end AGM84_ex02;
