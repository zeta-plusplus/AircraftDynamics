within AircraftDynamics.Aerodynamics.BaseClasses;

model Airfoil2WingSimple00
  //----- imports -----
  import Modelica.Constants;
  
  /********************************************************
     Declaration
  ********************************************************/
  //********** Package **********
  //##### none #####
  //********** Parameters **********
  parameter Real ARdes=10.0
    ""
    annotation(
    Dialog(group = "Geometry"));
  parameter Real rambdaDes= 1.0
    ""
    annotation(
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Angle sweepDes= 0.0
    ""
    annotation(
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Area Sdes= 1.0
    ""
    annotation(
    Dialog(group = "Geometry"));
  
  parameter Real effOsDes= 0.9
    ""
    annotation(
    Dialog(group = "Characteristics"));
  
  //********** Internal variables **********
  //***** calculated parameters *****
  Real AR(start= ARdes) "";
  Real rambda(start= rambdaDes) "";
  Modelica.SIunits.Angle sweep(start= sweepDes) "";
  Real effOs(start= effOsDes) "";
  Modelica.SIunits.Area S(start= Sdes) "";
  Modelica.SIunits.Length b(start= sqrt(ARdes*Sdes)) "";
  //---
  Real Cl_alpha;
  Modelica.SIunits.Angle AoA;
  Real MnFlt;
  //---
  
  
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

algorithm
  
  
  
equation
  
  
  
end Airfoil2WingSimple00;
