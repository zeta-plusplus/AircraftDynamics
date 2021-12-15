within AircraftDynamics.Aerodynamics.Example.test;

model WingSimple00_test01
  extends Modelica.Icons.Example;
  //package engineAir = Modelica.Media.Air.DryAirNasa;
  package engineAir= AircraftDynamics.Media.DryAirMethaneMixture00;
  //----
  AircraftDynamics.Aerodynamics.Components.Flight2Fluid flight2Fluid1(redeclare package Medium = engineAir, MNdes = 0.3, switchInput_AoA = AircraftDynamics.Types.switches.switch_input.use_inputSignal, switchInput_MN = AircraftDynamics.Types.switches.switch_input.use_inputSignal, switchInput_alt = AircraftDynamics.Types.switches.switch_input.use_inputSignal, switchInput_dTamb = AircraftDynamics.Types.switches.switch_input.use_inputSignal, switchInput_relHum = AircraftDynamics.Types.switches.switch_input.use_inputSignal, switchInput_sideSlip = AircraftDynamics.Types.switches.switch_input.use_inputSignal) annotation(
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 20, height = 0, offset = 0.8, startTime = 30)  annotation(
    Placement(visible = true, transformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 20, height = 5 * Modelica.Constants.pi / 180, offset = 5 * Modelica.Constants.pi / 180, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp3(duration = 20, height = 0, offset = 0, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp4(duration = 20, height = 0, offset = 0, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp5(duration = 20, height = 0, offset = 0, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp6(duration = 20, height = 0, offset = 0, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp7(duration = 20, height = 0, offset = 0, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wing(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {19.4286, -20}, extent = {{-11.4286, -40}, {11.4286, 40}}, rotation = 0)));
equation
  connect(flight2Fluid1.y_Mn, wing.busFltStates1.Mn) annotation(
    Line(points = {{-19, 10}, {-8, 10}, {-8, -60}, {14, -60}}, color = {0, 0, 127}));
  connect(ramp2.y, wing.busFltStates1.alpha) annotation(
    Line(points = {{-29, -30}, {-24, -30}, {-24, -60}, {14, -60}}, color = {0, 0, 127}));
  connect(flight2Fluid1.u_Mn, ramp1.y) annotation(
    Line(points = {{-41, 15}, {-69.5, 15}, {-69.5, 60}, {-79, 60}}, color = {0, 0, 127}));
  connect(ramp3.y, flight2Fluid1.u_dTamb) annotation(
    Line(points = {{-78, 30}, {-74, 30}, {-74, 12}, {-41, 12}}, color = {0, 0, 127}));
  connect(ramp4.y, flight2Fluid1.u_relHum) annotation(
    Line(points = {{-78, -60}, {-66, -60}, {-66, 2}, {-41, 2}}, color = {0, 0, 127}));
  connect(ramp5.y, flight2Fluid1.u_AoA) annotation(
    Line(points = {{-78, 0}, {-74, 0}, {-74, 8}, {-41, 8}}, color = {0, 0, 127}));
  connect(ramp7.y, flight2Fluid1.u_alt) annotation(
    Line(points = {{-78, 90}, {-64, 90}, {-64, 18}, {-41, 18}}, color = {0, 0, 127}));
  connect(ramp6.y, flight2Fluid1.u_sideSlip) annotation(
    Line(points = {{-78, -30}, {-70, -30}, {-70, 4}, {-41, 4}, {-41, 5}}, color = {0, 0, 127}));
  connect(flight2Fluid1.port_fluidAmb, wing.port_amb) annotation(
    Line(points = {{-30, 20}, {-30, 32}, {13, 32}, {13, 20}}, color = {0, 127, 255}));
  annotation(
    Icon(coordinateSystem(initialScale = 0.05)),
    Diagram(coordinateSystem(initialScale = 0.05)),
  experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-6, Interval = 0.002),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));

end WingSimple00_test01;
