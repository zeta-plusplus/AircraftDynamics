within AircraftDynamics.PtMassFDM.DoF2.Interfaces;

model PtMass
  //----- imports -----
  import Modelica.Constants;
  
  /********************************************************
     Declaration
  ********************************************************/
  //********** Parameters **********
  parameter Integer nIn_lifts = 1 "Number of lift inputs";
  parameter Integer nIn_thrusts= 1 "Number of thrust inputs";
  parameter Integer nIn_drags= 1 "Number of drag inputs";
  parameter Integer nIn_masses= 0 "Number of mass(weight) inputs";
  
  
  
  //********** Internal variables **********
  Real sum_u_lifts;
  Real sum_u_thrusts;
  Real sum_u_drags;
  Real sum_u_masses;
  
  //********** Interfaces **********
  Modelica.Blocks.Interfaces.RealVectorInput u_drags[nIn_drags] annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput u_thrusts[nIn_thrusts] annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput u_lifts[nIn_lifts] annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput u_masses[nIn_masses] annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
protected
  //********** Parameters **********
  parameter Real k_lifts[nIn_lifts]=ones(nIn_lifts) "sum coefficients, all 1";
  parameter Real k_thrusts[nIn_thrusts]=ones(nIn_thrusts) "sum coefficients, all 1";
  parameter Real k_drags[nIn_drags]=ones(nIn_drags) "sum coefficients, all 1";
  parameter Real k_masses[nIn_masses]=ones(nIn_masses) "sum coefficients, all 1";
  
  
equation
  sum_u_lifts= k_lifts*u_lifts;
  sum_u_thrusts= k_thrusts*u_thrusts;
  sum_u_drags= k_drags*u_drags;
  sum_u_masses= k_masses*u_masses;
end PtMass;
