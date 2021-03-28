within AircraftDynamics.RigidBodyFDM.Components;

block LongitudinalLTISS00
  /********************************************************
              imports
  ********************************************************/
  import Modelica.Constants;
  import Modelica.Utilities.Streams;
  
  
  /********************************************************
                 Declaration
  ********************************************************/
  /* ---------------------------------------------
        parameters
  --------------------------------------------- */
  //********** Initial States **********
  parameter Modelica.SIunits.Angle alpha0(displayUnit = "deg") = 5 "" annotation(
    Dialog(tab = "Initial states"));
  parameter Modelica.SIunits.Angle gamma0(displayUnit = "deg") = 0 "" annotation(
    Dialog(tab = "Initial states"));
  
  
  
  /* ---------------------------------------------
        Internal variables
  --------------------------------------------- */
  Real x[4](start = x_start) "State vector";
  
  
  
  /* ---------------------------------------------
            Interface
  --------------------------------------------- */
  AircraftDynamics.Types.InfoBus infoBus1 annotation(
    Placement(visible = true, transformation(origin = {80, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  Modelica.Blocks.Interfaces.RealOutput y_u(unit = "m/s", displayUnit = "m/s") annotation(
    Placement(visible = true, transformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {130, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_alpha(unit = "rad", displayUnit = "rad") annotation(
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {130, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_q(unit = "rad/s", displayUnit = "rad/s") annotation(
    Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {130, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_theta(unit = "rad", displayUnit = "rad") annotation(
    Placement(visible = true, transformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {130, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  Modelica.Blocks.Interfaces.RealInput par_dynP1(unit="Pa", displayUnit="Pa") "dynamic pressure, input" annotation(
    Placement(visible = true, transformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-130, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput par_S(unit="m2", displayUnit="m2") annotation(
    Placement(visible = true, transformation(origin = {-60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 130}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_U1(unit="m/s", displayUnit="m/s") annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-130, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput par_m(unit="kg", displayUnit="kg") "mass" annotation(
    Placement(visible = true, transformation(origin = {-20, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 130}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_Iyy(unit="kg.m2", displayUnit="kg.m2") annotation(
    Placement(visible = true, transformation(origin = {20, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 130}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_cBar(unit="m", displayUnit="m") "mean aerodynamic chord" annotation(
    Placement(visible = true, transformation(origin = {60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {40, 130}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //---
  Modelica.Blocks.Interfaces.RealInput u_deltaE(unit="rad", displayUnit="rad") annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-130, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_delta_iH(unit="rad", displayUnit="rad") annotation(
    Placement(visible = true, transformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-130, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaC(unit="rad", displayUnit="rad") annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-130, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaT(unit="N", displayUnit="N") annotation(
    Placement(visible = true, transformation(origin = {-120, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-130, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //********************************************************************************
protected
  /* ---------------------------------------------
        calculated parameters
  --------------------------------------------- */
  parameter Real A[4, 4] annotation(
    HideResult=false);
  parameter Real B[4, 4] annotation(
    HideResult=false);
  parameter Modelica.SIunits.Angle theta0 annotation(
    HideResult=false);
  parameter Real x0[4] "Initial state vector" annotation(
    HideResult=false);
  
  //-----
  parameter Real Xu_pri annotation(
    HideResult=false);
  parameter Real Xalpha_pri annotation(
    HideResult=false);
  parameter Real Xq_pri annotation(
    HideResult=false);
  parameter Real Xtheta_pri annotation(
    HideResult=false);
  //---
  parameter Real Zu_pri annotation(
    HideResult=false);
  parameter Real Zalpha_pri annotation(
    HideResult=false);
  parameter Real Zq_pri annotation(
    HideResult=false);
  parameter Real Ztheta_pri annotation(
    HideResult=false);
  //---
  parameter Real Mu_pri annotation(
    HideResult=false);
  parameter Real Malpha_pri annotation(
    HideResult=false);
  parameter Real Mq_pri annotation(
    HideResult=false);
  parameter Real Mtheta_pri annotation(
    HideResult=false);
  
  
  //********************************************************************************
initial equation
  alpha0 = theta0 - gamma0;
  x0[1] = par_U1 * cos(alpha0);
  x0[2] = alpha0;
  x0[3] = q0;
  x0[4] = theta0;
//********************************************************************************
equation
/********************************************************
    Graphics
  ********************************************************/
  annotation(
    defaultComponentName = "LongiSS",
    Icon(graphics = {Rectangle(origin = {20, -20}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-140, 140}, {100, -100}}), Text(origin = {-11, -106}, extent = {{-109, 6}, {131, -14}}, textString = "%name")}, coordinateSystem(extent = {{-120, -120}, {120, 120}})),
    __OpenModelica_commandLineOptions = "");
end LongitudinalLTISS00;
