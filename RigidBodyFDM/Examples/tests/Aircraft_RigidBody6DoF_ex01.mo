within AircraftDynamics.RigidBodyFDM.Examples.tests;

model Aircraft_RigidBody6DoF_ex01
  extends Modelica.Icons.Example;
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.Aircraft_RigidBody6DoF00 airplaneDyn( p_init_par = 0, q(fixed = true), q_init_par = 500 * Modelica.Constants.pi / 180) annotation(
    Placement(visible = true, transformation(origin = {20, 20}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources.SourceConstantGravity srcGravity annotation(
    Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Visualizers.AnimRigidBodyAircraft00 animAircraft(offset_r0 = {0, 0, -1000})  annotation(
    Placement(visible = true, transformation(origin = {80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(srcGravity.outCntrSrcForceMoment, airplaneDyn.inCntrSrcForceMoment[1]) annotation(
    Line(points = {{-30, -40}, {-30, 19}, {-20, 19}}, color = {95, 95, 95}));
  connect(airplaneDyn.VisInfoOut, animAircraft.VisInfoIn) annotation(
    Line(points = {{52, 60}, {52, 80}, {70, 80}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-07, Interval = 0.01));
end Aircraft_RigidBody6DoF_ex01;