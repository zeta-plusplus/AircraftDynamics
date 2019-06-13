within AircraftDynamics.PtMassFDM.DoF2.Examples.tests;

model testPtMass001
  extends Modelica.Icons.Example;
  AircraftDynamics.PtMassFDM.DoF2.Interfaces.PtMass ptMass1(nIn_thrusts = 2)  annotation(
    Placement(visible = true, transformation(origin = { 0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 2)  annotation(
    Placement(visible = true, transformation(origin = {-70, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const3.y, ptMass1.u_drags[1]) annotation(
    Line(points = {{42, 50}, {48, 50}, {48, 10}, {10, 10}, {10, 10}}, color = {0, 0, 127}));
  connect(const2.y, ptMass1.u_thrusts[2]) annotation(
    Line(points = {{-58, -20}, {-46, -20}, {-46, 10}, {-10, 10}, {-10, 10}}, color = {0, 0, 127}));
  connect(const1.y, ptMass1.u_thrusts[1]) annotation(
    Line(points = {{-58, 10}, {-10, 10}, {-10, 10}, {-10, 10}}, color = {0, 0, 127}));
  connect(const.y, ptMass1.u_lifts[1]) annotation(
    Line(points = {{-18, 50}, {0, 50}, {0, 20}, {0, 20}}, color = {0, 0, 127}));
end testPtMass001;
