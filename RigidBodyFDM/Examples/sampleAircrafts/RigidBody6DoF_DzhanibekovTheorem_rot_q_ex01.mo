within AircraftDynamics.RigidBodyFDM.Examples.sampleAircrafts;

model RigidBody6DoF_DzhanibekovTheorem_rot_q_ex01
  extends Modelica.Icons.Example;
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.Aircraft_RigidBody6DoF00 airplaneDyn(Ixx_par = 100, Iyy_par = 1000, Izz_par = 10000,nSrcForceMoment = 0,p_init_par = 0.001 * Modelica.Constants.pi, phi_init_par(displayUnit = "deg"), q(fixed = true), q_init_par = 1 * Modelica.Constants.pi, r_init_par = 0.001 * Modelica.Constants.pi, theta_init_par(displayUnit = "rad") = 0) annotation(
    Placement(visible = true, transformation(origin = {20, 20}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  AircraftDynamics.Visualizers.AnimRigidBodyAircraftAttitude00 animAircraft1 annotation(
    Placement(visible = true, transformation(origin = {80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(airplaneDyn.VisInfoOut, animAircraft1.VisInfoIn) annotation(
    Line(points = {{52, 60}, {52, 80}, {70, 80}}, color = {95, 95, 95}));
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-05, Interval = 0.001));
end RigidBody6DoF_DzhanibekovTheorem_rot_q_ex01;
