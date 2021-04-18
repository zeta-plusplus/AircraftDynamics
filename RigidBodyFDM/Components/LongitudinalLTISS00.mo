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
  parameter Modelica.SIunits.Angle alpha1 = 5.0*(Constants.pi/180.0) "AoA, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group="in equilibrium"));
  parameter Modelica.SIunits.Angle gamma1 = 0.0 "flight path, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group="in equilibrium"));
  parameter Modelica.SIunits.AngularVelocity q1 = 0.0 "pitch rate, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group="in equilibrium"));
  //---
  parameter Modelica.SIunits.Velocity u0=0.0 "velocity along x-axis, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group="deviation from equilibrium"));
  parameter Modelica.SIunits.Angle alpha0=0.0 "AoA, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group="deviation from equilibrium"));
  parameter Modelica.SIunits.AngularVelocity q0=0.0 "pitch rate, deviation from equilibrium" annotation(
    Dialog(tab = "Initial states", group="deviation from equilibrium"));
  parameter Modelica.SIunits.Angle theta0=0.0 "pitch, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group="deviation from equilibrium"));
  
  
  //********** Characteristics **********
  parameter Real CD1=0.032 annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CDu=0.0 annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CTXu=-0.096  annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CTX1=0.032 annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CDalpha=0.121 annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CDdeltaE=0 annotation(
    Dialog(group = "D-related-Coefficients"));
  //-----
  parameter Real CL1=0.307 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLu=0.0 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLalpha=4.41 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLalpha_dot=1.7 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLq=3.9 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLdeltaE=0.43 annotation(
    Dialog(group = "L-related-Coefficients"));
  //-----
  parameter Real Cm1=0.0 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real Cmu=0.0 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real CmAlpha=-0.613 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real CmAlpha_dot=-7.27 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real Cmq=-12.4 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real CmDeltaE=-1.122 annotation(
    Dialog(group = "M-related-Coefficients"));
  
  
  /* ---------------------------------------------
        Internal variables
  --------------------------------------------- */
  Real x[4](start=x0, final quantity={"Velocity", "Angle", "AngularVelocity", "Angle"}) "State vector" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real u[2](start=zeros(2)) "Input vector" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  //---
  
  
  /* ---------------------------------------------
      Internal objects
  --------------------------------------------- */
  inner outer AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete AircraftDynamics.RigidBodyFDM.Components.DerivativesLongitudinalNonDim2Dim00 DerLongi annotation(
    Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  
  
  /* ---------------------------------------------
            Interface
  --------------------------------------------- */
  AircraftDynamics.Types.InfoBus infoBus1 annotation(
    Placement(visible = true, transformation(origin = {120, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  Modelica.Blocks.Interfaces.RealOutput y_u(final quantity="Velocity", unit = "m/s", displayUnit = "m/s") annotation(
    Placement(visible = true, transformation(origin = {130, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_alpha(final quantity="Angle", final unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {130, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_q(final quantity="AngularVelocity", unit = "rad/s", displayUnit = "rad/s") annotation(
    Placement(visible = true, transformation(origin = {130, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_theta(final quantity="Angle", final unit="rad", displayUnit="deg") annotation(
    Placement(visible = true, transformation(origin = {130, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {150, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  Modelica.Blocks.Interfaces.RealInput par_q1bar(unit = "Pa", displayUnit = "Pa") "dynamic pressure, input" annotation(
    Placement(visible = true, transformation(origin = {-140, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-140, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_S(unit="m2", displayUnit="m2") annotation(
    Placement(visible = true, transformation(origin = {-80, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_U1(unit="m/s", displayUnit="m/s") annotation(
    Placement(visible = true, transformation(origin = {-140, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  Modelica.Blocks.Interfaces.RealInput par_m(unit="kg", displayUnit="kg") "mass" annotation(
    Placement(visible = true, transformation(origin = {-40, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {40, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_Iyy(unit="kg.m2", displayUnit="kg.m2") annotation(
    Placement(visible = true, transformation(origin = {20, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {80, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput par_cBar(unit="m", displayUnit="m") "mean aerodynamic chord" annotation(
    Placement(visible = true, transformation(origin = {60, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {120, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //---
  Modelica.Blocks.Interfaces.RealInput u_deltaE(final quantity="Angle", final unit="rad", displayUnit="deg") annotation(
    Placement(visible = true, transformation(origin = {-140, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-170, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaT(final quantity="Force", final unit="N", displayUnit="N") annotation(
    Placement(visible = true, transformation(origin = {-140, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-170, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //********************************************************************************
protected
  /* ---------------------------------------------
        calculated parameters
  --------------------------------------------- */
  parameter Real A[4, 4](each fixed=false) annotation(
    fixed=false, HideResult=false);
  parameter Real B[4, 2](each fixed=false) annotation(
    fixed=false, HideResult=false);
  parameter Modelica.SIunits.Angle theta1(fixed=false) annotation(
    fixed=false, HideResult=false);
  parameter Modelica.SIunits.Velocity u1(fixed=false) annotation(
    fixed=false, HideResult=false);
  parameter Real x0[4](each fixed=false) "Initial state vector" annotation(
    HideResult=false);
  //-----
  parameter Real Xu_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Xalpha_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Xq_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Xtheta_pri(fixed=false) annotation(
    HideResult=false);
  //---
  parameter Real Zu_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Zalpha_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Zq_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Ztheta_pri(fixed=false) annotation(
    HideResult=false);
  //---
  parameter Real Mu_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Malpha_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Mq_pri(fixed=false) annotation(
    HideResult=false);
  parameter Real Mtheta_pri(fixed=false) annotation(
    HideResult=false);
  //---
  parameter Real XdeltaE_pri(fixed=false) annotation(
    HideResult=false);
  //---
  parameter Real ZdeltaE_pri(fixed=false) annotation(
    HideResult=false);
  //---
  parameter Real MdeltaE_pri(fixed=false) annotation(
    HideResult=false);
  //---
  //********************************************************************************
initial equation
  
  //***** Dimentional derivatives *****
  Xu_pri= DerLongi.infoBusDim.Xu_pri;
  Xalpha_pri= DerLongi.infoBusDim.Xalpha_pri;
  Xq_pri= DerLongi.infoBusDim.Xq_pri;
  Xtheta_pri= DerLongi.infoBusDim.Xtheta_pri;
  //---
  Zu_pri= DerLongi.infoBusDim.Zu_pri;
  Zalpha_pri= DerLongi.infoBusDim.Zalpha_pri;
  Zq_pri= DerLongi.infoBusDim.Zq_pri;
  Ztheta_pri= DerLongi.infoBusDim.Ztheta_pri;
  //---
  Mu_pri= DerLongi.infoBusDim.Mu_pri;
  Malpha_pri= DerLongi.infoBusDim.Malpha_pri;
  Mq_pri= DerLongi.infoBusDim.Mq_pri;
  Mtheta_pri= DerLongi.infoBusDim.Mtheta_pri;
  //---
  XdeltaE_pri= DerLongi.infoBusDim.XdeltaE_pri;
  //---
  ZdeltaE_pri= DerLongi.infoBusDim.ZdeltaE_pri;
  //---
  MdeltaE_pri= DerLongi.infoBusDim.MdeltaE_pri;
  //---
  /**/
  
  //***** test *****
  /*
  Xu_pri= -0.023564;
  Xalpha_pri= 41.0074;
  Xq_pri= 0.0;
  Xtheta_pri= -32.2;
  //---
  Zu_pri= -0.000241;
  Zalpha_pri= -1.296;
  Zq_pri= 0.9846;
  Ztheta_pri= 0.0;
  //---
  Mu_pri= 0.00020571;
  Malpha_pri= -3.5094;
  Mq_pri= -2.4142;
  Mtheta_pri= 0;
  
  //---
  XdeltaE_pri= 0.0;
  //---
  ZdeltaE_pri= -0.0821;
  //---
  MdeltaE_pri= -15.7002;
  */
  
  //***** matrices of state space equation *****
  A= [
      Xu_pri, Xalpha_pri, Xq_pri, Xtheta_pri;
      Zu_pri, Zalpha_pri, Zq_pri, Ztheta_pri;
      Mu_pri, Malpha_pri, Mq_pri, Mtheta_pri;
      0.0, 0.0, 1.0, 0.0
     ];
  
  B= [
      XdeltaE_pri, 0.0;
      ZdeltaE_pri, 0.0;
      MdeltaE_pri, 0.0;
      0.0, 0.0
     ];
  
  //***** initial condition *****
  //-----
  alpha1 = theta1 - gamma1;
  u1= par_U1*cos(alpha1);
  //---
  x0[1] = u0;
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
  u[2]= u_deltaT;
  
//---
  y_u = u1 + x[1];
  y_alpha= alpha1 + x[2];
  y_q= q1 + x[3];
  y_theta= theta1 + x[4];
//-----
  when initial() then
    //***** flight condition *****
    DerLongi.infoBusFlt.U1 = par_U1;
    DerLongi.infoBusFlt.q1bar = par_q1bar;
    DerLongi.infoBusFlt.g= environmentAircraftDynSim.gravity;
    DerLongi.infoBusFlt.theta1= theta0;
    //---
    //***** aircraft characteristics *****
    DerLongi.infoBusAircraft.S = par_S;
    DerLongi.infoBusAircraft.m = par_m;
    DerLongi.infoBusAircraft.Iyy = par_Iyy;
    DerLongi.infoBusAircraft.cBar = par_cBar;
    //---
    
    //***** Non-dimentional coefficients/derivatives *****
    DerLongi.infoBusNonDim.CDu = CDu;
    DerLongi.infoBusNonDim.CD1 = CD1;
    DerLongi.infoBusNonDim.CTXu = CTXu;
    DerLongi.infoBusNonDim.CTX1 = CTX1;
    DerLongi.infoBusNonDim.CDalpha = CDalpha;
    DerLongi.infoBusNonDim.CDdeltaE = CDdeltaE;
    //---
    DerLongi.infoBusNonDim.CL1 = CL1;
    DerLongi.infoBusNonDim.CLu= CLu;
    DerLongi.infoBusNonDim.CLalpha= CLalpha;
    DerLongi.infoBusNonDim.CLalpha_dot= CLalpha_dot;
    DerLongi.infoBusNonDim.CLq= CLq;
    DerLongi.infoBusNonDim.CLdeltaE=CLdeltaE;
    //---
    DerLongi.infoBusNonDim.Cm1= Cm1;
    DerLongi.infoBusNonDim.Cmu= Cmu;
    DerLongi.infoBusNonDim.CmAlpha= CmAlpha;
    DerLongi.infoBusNonDim.CmAlpha_dot= CmAlpha_dot;
    DerLongi.infoBusNonDim.Cmq= Cmq;
    DerLongi.infoBusNonDim.CmDeltaE= CmDeltaE;
    //---
    DerLongi.infoBusNonDim.CmTu= 0.0; // provide dummy input
    DerLongi.infoBusNonDim.CmT1= 0.0; // provide dummy input
    DerLongi.infoBusNonDim.CmTalpha= 0.0; // provide dummy input
    
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
    defaultComponentName = "FltDynLongiSS",
    Icon(graphics = {Rectangle(origin = {66, 152}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-226, -52}, {74, -252}}), Text(origin = {-31, -86}, extent = {{-129, 6}, {171, -14}}, textString = "%name")}, coordinateSystem(extent = {{-160, -100}, {140, 100}}, initialScale = 0.1)),
    __OpenModelica_commandLineOptions = "",
  Diagram(coordinateSystem(extent = {{-120, -100}, {120, 120}})));
  
  
end LongitudinalLTISS00;
