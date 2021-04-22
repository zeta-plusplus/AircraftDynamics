within AircraftDynamics.RigidBodyFDM.Examples.sampleAircrafts;

model SimpleLTISS_ex01
  extends Modelica.Icons.Example;
  /* **********
  ***** Longitudinal *****
  A=[
  -0.023564,41.0074,0,-32.2;
  -0.000241,-1.296,0.9846,0;
  0.00020571,-3.5094,-2.4142,0;
  0,0,1,0],
  B=[
  0.0,0.0;
  -0.0821,0.0;
  -15.7002,0.0;
  0.0,0.0],
  -----
  A=[
  -0.0453,0.0363,0,-0.1830;
  -0.3717,-2.0354,0.9723,-0.0323;
  0.3398,-7.0301,-2.9767,0.0295;
  0,0,1,0],
  B=[
  0,0;
  -0.1609,0;
  -11.8674,0;
  0,0],
  ----------
  ***** Lateral ******
  A=[
  -0.2356,-0.0006,-0.9967,0.0551;
  -60.0566,-4.9625,3.8814,0;
  13.1748,0.0309,-0.4081,0;
  0,1,0.0157,0],
  B=[
  0,0.0066;
  56.7314,26.6886;
  0.9937,-9.6945;
  0,0],
  -----
  ********** */
  Modelica.Blocks.Continuous.StateSpace LTISS_Longitudinal(
  A=[
  -0.023564,41.0074,0,-32.2;
  -0.000241,-1.296,0.9846,0;
  0.00020571,-3.5094,-2.4142,0;
  0,0,1,0],
  B=[
  0.0,0.0;
  -0.0821,0.0;
  -15.7002,0.0;
  0.0,0.0],
  C = [1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1], initType = Modelica.Blocks.Types.Init.InitialState) annotation(
    Placement(visible = true, transformation(origin = {10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg2 annotation(
    Placement(visible = true, transformation(origin = {-30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.StateSpace LTISS_Lateral(
  A=[
  -0.2356,-0.0006,-0.9967,0.0551;
  -60.0566,-4.9625,3.8814,0;
  13.1748,0.0309,-0.4081,0;
  0,1,0.0157,0],
  B=[
  0,0.0066;
  56.7314,26.6886;
  0.9937,-9.6945;
  0,0],
  C = [1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]) annotation(
    Placement(visible = true, transformation(origin = {10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg3 annotation(
    Placement(visible = true, transformation(origin = {-30, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaE(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then -3 elseif 7 <= time and time <= 8 then 3
   elseif 31 <= time then 0 else 0)  annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaFracT(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then 0
   elseif 30 <= time and time <= 31 then 0
   elseif 31 <= time then 0 else 0) annotation(
    Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaA(y = if 2 <= time and time <= 3 then 0 elseif 22 <= time and time <= 23 then 0 else 0) annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaR(y = if 2 <= time and time <= 3 then -6 elseif 22 <= time and time <= 23 then 6 else 0) annotation(
    Placement(visible = true, transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg alpha_to_deg annotation(
    Placement(visible = true, transformation(origin = {50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg q_to_deg annotation(
    Placement(visible = true, transformation(origin = {50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg theta_to_deg annotation(
    Placement(visible = true, transformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg beta_to_deg annotation(
    Placement(visible = true, transformation(origin = {50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg p_to_deg annotation(
    Placement(visible = true, transformation(origin = {74, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg r_to_deg annotation(
    Placement(visible = true, transformation(origin = {50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg phi_to_deg annotation(
    Placement(visible = true, transformation(origin = {74, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {-30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(gain1.y, LTISS_Longitudinal.u[2]) annotation(
    Line(points = {{-18, 40}, {-10, 40}, {-10, 70}, {-2, 70}, {-2, 70}}, color = {0, 0, 127}));
  connect(uSignal_deltaFracT.y, gain1.u) annotation(
    Line(points = {{-58, 40}, {-42, 40}, {-42, 40}, {-42, 40}}, color = {0, 0, 127}));
  connect(LTISS_Lateral.y[4], phi_to_deg.u) annotation(
    Line(points = {{22, -10}, {26, -10}, {26, -70}, {62, -70}, {62, -70}}, color = {0, 0, 127}));
  connect(LTISS_Lateral.y[2], p_to_deg.u) annotation(
    Line(points = {{22, -10}, {34, -10}, {34, -30}, {62, -30}}, color = {0, 0, 127}));
  connect(LTISS_Lateral.y[3], r_to_deg.u) annotation(
    Line(points = {{22, -10}, {30, -10}, {30, -50}, {38, -50}, {38, -50}}, color = {0, 0, 127}));
  connect(LTISS_Lateral.y[1], beta_to_deg.u) annotation(
    Line(points = {{22, -10}, {38, -10}, {38, -10}, {38, -10}}, color = {0, 0, 127}));
  connect(LTISS_Longitudinal.y[4], theta_to_deg.u) annotation(
    Line(points = {{22, 70}, {30, 70}, {30, 30}, {38, 30}, {38, 30}}, color = {0, 0, 127}));
  connect(LTISS_Longitudinal.y[3], q_to_deg.u) annotation(
    Line(points = {{22, 70}, {32, 70}, {32, 60}, {38, 60}, {38, 60}}, color = {0, 0, 127}));
  connect(LTISS_Longitudinal.y[2], alpha_to_deg.u) annotation(
    Line(points = {{22, 70}, {24, 70}, {24, 90}, {38, 90}}, color = {0, 0, 127}));
  connect(uSignal_deltaA.y, from_deg2.u) annotation(
    Line(points = {{-59, -10}, {-43, -10}, {-43, -10}, {-43, -10}}, color = {0, 0, 127}));
  connect(from_deg2.y, LTISS_Lateral.u[1]) annotation(
    Line(points = {{-19, -10}, {-3, -10}, {-3, -10}, {-3, -10}}, color = {0, 0, 127}));
  connect(from_deg3.y, LTISS_Lateral.u[2]) annotation(
    Line(points = {{-19, -40}, {-9, -40}, {-9, -10}, {-3, -10}, {-3, -10}}, color = {0, 0, 127}));
  connect(uSignal_deltaR.y, from_deg3.u) annotation(
    Line(points = {{-59, -40}, {-45, -40}, {-45, -40}, {-43, -40}}, color = {0, 0, 127}));
  connect(uSignal_deltaE.y, from_deg1.u) annotation(
    Line(points = {{-59, 70}, {-42, 70}}, color = {0, 0, 127}));
  connect(from_deg1.y, LTISS_Longitudinal.u[1]) annotation(
    Line(points = {{-18, 70}, {-2, 70}, {-2, 70}, {-2, 70}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 120, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
  Diagram,
  __OpenModelica_commandLineOptions = "");

end SimpleLTISS_ex01;
