within AircraftDynamics.RigidBodyFDM.Examples.ComponentUsage;

model SourceArbitraryForceMoment_ex02
  extends Modelica.Icons.Example;
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.Aircraft_RigidBody6DoF00 airplaneDyn( nSrcForceMoment = 3, p_init_par = 0 * Modelica.Constants.pi / 180, phi_init_par(displayUnit = "rad"), q(fixed = true), q_init_par = 0 * 1000 * Modelica.Constants.pi / 180, r_init_par = 0 * Modelica.Constants.pi / 180, theta_init_par = 0 * Modelica.Constants.pi) annotation(
    Placement(visible = true, transformation(origin = {20, 20}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  AircraftDynamics.Visualizers.AnimRigidBodyAircraft00 animAircraft(offset_r0 = {0, 0, -1000}) annotation(
    Placement(visible = true, transformation(origin = {80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.SourceArbitraryForceMoment00 forceMomentArbitrary(M_par = 0 * 1000, Zf_par =  (-1.1) * environmentAircraftDynSim.gravity * airplaneDyn.mTot_par) annotation(
    Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.SourceConstantGravity srcGravity annotation(
    Placement(visible = true, transformation(origin = {-30, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.SourceArbitraryForceMoment00 forceMomentArbitrary1(M_par = 0 * 1000, Xf_par = 0.2 * environmentAircraftDynSim.gravity * airplaneDyn.mTot_par, Zf_par = 0 * environmentAircraftDynSim.gravity * airplaneDyn.mTot_par) annotation(
    Placement(visible = true, transformation(origin = {-60, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(airplaneDyn.VisInfoOut, animAircraft.VisInfoIn) annotation(
    Line(points = {{52, 60}, {52, 80}, {70, 80}}, color = {95, 95, 95}));
  connect(forceMomentArbitrary.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[1]) annotation(
    Line(points = {{-60, 20}, {-20, 20}}, color = {95, 95, 95}));
  connect(srcGravity.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[2]) annotation(
    Line(points = {{-30, -30}, {-30, 20}, {-20, 20}}, color = {95, 95, 95}));
  connect(forceMomentArbitrary1.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[3]) annotation(
    Line(points = {{-50, 50}, {-20, 50}, {-20, 20}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-08, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end SourceArbitraryForceMoment_ex02;
