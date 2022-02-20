within AircraftDynamics.RigidBodyFDM.Examples.sampleAircrafts;

model Drone4rotor00_ex02
  extends Modelica.Icons.Example;
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-50, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.PropRotorActuatorDisk00 rotor1(diam_par = 0.5, vectPosIF_par = {0.5, -0.5, 0}, vectThrustDir_par = {0, 0, -1}) annotation(
    Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  AircraftDynamics.RigidBodyFDM.Components.Aircraft_RigidBody6DoF00 airplaneDyn(ZG_init_par = 0, nSrcForceMoment = 6, p_init_par = 0 * Modelica.Constants.pi / 180, phi_init_par(displayUnit = "rad"), q(fixed = true), q_init_par = 0 * 1000 * Modelica.Constants.pi / 180, rCG_par = {0, 0, 0}, r_init_par = 0 * Modelica.Constants.pi / 180, theta_init_par = 0 * Modelica.Constants.pi) annotation(
    Placement(visible = true, transformation(origin = {-10, -10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  AircraftDynamics.Visualizers.AnimRigidBodyAircraft00 animAircraft(offset_r0 = {0, 0, 0}) annotation(
    Placement(visible = true, transformation(origin = {14, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.PropRotorActuatorDisk00 rotor2(diam_par = 0.5, thrustVectorEQrotationalVector = false, vectPosIF_par = {0.5, 0.5, 0}, vectThrustDir_par = {0, 0, -1}) annotation(
    Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.PropRotorActuatorDisk00 rotor3(diam_par = 0.5, thrustVectorEQrotationalVector = false, vectPosIF_par = {-0.5, -0.5, 0}, vectThrustDir_par = {0, 0, -1}) annotation(
    Placement(visible = true, transformation(origin = {-60, -60}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.PropRotorActuatorDisk00 rotor4(diam_par = 0.5, vectPosIF_par = {-0.5, 0.5, 0}, vectThrustDir_par = {0, 0, -1}) annotation(
    Placement(visible = true, transformation(origin = {60, -60}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.SourceConstantGravity srcGravity annotation(
    Placement(visible = true, transformation(origin = {-40, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.ArbitraryDamper00 linearResistance(dampL_par = 500, dampM_par = 500, dampN_par = 500, dampX_par = 200, dampY_par = 200, dampZ_par = 200)  annotation(
    Placement(visible = true, transformation(origin = {-130, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable uSignal_thrustLevel1(fileName = Modelica.Utilities.Files.loadResource("modelica://AircraftDynamics/RigidBodyFDM/Examples/sampleAircrafts/uSignals001_Drone4rotor00_ex02.txt"), tableName = "thrustLevel_rotor1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-130, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain thrustNominal1(k = environmentAircraftDynSim.gravity * airplaneDyn.mTot_par)  annotation(
    Placement(visible = true, transformation(origin = {-80, 55}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Blocks.Math.Gain thrustNominal2(k = environmentAircraftDynSim.gravity * airplaneDyn.mTot_par) annotation(
    Placement(visible = true, transformation(origin = {40, 55}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Blocks.Math.Gain thrustNominal3(k = environmentAircraftDynSim.gravity * airplaneDyn.mTot_par) annotation(
    Placement(visible = true, transformation(origin = {-80, -85}, extent = {{-5, -5}, {5, 5}}, rotation = 90)));
  Modelica.Blocks.Sources.CombiTimeTable uSignal_thrustLevel2(fileName = Modelica.Utilities.Files.loadResource("modelica://AircraftDynamics/RigidBodyFDM/Examples/sampleAircrafts/uSignals001_Drone4rotor00_ex02.txt"), tableName = "thrustLevel_rotor2", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain thrustNominal4(k = environmentAircraftDynSim.gravity * airplaneDyn.mTot_par) annotation(
    Placement(visible = true, transformation(origin = {40, -85}, extent = {{-5, -5}, {5, 5}}, rotation = 90)));
  Modelica.Blocks.Sources.CombiTimeTable uSignal_thrustLevel3(fileName = Modelica.Utilities.Files.loadResource("modelica://AircraftDynamics/RigidBodyFDM/Examples/sampleAircrafts/uSignals001_Drone4rotor00_ex02.txt"), tableName = "thrustLevel_rotor3", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-130, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable uSignal_thrustLevel4(fileName = Modelica.Utilities.Files.loadResource("modelica://AircraftDynamics/RigidBodyFDM/Examples/sampleAircrafts/uSignals001_Drone4rotor00_ex02.txt"), tableName = "thrustLevel_rotor4", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-10, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(uSignal_thrustLevel4.y[1], thrustNominal4.u) annotation(
    Line(points = {{2, -110}, {40, -110}, {40, -90}, {40, -90}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(uSignal_thrustLevel3.y[1], thrustNominal3.u) annotation(
    Line(points = {{-118, -110}, {-80, -110}, {-80, -90}, {-80, -90}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(thrustNominal4.y, rotor4.u_thrust) annotation(
    Line(points = {{40, -79.5}, {40, -66}, {58, -66}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(thrustNominal3.y, rotor3.u_thrust) annotation(
    Line(points = {{-80, -79.5}, {-80, -66}, {-62, -66}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(thrustNominal1.y, rotor1.u_thrust) annotation(
    Line(points = {{-80, 49}, {-80, 34}, {-62, 34}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(uSignal_thrustLevel1.y[1], thrustNominal1.u) annotation(
    Line(points = {{-118, 70}, {-80, 70}, {-80, 61}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(uSignal_thrustLevel2.y[1], thrustNominal2.u) annotation(
    Line(points = {{2, 70}, {40, 70}, {40, 61}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(thrustNominal2.y, rotor2.u_thrust) annotation(
    Line(points = {{40, 49.5}, {40, 34}, {58, 34}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(rotor3.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[3]) annotation(
    Line(points = {{-60, -70}, {-40, -70}, {-40, -11}}, color = {95, 95, 95}));
  connect(rotor4.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[4]) annotation(
    Line(points = {{60, -70}, {-26, -70}, {-26, -54}, {-40, -54}, {-40, -11}}, color = {95, 95, 95}));
  connect(airplaneDyn.inCntrSrcForceMoment[2], rotor2.outCntrSrcForceMoment) annotation(
    Line(points = {{-40, -11}, {-40, 30}, {60, 30}}, color = {95, 95, 95}));
  connect(rotor1.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[1]) annotation(
    Line(points = {{-60, 30}, {-60, -11}, {-40, -11}}, color = {95, 95, 95}));
  connect(airplaneDyn.VisInfoOut, animAircraft.VisInfoIn) annotation(
    Line(points = {{14, 20}, {14, 100}}, color = {95, 95, 95}, pattern = LinePattern.Dash));
  connect(linearResistance.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[6]) annotation(
    Line(points = {{-120, -30}, {-74, -30}, {-74, -11}, {-40, -11}}, color = {95, 95, 95}));
  connect(airplaneDyn.inCntrSrcForceMoment[5], srcGravity.outCntrSrcForceMoment) annotation(
    Line(points = {{-40, -11}, {-40, -120}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-08, Interval = 0.02),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-140, -140}, {140, 140}})));
end Drone4rotor00_ex02;
