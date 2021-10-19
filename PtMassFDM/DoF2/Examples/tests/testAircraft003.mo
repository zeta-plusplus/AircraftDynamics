within AircraftDynamics.PtMassFDM.DoF2.Examples.tests;

model testAircraft003
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
  Modelica.Blocks.Sources.Ramp ramp_dm_fuel(duration = 5, height = 0.2, offset = 0.1, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain2(k = 1 / 5)  annotation(
    Placement(visible = true, transformation(origin = {10, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  package subcomponents
    model eng
    package engineAir = Modelica.Media.Air.DryAirNasa;
      //-----
      inner PropulsionSystem.EngineSimEnvironment environment annotation(
        Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
      PropulsionSystem.Elements.BasicElements.FlightToEngine flightToEngine1(redeclare package Medium = engineAir, MN = 0, alt = 0) annotation(
        Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PropulsionSystem.Elements.BasicElements.Inlet Inlt010(redeclare package Medium = engineAir) annotation(
        Placement(visible = true, transformation(origin = {-60, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PropulsionSystem.Elements.BasicElements.Duct Duct030(redeclare package Medium = engineAir, dPqPdes = 0.02) annotation(
        Placement(visible = true, transformation(origin = {40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PropulsionSystem.Elements.BasicElements.HeatInjector Brn036(redeclare package Medium = engineAir, TtOutletDes(displayUnit = "K") = 1600, switchInput_TtOutlet = PropulsionSystem.Types.switches.switch_parameter_input.asCalculated) annotation(
        Placement(visible = true, transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PropulsionSystem.Elements.BasicElements.CombustFuel combustFuel1(dm_fuel_des = 0.1, switchCausality_dq = PropulsionSystem.Elements.BasicElements.CombustFuel.switchCausality_GeneratedHeat.input_dmFuel, switchInput_dm_fuel = PropulsionSystem.Types.switches.switch_parameter_input.use_inputSignal) annotation(
        Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PropulsionSystem.Elements.BasicElements.Duct Duct045(redeclare package Medium = engineAir, dPqPdes = 0.03) annotation(
        Placement(visible = true, transformation(origin = {140, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PropulsionSystem.Elements.BasicElements.NozzleConv_defAmech Nzl070(redeclare package Medium = engineAir, Amech_th_def = 0.0195384) annotation(
        Placement(visible = true, transformation(origin = {170, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PropulsionSystem.Elements.BasicElements.EnginePerformance perf001 annotation(
        Placement(visible = true, transformation(origin = {210, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //-----
      PropulsionSystem.Elements.BasicElements.Turbine_Map_WcEff Trb041(redeclare package Medium = engineAir, PRdes = 2.42403, Tdes_1(displayUnit = "K") = 1600, dmDes_1 = 10, effDes = 0.9, pDes_1 = 754659, pathName_tableFile = "./tableData/table_Trb_PR_NcqNcDes_001.txt", switchDef_NcDes_1 = PropulsionSystem.Types.switches.switch_defineDesValue.calcByDesStates, switchDef_WcDes_1 = PropulsionSystem.Types.switches.switch_defineDesValue.calcByDesStates, switchDef_s_PR_CurveDes = PropulsionSystem.Types.switches.switch_defineDesValue.calcByDesStates, switchDef_s_Wc_CurveDes = PropulsionSystem.Types.switches.switch_defineDesValue.calcByDesStates, switchDef_s_eff_CurveDes = PropulsionSystem.Types.switches.switch_defineDesValue.calcByDesStates, switchInput_PR = PropulsionSystem.Types.switches.switch_parameter_input.calc_Subelement, switchInput_Wc_1 = PropulsionSystem.Types.switches.switch_parameter_input.calc_Subelement, switchInput_eff = PropulsionSystem.Types.switches.switch_parameter_input.calc_Subelement, switchSmoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, switchUseMapDataFile_Wc = true, switchUseMapDataFile_eff = true) annotation(
        Placement(visible = true, transformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PropulsionSystem.Elements.BasicElements.Compressor_Map_WcPReff Cmp020(redeclare package Medium = engineAir, PRdes = 8, Tdes_1(displayUnit = "K") = 288.16, pDes_1 = 96257.5, pathName_tableFile = "./tableData/table_Cmp_theta_NcqNcDes_001.txt", switchSmoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, switchUseMapDataFile_PR = true, switchUseMapDataFile_Wc = true, switchUseMapDataFile_eff = true, thetaCurveDes = 3.14 / 4) annotation(
        Placement(visible = true, transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Components.Inertia ShM(J = 500, a(fixed = true, start = 0), w(fixed = false)) annotation(
        Placement(visible = true, transformation(origin = {60, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_dm_fuel annotation(
        Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_Fn annotation(
        Placement(visible = true, transformation(origin = {270, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(perf001.y_Fn, y_Fn) annotation(
        Line(points = {{222, -84}, {232, -84}, {232, 10}, {270, 10}, {270, 10}}, color = {0, 0, 127}));
      connect(combustFuel1.dm_fuel_out, perf001.u_m_flow_fuel) annotation(
        Line(points = {{62, -4}, {86, -4}, {86, -98}, {200, -98}, {200, -98}}, color = {0, 0, 127}));
      connect(Nzl070.Fg_out, perf001.u_Fg) annotation(
        Line(points = {{176, -30}, {188, -30}, {188, -82}, {200, -82}, {200, -82}}, color = {0, 0, 127}));
      connect(Inlt010.Fram_out, perf001.u_Fram) annotation(
        Line(points = {{-52, -34}, {-46, -34}, {-46, -86}, {200, -86}, {200, -86}}, color = {0, 0, 127}));
      connect(flightToEngine1.V_tot_out, Inlt010.V_tot_in) annotation(
        Line(points = {{-79, -34}, {-67, -34}}, color = {0, 0, 127}));
      connect(flightToEngine1.port_fluid2Eng, Inlt010.port_1) annotation(
        Line(points = {{-80, -22}, {-70, -22}}, color = {0, 127, 255}));
      connect(Inlt010.port_2, Cmp020.port_1) annotation(
        Line(points = {{-50, -22}, {-42, -22}}, color = {0, 127, 255}));
      connect(flightToEngine1.port_fluidAmb, Nzl070.port_2) annotation(
        Line(points = {{-90, -20}, {-90, 22}, {182, 22}, {182, -22}}, color = {0, 127, 255}));
      connect(Cmp020.flange_2, ShM.flange_a) annotation(
        Line(points = {{-22, -30}, {-16, -30}, {-16, -60}, {50, -60}}));
      connect(Cmp020.port_2, Duct030.port_1) annotation(
        Line(points = {{-22, -22}, {30, -22}, {30, -22}, {30, -22}}, color = {0, 127, 255}));
      connect(combustFuel1.dm_fuel_out, perf001.dm_fuel_in) annotation(
        Line(points = {{61, -4}, {185, -4}, {185, -96}, {199, -96}}, color = {0, 0, 127}));
      connect(Duct045.port_2, Nzl070.port_1) annotation(
        Line(points = {{150, -22}, {158, -22}}, color = {0, 127, 255}));
      connect(Trb041.port_2, Duct045.port_1) annotation(
        Line(points = {{120, -22}, {128, -22}}, color = {0, 127, 255}));
      connect(ShM.flange_b, Trb041.flange_1) annotation(
        Line(points = {{70, -60}, {94, -60}, {94, -30}, {100, -30}, {100, -30}}));
      connect(Brn036.port_2, Trb041.port_1) annotation(
        Line(points = {{80, -22}, {100, -22}}, color = {0, 127, 255}));
      connect(Duct030.port_2, Brn036.port_1) annotation(
        Line(points = {{50, -22}, {60, -22}}, color = {0, 127, 255}));
      connect(combustFuel1.HeatPort_b, Brn036.HeatPort_1) annotation(
        Line(points = {{60, 0}, {70, 0}, {70, -20}}, color = {191, 0, 0}));
      annotation(
        uses(Modelica(version = "3.2.2")),
        Diagram(coordinateSystem(extent = {{-100, -100}, {260, 100}}), graphics = {Rectangle(origin = {55, -15}, pattern = LinePattern.Dash, extent = {{-29, 27}, {35, -31}}), Text(origin = {40, 17}, extent = {{-18, 2}, {4, -2}}, textString = "Combustor")}),
        Icon(graphics = {Text(origin = {0, -36}, extent = {{-100, 8}, {100, -12}}, textString = "%name"), Polygon(origin = {-47, 1}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-13, 19}, {-13, -21}, {27, -11}, {27, 9}, {-13, 19}}), Polygon(origin = {36, 0}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, points = {{-16, 10}, {-16, -10}, {4, -20}, {4, 20}, {-16, 10}}), Rectangle(origin = {0, -1}, fillPattern = FillPattern.Solid, extent = {{-20, 5}, {20, -3}}), Rectangle(origin = {2, 5}, extent = {{-92, 17}, {98, -27}}), Ellipse(origin = {-2, 14}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-12, 6}, {12, -6}}, endAngle = 360), Polygon(origin = {-75, 2}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-9, 12}, {-9, -16}, {9, -22}, {9, 18}, {-9, 12}}), Polygon(origin = {55, 2}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, points = {{-9, 18}, {-9, -22}, {25, -14}, {25, 10}, {-9, 18}}), Line(origin = {-53, 29}, points = {{-47, 11}, {47, 11}, {47, -11}}, thickness = 1)}),
        version = "",
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.04),
        __OpenModelica_simulationFlags(lv = "assert,LOG_STATS", s = "dassl", cpu = "()", outputFormat = "mat"));
    
    end eng;
    extends Modelica.Icons.Package;
  end subcomponents;

  AircraftDynamics.PtMassFDM.DoF2.Examples.tests.testAircraft003.subcomponents.eng eng annotation(
    Placement(visible = true, transformation(origin = {-40, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(gain1.y, aircraftMassCenter1.InfoBus1.alphaCmd) annotation(
    Line(points = {{-49, -170}, {52, -170}, {52, -40}}, color = {255, 170, 0}));
  connect(gain2.y, aircraftMassCenter1.u_FxForward[1]) annotation(
    Line(points = {{22, -100}, {36, -100}, {36, -10}, {46, -10}, {46, -10}}, color = {0, 0, 127}));
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
  connect(eng.y_Fn, gain2.u) annotation(
    Line(points = {{-18, -100}, {-2, -100}, {-2, -100}, {-2, -100}}, color = {0, 0, 127}));
  connect(ramp_dm_fuel.y, eng.u_dm_fuel) annotation(
    Line(points = {{-78, -70}, {-72, -70}, {-72, -92}, {-62, -92}, {-62, -92}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-100, -200}, {180, 100}}, initialScale = 0.1), graphics = {Text(origin = {-85, -153}, extent = {{-13, 3}, {13, -3}}, textString = "AoA to be sustained")}),
    Icon(coordinateSystem(extent = {{-100, -120}, {140, 100}})),
    __OpenModelica_commandLineOptions = "");

end testAircraft003;
