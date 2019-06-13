within AircraftDynamics.PtMassFDM.DoF2.Interfaces;

model PtMass
  //----- imports -----
  import Modelica.Constants;
  
  /********************************************************
     Declaration
  ********************************************************/
  //********** Parameters **********
  parameter Integer nIn_lifts = 1 
    "Number of lift inputs"
    annotation(
    Dialog(group = "Port setting"));
  parameter Integer nIn_thrusts= 1
    "Number of thrust inputs"
    annotation(
    Dialog(group = "Port setting"));
  parameter Integer nIn_drags= 1
    "Number of drag inputs"
    annotation(
    Dialog(group = "Port setting"));
  parameter Integer nIn_masses= 0
    "Number of mass(weight) inputs"
    annotation(
    Dialog(group = "Port setting"));
  //********** Internal variables **********
  Modelica.SIunits.Force sum_u_lifts;
  Modelica.SIunits.Force sum_u_thrusts;
  Modelica.SIunits.Force sum_u_drags;
  Modelica.SIunits.Mass sum_u_masses;
  //********** Interfaces **********
  Modelica.Blocks.Interfaces.RealVectorInput u_drags[nIn_drags] annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 1}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput u_thrusts[nIn_thrusts] annotation(
    Placement(visible = true, transformation(origin = {-100, 1.77636e-15}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 8.88178e-16}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput u_lifts[nIn_lifts] annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput u_masses[nIn_masses] annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus busFltStates1 annotation(
    Placement(visible = true, transformation(origin = { -70, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  //********** Parameters **********
  parameter Real k_lifts[nIn_lifts]=ones(nIn_lifts) "sum coefficients, all 1";
  parameter Real k_thrusts[nIn_thrusts]=ones(nIn_thrusts) "sum coefficients, all 1";
  parameter Real k_drags[nIn_drags]=ones(nIn_drags) "sum coefficients, all 1";
  parameter Real k_masses[nIn_masses]=ones(nIn_masses) "sum coefficients, all 1";
  
  //********** objects **********
  outer Modelica.Mechanics.MultiBody.World world;
equation
  sum_u_lifts= k_lifts*u_lifts;
  sum_u_thrusts= k_thrusts*u_thrusts;
  sum_u_drags= k_drags*u_drags;
  sum_u_masses= k_masses*u_masses;
end PtMass;
