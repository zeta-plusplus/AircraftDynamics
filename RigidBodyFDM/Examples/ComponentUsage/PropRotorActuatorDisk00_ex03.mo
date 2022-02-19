within AircraftDynamics.RigidBodyFDM.Examples.ComponentUsage;

model PropRotorActuatorDisk00_ex03
  extends Modelica.Icons.Example;
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-50, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.PropRotorActuatorDisk00 rotor1(diam_par = 0.5, vectPosIF_par = {1, -1, 0}, vectThrustDir_par = {0, 0, -1})  annotation(
    Placement(visible = true, transformation(origin = {-60, 50}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Sources.Ramp ramp_thrust1(duration = 10, height = 2000, offset = 0, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.Aircraft_RigidBody6DoF00 airplaneDyn(ZG_init_par = 0,nSrcForceMoment = 4, p_init_par = 0 * Modelica.Constants.pi / 180, phi_init_par(displayUnit = "rad"), q(fixed = true), q_init_par = 0 * 1000 * Modelica.Constants.pi / 180, rCG_par = {0, 0, 0}, r_init_par = 0 * Modelica.Constants.pi / 180, theta_init_par = 0 * Modelica.Constants.pi) annotation(
    Placement(visible = true, transformation(origin = {0, -20}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  AircraftDynamics.Visualizers.AnimRigidBodyAircraft00 animAircraft(offset_r0 = {0, 0, 0})  annotation(
    Placement(visible = true, transformation(origin = {32, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.PropRotorActuatorDisk00 rotor2(diam_par = 0.5, thrustVectorEQrotationalVector = false, vectPosIF_par = {1, 1, 0}, vectThrustDir_par = {0, 0, -1}) annotation(
    Placement(visible = true, transformation(origin = {60, 50}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.PropRotorActuatorDisk00 rotor3(diam_par = 0.5, thrustVectorEQrotationalVector = false, vectPosIF_par = {-1, -1, 0}, vectThrustDir_par = {0, 0, -1})  annotation(
    Placement(visible = true, transformation(origin = {-60, -80}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.PropRotorActuatorDisk00 rotor(diam_par = 0.5, vectPosIF_par = {-1, 1, 0}, vectThrustDir_par = {0, 0, -1})  annotation(
    Placement(visible = true, transformation(origin = {60, -80}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Sources.Ramp ramp_thrust2(duration = 5, height = -2000, offset = 0, startTime = 15) annotation(
    Placement(visible = true, transformation(origin = {-10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_thrust3(duration = 5, height = -2000, offset = 0, startTime = 15) annotation(
    Placement(visible = true, transformation(origin = {-110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_thrust4(duration = 10, height = 2000, offset = 0, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {20, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(airplaneDyn.VisInfoOut, animAircraft.VisInfoIn) annotation(
    Line(points = {{32, 20}, {32, 80}}, color = {95, 95, 95}));
  connect(rotor1.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[1]) annotation(
    Line(points = {{-60, 40}, {-60, -21}, {-40, -21}}, color = {95, 95, 95}));
  connect(ramp_thrust1.y, rotor1.u_thrust) annotation(
    Line(points = {{-99, 50}, {-74, 50}, {-74, 44}, {-62, 44}}, color = {0, 0, 127}));
  connect(airplaneDyn.inCntrSrcForceMoment[2], rotor2.outCntrSrcForceMoment) annotation(
    Line(points = {{-40, -20}, {-40, 32}, {60, 32}, {60, 40}}, color = {95, 95, 95}));
  connect(rotor3.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[3]) annotation(
    Line(points = {{-60, -90}, {-40, -90}, {-40, -20}}, color = {95, 95, 95}));
  connect(rotor.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[4]) annotation(
    Line(points = {{60, -90}, {-26, -90}, {-26, -54}, {-40, -54}, {-40, -20}}, color = {95, 95, 95}));
  connect(ramp_thrust2.y, rotor2.u_thrust) annotation(
    Line(points = {{2, 70}, {20, 70}, {20, 44}, {58, 44}}, color = {0, 0, 127}));
  connect(ramp_thrust3.y, rotor3.u_thrust) annotation(
    Line(points = {{-98, -90}, {-74, -90}, {-74, -86}, {-62, -86}}, color = {0, 0, 127}));
  connect(ramp_thrust4.y, rotor.u_thrust) annotation(
    Line(points = {{32, -110}, {44, -110}, {44, -86}, {58, -86}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-08, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
  Diagram(coordinateSystem(extent = {{-140, -140}, {140, 140}})));
end PropRotorActuatorDisk00_ex03;
