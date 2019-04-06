within AircraftDynamics.Aerodynamics.Components;

model airfoil2wing00
  //----- imports -----
  import Modelica.Constants;
  
  /********************************************************
     Declaration
  ********************************************************/
  //********** Package **********
  //##### none #####
  //********** Parameters **********
  parameter Real AR_IN=10.0
    ""
    annotation(
    Dialog(group = "Characteristics"));
  parameter Real rambda_IN= 1.0
    ""
    annotation(
    Dialog(group = "Characteristics"));

  
  //********** Internal variables **********
  //***** calculated parameters *****
  Real AR(start= AR_IN) "";
  Real rambda(start= rambda_IN) "";
  
  
  //********** Interfaces **********
  Modelica.Blocks.Interfaces.RealOutput y_CL annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_CD annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_Cl annotation(
    Placement(visible = true, transformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 59}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_Cd annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -1}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_AoA annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_Cl_alpha annotation(
    Placement(visible = true, transformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation

end airfoil2wing00;
