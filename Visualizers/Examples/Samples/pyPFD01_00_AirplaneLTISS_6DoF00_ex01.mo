within AircraftDynamics.Visualizers.Examples.Samples;

model pyPFD01_00_AirplaneLTISS_6DoF00_ex01
  extends Modelica.Icons.Example;
  //-----
  //package surrFluid = Modelica.Media.Air.DryAirNasa;
  package surrFluid = AircraftDynamics.Media.DryAirMethaneMixture00;
  //redeclare package Medium = surrFluid
  //-----
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-20, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-50, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg2 annotation(
    Placement(visible = true, transformation(origin = {-20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.AirplaneLTISS_6DoF00 AirplaneDyn(redeclare package Medium = surrFluid) annotation(
    Placement(visible = true, transformation(origin = {50, -10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg3 annotation(
    Placement(visible = true, transformation(origin = {-20, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_Tnominal(k = AirplaneDyn.m_par * 9.81 * 0.2) annotation(
    Placement(visible = true, transformation(origin = {-20, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Visualizers.interactive_pyPFD01_00 pyPFD(tInterval = 0.02)  annotation(
    Placement(visible = true, transformation(origin = {100, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.OperatingSystem.SynchronizeRealtime synchronizeRealtime1(enable = true) annotation(
    Placement(visible = true, transformation(origin = {50, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  InteractiveSimulation.Input.AccumulateDigitalInputSignal01 Accumulate1(scl = -1) annotation(
    Placement(visible = true, transformation(origin = {-140, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  InteractiveSimulation.Input.AccumulateDigitalInputSignal01 Accumulate(scl = 1)  annotation(
    Placement(visible = true, transformation(origin = {-140, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_deltaE annotation(
    Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardInput keyboardInput1 annotation(
    Placement(visible = true, transformation(origin = {-190, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  InteractiveSimulation.Input.AccumulateDigitalInputSignal01 accumulate(scl = 1) annotation(
    Placement(visible = true, transformation(origin = {-142, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  InteractiveSimulation.Input.AccumulateDigitalInputSignal01 accumulate1(scl = -1) annotation(
    Placement(visible = true, transformation(origin = {-142, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_deltaA annotation(
    Placement(visible = true, transformation(origin = {-102, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardKeyInput keyboardKeyInput_f(keyCode = "1")  annotation(
    Placement(visible = true, transformation(origin = {-212, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  InteractiveSimulation.Input.AccumulateDigitalInputSignal01 accumulate2(scl = 0.1, varInit = 0.6) annotation(
    Placement(visible = true, transformation(origin = {-160, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  InteractiveSimulation.Input.AccumulateDigitalInputSignal01 accumulate3(scl = -0.1, varInit = 0) annotation(
    Placement(visible = true, transformation(origin = {-160, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_fracT annotation(
    Placement(visible = true, transformation(origin = {-110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardKeyInput keyboardKeyInput_v(keyCode = "2") annotation(
    Placement(visible = true, transformation(origin = {-212, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardKeyInput keyboardKeyInput(keyCode = "4") annotation(
    Placement(visible = true, transformation(origin = {-210, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardKeyInput keyboardKeyInput1(keyCode = "3") annotation(
    Placement(visible = true, transformation(origin = {-210, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  InteractiveSimulation.Input.AccumulateDigitalInputSignal01 accumulate4(scl = 1) annotation(
    Placement(visible = true, transformation(origin = {-160, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_deltaR annotation(
    Placement(visible = true, transformation(origin = {-120, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  InteractiveSimulation.Input.AccumulateDigitalInputSignal01 accumulate5(scl = -1) annotation(
    Placement(visible = true, transformation(origin = {-160, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  InteractiveSimulation.Output.dispVarPyConsole02_00 dispVarPyConsole(nVariables = 4, namePythonPath = "C:\Program Files\Python310", nameVariables = {"deltaE[deg]", "fracT[nond]", "deltaA[deg]", "deltaR[deg]"}) annotation(
    Placement(visible = true, transformation(origin = {-36, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(from_deg3.y, AirplaneDyn.u_deltaR) annotation(
    Line(points = {{-9, -70}, {11, -70}, {11, -20}, {18, -20}}, color = {0, 0, 127}));
  connect(from_deg2.y, AirplaneDyn.u_deltaA) annotation(
    Line(points = {{-9, -30}, {7, -30}, {7, -13}, {18, -13}}, color = {0, 0, 127}));
  connect(gain_Tnominal.y, AirplaneDyn.u_deltaT) annotation(
    Line(points = {{-9, 10}, {9, 10}, {9, -3}, {18, -3}}, color = {0, 0, 127}));
  connect(from_deg1.y, AirplaneDyn.u_deltaE) annotation(
    Line(points = {{-9, 50}, {11, 50}, {11, 3}, {18, 3}}, color = {0, 0, 127}));
  connect(AirplaneDyn.VisInfoOut, pyPFD.VisInfoIn) annotation(
    Line(points = {{77, 20}, {77, 50}, {90, 50}}, color = {95, 95, 95}));
  connect(keyboardInput1.keyUp, Accumulate.u) annotation(
    Line(points = {{-179, 86}, {-161, 86}, {-161, 90}, {-153, 90}}, color = {255, 0, 255}));
  connect(Accumulate1.y, add_deltaE.u2) annotation(
    Line(points = {{-129, 60}, {-123, 60}, {-123, 74}, {-113, 74}}, color = {0, 0, 127}));
  connect(Accumulate.y, add_deltaE.u1) annotation(
    Line(points = {{-129, 90}, {-127, 90}, {-127, 86}, {-113, 86}}, color = {0, 0, 127}));
  connect(keyboardInput1.keyDown, Accumulate1.u) annotation(
    Line(points = {{-190, 69}, {-190, 60}, {-152, 60}}, color = {255, 0, 255}));
  connect(add_deltaE.y, from_deg1.u) annotation(
    Line(points = {{-89, 80}, {-65, 80}, {-65, 50}, {-32, 50}}, color = {0, 0, 127}));
  connect(accumulate.y, add_deltaA.u1) annotation(
    Line(points = {{-130, -20}, {-124, -20}, {-124, -24}, {-114, -24}}, color = {0, 0, 127}));
  connect(accumulate1.y, add_deltaA.u2) annotation(
    Line(points = {{-130, -50}, {-124, -50}, {-124, -36}, {-114, -36}}, color = {0, 0, 127}));
  connect(add_deltaA.y, from_deg2.u) annotation(
    Line(points = {{-90, -30}, {-32, -30}}, color = {0, 0, 127}));
  connect(keyboardInput1.keyRight, accumulate.u) annotation(
    Line(points = {{-184, 69}, {-184, -20}, {-154, -20}}, color = {255, 0, 255}));
  connect(keyboardInput1.keyLeft, accumulate1.u) annotation(
    Line(points = {{-196, 69}, {-196, -50}, {-154, -50}}, color = {255, 0, 255}));
  connect(add_fracT.y, gain_Tnominal.u) annotation(
    Line(points = {{-98, 20}, {-64, 20}, {-64, 10}, {-32, 10}}, color = {0, 0, 127}));
  connect(accumulate2.y, add_fracT.u1) annotation(
    Line(points = {{-148, 32}, {-138, 32}, {-138, 26}, {-122, 26}}, color = {0, 0, 127}));
  connect(accumulate3.y, add_fracT.u2) annotation(
    Line(points = {{-148, 6}, {-134, 6}, {-134, 14}, {-122, 14}}, color = {0, 0, 127}));
  connect(keyboardKeyInput_f.keyState, accumulate2.u) annotation(
    Line(points = {{-200, 32}, {-172, 32}}, color = {255, 0, 255}));
  connect(keyboardKeyInput_v.keyState, accumulate3.u) annotation(
    Line(points = {{-200, 6}, {-172, 6}}, color = {255, 0, 255}));
  connect(accumulate4.y, add_deltaR.u1) annotation(
    Line(points = {{-148, -74}, {-142, -74}, {-142, -78}, {-132, -78}}, color = {0, 0, 127}));
  connect(accumulate5.y, add_deltaR.u2) annotation(
    Line(points = {{-148, -104}, {-144, -104}, {-144, -90}, {-132, -90}}, color = {0, 0, 127}));
  connect(add_deltaR.y, from_deg3.u) annotation(
    Line(points = {{-108, -84}, {-58, -84}, {-58, -70}, {-32, -70}}, color = {0, 0, 127}));
  connect(keyboardKeyInput1.keyState, accumulate4.u) annotation(
    Line(points = {{-198, -74}, {-172, -74}}, color = {255, 0, 255}));
  connect(keyboardKeyInput.keyState, accumulate5.u) annotation(
    Line(points = {{-199, -104}, {-172, -104}}, color = {255, 0, 255}));
  connect(add_deltaR.y, dispVarPyConsole.u_variables[4]) annotation(
    Line(points = {{-108, -84}, {-86, -84}, {-86, -110}, {-46, -110}}, color = {0, 0, 127}));
  connect(add_deltaA.y, dispVarPyConsole.u_variables[3]) annotation(
    Line(points = {{-90, -30}, {-76, -30}, {-76, -110}, {-46, -110}}, color = {0, 0, 127}));
  connect(add_fracT.y, dispVarPyConsole.u_variables[2]) annotation(
    Line(points = {{-98, 20}, {-68, 20}, {-68, -110}, {-46, -110}}, color = {0, 0, 127}));
  connect(add_deltaE.y, dispVarPyConsole.u_variables[1]) annotation(
    Line(points = {{-88, 80}, {-54, 80}, {-54, -110}, {-46, -110}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-260, -120}, {120, 120}})),
    __OpenModelica_commandLineOptions = "-d=initialization, --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600",
    experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end pyPFD01_00_AirplaneLTISS_6DoF00_ex01;
