within AircraftDynamics.Interfaces;

model PtMassFrame
  //----- imports -----
  import Modelica.Constants;
  
  /********************************************************
     Declaration
  ********************************************************/
  //********** Parameters **********
  parameter Integer nIn_Fz = 1 
    "Number of Fz inputs"
    annotation(
    Dialog(group = "Port setting"));
  parameter Integer nIn_FxForward= 1
    "Number of thrust inputs"
    annotation(
    Dialog(group = "Port setting"));
  parameter Integer nIn_FxBackward= 1
    "Number of drag inputs"
    annotation(
    Dialog(group = "Port setting"));
  parameter Integer nIn_mass= 0
    "Number of mass(weight) inputs"
    annotation(
    Dialog(group = "Port setting"));
  //********** Internal variables **********
  Modelica.SIunits.Force sum_u_Fz;
  Modelica.SIunits.Force sum_u_FxForward;
  Modelica.SIunits.Force sum_u_FxBackward;
  
  Modelica.SIunits.Mass sum_u_mass;
  
  /*
  Modelica.SIunits.Force sum_u_lifts;
  Modelica.SIunits.Force sum_u_thrusts;
  Modelica.SIunits.Force sum_u_drags;
  */
  
  //********** Interfaces **********
  Modelica.Blocks.Interfaces.RealVectorInput u_FxBackward[nIn_FxBackward] annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 1}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput u_FxForward[nIn_FxForward] annotation(
    Placement(visible = true, transformation(origin = {-100, 1.77636e-15}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 8.88178e-16}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput u_Fz[nIn_Fz] annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput u_mass[nIn_mass] annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus busFltStates1 annotation(
    Placement(visible = true, transformation(origin = { -70, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
protected
  //********** Parameters **********
  parameter Real k_Fz[nIn_Fz]=ones(nIn_Fz) "sum coefficients, all 1";
  parameter Real k_FxForward[nIn_FxForward]=ones(nIn_FxForward) "sum coefficients, all 1";
  parameter Real k_FxBackward[nIn_FxBackward]=ones(nIn_FxBackward) "sum coefficients, all 1";
  parameter Real k_mass[nIn_mass]=ones(nIn_mass) "sum coefficients, all 1";
  
  //********** objects **********
  outer Modelica.Mechanics.MultiBody.World world;
  
equation
  sum_u_Fz= k_Fz* u_Fz;
  sum_u_FxForward= k_FxForward* u_FxForward;
  sum_u_FxBackward= k_FxBackward* u_FxBackward;
  sum_u_mass= k_mass* u_mass;

end PtMassFrame;
