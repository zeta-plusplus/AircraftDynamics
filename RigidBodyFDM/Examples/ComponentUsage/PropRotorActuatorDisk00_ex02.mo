within AircraftDynamics.RigidBodyFDM.Examples.ComponentUsage;

model PropRotorActuatorDisk00_ex02
  extends Modelica.Icons.Example;
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.PropRotorActuatorDisk00 rotor annotation(
    Placement(visible = true, transformation(origin = {-50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp thrust(duration = 10, height = 2000, offset = 0, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Aircraft_RigidBody6DoF00 airplaneDyn(ZG_init_par = 0,nSrcForceMoment = 3, p_init_par = 0 * Modelica.Constants.pi / 180, phi_init_par(displayUnit = "rad"), q(fixed = true), q_init_par = 0 * 1000 * Modelica.Constants.pi / 180, rCG_par = {0, 0, 0}, r_init_par = 0 * Modelica.Constants.pi / 180, theta_init_par = 0 * Modelica.Constants.pi) annotation(
    Placement(visible = true, transformation(origin = {20, 20}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  AircraftDynamics.Visualizers.AnimRigidBodyAircraft00 animAircraft(offset_r0 = {0, 0, 0})  annotation(
    Placement(visible = true, transformation(origin = {80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.SourceConstantGravity srcGravity annotation(
    Placement(visible = true, transformation(origin = {-20, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.SourceArbitraryForceMoment00 forceMomentArbitrary(Zf_par = (-1.05) * environmentAircraftDynSim.gravity * airplaneDyn.mTot_par)  annotation(
    Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(thrust.y, rotor.u_thrust) annotation(
    Line(points = {{-79, 50}, {-44, 50}, {-44, 22}}, color = {0, 0, 127}));
  connect(rotor.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[1]) annotation(
    Line(points = {{-40, 20}, {-20, 20}}, color = {95, 95, 95}));
  connect(airplaneDyn.VisInfoOut, animAircraft.VisInfoIn) annotation(
    Line(points = {{52, 60}, {52, 80}, {70, 80}}, color = {95, 95, 95}));
  connect(srcGravity.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[2]) annotation(
    Line(points = {{-20, -60}, {-20, 20}}, color = {95, 95, 95}));
  connect(forceMomentArbitrary.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[3]) annotation(
    Line(points = {{-50, -40}, {-20, -40}, {-20, 20}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-08, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", variableFilter = ".*"));
end PropRotorActuatorDisk00_ex02;
