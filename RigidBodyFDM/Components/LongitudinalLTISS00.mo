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
  parameter Modelica.SIunits.Angle alpha0(displayUnit = "deg") = 0 "" annotation(
    Dialog(tab = "Initial states"));
  parameter Modelica.SIunits.Angle gamma0(displayUnit = "deg") = 0 "" annotation(
    Dialog(tab = "Initial states"));
  parameter Modelica.SIunits.AngularVelocity q0(displayUnit = "rad/s") = 0 "" annotation(
    Dialog(tab = "Initial states"));
  
  //********** Characteristics **********
  parameter Real CD1 annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CDu annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CTu= (-1.0)*CD1 "= del/del_u(FTx) = CTXu + 2*CTX1" annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CDalpha annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CDdeltaE annotation(
    Dialog(group = "D-related-Coefficients"));
  //-----
  parameter Real CL1 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLu annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLalpha annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLalpha_dot annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLq annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLdeltaE annotation(
    Dialog(group = "L-related-Coefficients"));
  //-----
  parameter Real Cm1 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real Cmu annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real CmAlpha annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real CmAlpha_dot annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real Cmq annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real CmDeltaE annotation(
    Dialog(group = "M-related-Coefficients"));
  
  
  /* ---------------------------------------------
        Internal variables
  --------------------------------------------- */
  Real x[4](start=x0) "State vector" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real u[4](start=zeros(4)) "Input vector" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  
  
  /* ---------------------------------------------
      Internal objects
  --------------------------------------------- */
  discrete AircraftDynamics.Utilities.DerivativesLongitudinalNonDim2Dim00 DerLongiNonDim2Dim annotation(
    Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  
  
  /* ---------------------------------------------
            Interface
  --------------------------------------------- */
  AircraftDynamics.Types.InfoBus infoBus1 annotation(
    Placement(visible = true, transformation(origin = {80, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  Modelica.Blocks.Interfaces.RealOutput y_u(unit = "m/s", displayUnit = "m/s") annotation(
    Placement(visible = true, transformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_alpha(unit = "rad", displayUnit = "rad") annotation(
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_q(unit = "rad/s", displayUnit = "rad/s") annotation(
    Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_theta(unit = "rad", displayUnit = "rad") annotation(
    Placement(visible = true, transformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  Modelica.Blocks.Interfaces.RealInput par_q1bar(unit = "Pa", displayUnit = "Pa") "dynamic pressure, input" annotation(
    Placement(visible = true, transformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_S(unit="m2", displayUnit="m2") annotation(
    Placement(visible = true, transformation(origin = {-60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_U1(unit="m/s", displayUnit="m/s") annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_m(unit="kg", displayUnit="kg") "mass" annotation(
    Placement(visible = true, transformation(origin = {-20, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {40, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_Iyy(unit="kg.m2", displayUnit="kg.m2") annotation(
    Placement(visible = true, transformation(origin = {20, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {80, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_cBar(unit="m", displayUnit="m") "mean aerodynamic chord" annotation(
    Placement(visible = true, transformation(origin = {60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {120, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //---
  Modelica.Blocks.Interfaces.RealInput u_deltaE(unit="rad", displayUnit="rad") annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-150, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_delta_iH(unit="rad", displayUnit="rad") annotation(
    Placement(visible = true, transformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-150, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaC(unit="rad", displayUnit="rad") annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-150, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaT(unit="N", displayUnit="N") annotation(
    Placement(visible = true, transformation(origin = {-120, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-150, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //********************************************************************************
protected
  /* ---------------------------------------------
        calculated parameters
  --------------------------------------------- */
  parameter Real A[4, 4](each fixed=false) annotation(
    fixed=false, HideResult=false);
  parameter Real B[4, 4](each fixed=false) annotation(
    fixed=false, HideResult=false);
  parameter Modelica.SIunits.Angle theta0(fixed=false) annotation(
    fixed=false, HideResult=false);
  parameter Real x0[4](each fixed=false) "Initial state vector" annotation(
    HideResult=false);
  //-----
  parameter Real X_u_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real X_alpha_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real X_q_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real X_theta_pri(fixed=false) annotation(
    HideResult=false);
  //---
  parameter Real Z_u_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Z_alpha_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Z_q_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Z_theta_pri(fixed=false) annotation(
    HideResult=false);
  //---
  parameter Real M_u_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real M_alpha_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real M_q_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real M_theta_pri(fixed=false) annotation(
    HideResult=false);
  //********************************************************************************
initial equation
//-----
  alpha0 = theta0 - gamma0;
//---
  x0[1] = par_U1 * cos(alpha0);
  x0[2] = alpha0;
  x0[3] = q0;
  x0[4] = theta0;
//---
  x = x0;
initial algorithm
//********************************************************************************
equation
  
  /* ---------------------------------------------
  Connections, interface <-> internal variables
  --------------------------------------------- */
  u[1]= u_deltaE;
  u[2]= u_delta_iH;
  u[3]= u_deltaC;
  u[4]= u_deltaT;
  //---
  y_u = u[1];
  y_alpha= u[2];
  y_q= u[3];
  y_theta= u[4];
  //-----
  when initial() then
    DerLongiNonDim2Dim.infoBusInputs.U1 = par_U1;
    DerLongiNonDim2Dim.infoBusInputs.q1bar=par_q1bar;
    DerLongiNonDim2Dim.infoBusInputs.S= par_S;
    DerLongiNonDim2Dim.infoBusInputs.m= par_m;
    DerLongiNonDim2Dim.infoBusInputs.Iyy= par_Iyy;
    DerLongiNonDim2Dim.infoBusInputs.cBar= par_cBar;
    //---
    DerLongiNonDim2Dim.infoBusNonDim.CDu= 0.025;
    DerLongiNonDim2Dim.infoBusNonDim.CD1= 0.2;
  end when;
  //-----
  
  /* ---------------------------------------------
  Eqns describing physics
  --------------------------------------------- */
  der(x) = A * x + B * u;
/********************************************************
    Graphics
  ********************************************************/
  annotation(
    defaultComponentName = "LongiSS",
    Icon(graphics = {Rectangle(origin = {66, 152}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-206, -52}, {74, -252}}), Text(origin = {-31, -86}, extent = {{-109, 6}, {171, -14}}, textString = "%name")}, coordinateSystem(extent = {{-140, -100}, {140, 100}})),
    __OpenModelica_commandLineOptions = "");
end LongitudinalLTISS00;
