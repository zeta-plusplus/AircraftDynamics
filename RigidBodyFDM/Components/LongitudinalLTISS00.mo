within AircraftDynamics.RigidBodyFDM.Components;

block LongitudinalLTISS00 "Longitudinal FDM with Linear Time Invariant State Space equations"
  extends AircraftDynamics.Icons.Icon_LongitudinalDynamics;
  //extends AircraftDynamics.RigidBodyFDM.BaseClasses.LTISS00;
  /********************************************************
                  imports
      ********************************************************/
  import Modelica.Constants;
  import Modelica.Utilities.Streams;
  import Modelica.Math.Matrices;
  import units = Modelica.Units.SI;
  /********************************************************
                     Declaration
      ********************************************************/
  /* ---------------------------------------------
          switches
    --------------------------------------------- */
  parameter Boolean use_u_q1bar = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_U1 = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_S = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_cBar = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_m = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_Iyy = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  /* ---------------------------------------------
            parameters
      --------------------------------------------- */
  //********** Initial States **********
  parameter units.Angle alpha1 = 5.0 * (Constants.pi / 180.0) "AoA, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "in equilibrium"));
  parameter units.Angle gamma1 = 0.0 "flight path, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "in equilibrium"));
  parameter units.AngularVelocity q1 = 0.0 "pitch rate, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "in equilibrium"));
  //---
  parameter units.Velocity u0 = 0.0 "velocity along x-axis, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "deviation from equilibrium"));
  parameter units.Angle alpha0 = 0.0 "AoA, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "deviation from equilibrium"));
  parameter units.AngularVelocity q0 = 0.0 "pitch rate, deviation from equilibrium" annotation(
    Dialog(tab = "Initial states", group = "deviation from equilibrium"));
  parameter units.Angle theta0 = 0.0 "pitch, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "deviation from equilibrium"));
  //********** Aircraft Properties **********
  parameter units.Area S_par = 16.165129 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter units.Length cBar_par = 1.49352 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter units.Mass m_par = 1202.01978 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter units.MomentOfInertia Iyy_par = 1824.9309607 "" annotation(
    Dialog(group = "Aircraft Properties"));
  //---
  parameter units.Angle thetaTi_par = 2.0 * (Constants.pi / 180.0) "inclination of thrust instllation, in pich" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter units.Angle psiTi_par = 0.0 * (Constants.pi / 180.0) "inclination of thrust installation, in yaw" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter Real xBarTi_par = 0.1 "non-dim distance, + == foward of CG, thrust acting point - C.G., x-axis" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter Real zBarTi_par = 0.1 "non-dim distance, + == below CG, thrust acting point - C.G., z-axis" annotation(
    Dialog(group = "Aircraft Properties"));
  //********** Characteristics **********
  parameter Real CD1 = 0.032 annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CDu = 0.0 annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CTXu = -0.096 annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CTX1 = 0.032 annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CDalpha = 0.121 annotation(
    Dialog(group = "D-related-Coefficients"));
  parameter Real CDdeltaE = 0 annotation(
    Dialog(group = "D-related-Coefficients"));
  //-----
  parameter Real CL1 = 0.307 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLu = 0.0 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLalpha = 4.41 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLalpha_dot = 1.7 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLq = 3.9 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CLdeltaE = 0.43 annotation(
    Dialog(group = "L-related-Coefficients"));
  //-----
  parameter Real Cm1 = 0.0 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real Cmu = 0.0 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real CmAlpha = -0.613 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real CmAlpha_dot = -7.27 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real Cmq = -12.4 annotation(
    Dialog(group = "M-related-Coefficients"));
  parameter Real CmDeltaE = -1.122 annotation(
    Dialog(group = "M-related-Coefficients"));
  //********** Steady Flight Condition **********
  parameter units.Velocity U1_par = 67.3295 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter units.Pressure q1bar_par = 2384.17 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  /* ---------------------------------------------
            Internal variables
      --------------------------------------------- */
  //redeclare 
  Real vec_x[4](start = vec_x0) annotation(
    each fixed=false,
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  //redeclare 
  Real vec_u[2] annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  //redeclare 
  Real vec_y[6] annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  //---
  /* ---------------------------------------------
          Internal objects
      --------------------------------------------- */
  inner outer AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //discrete 
  AircraftDynamics.RigidBodyFDM.Components.DerivativesLongitudinalNonDim2Dim00 DerLongi annotation(
    Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  /* ---------------------------------------------
                Interface
      --------------------------------------------- */
  AircraftDynamics.Types.InfoBus infoBus1 annotation(
    Placement(visible = true, transformation(origin = {120, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {130, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  Modelica.Blocks.Interfaces.RealOutput y_aZ(final quantity = "Acceleration", unit = "m/s2", displayUnit = "m/s2") annotation(
    Placement(visible = true, transformation(origin = {130, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_aX(final quantity = "Acceleration", unit = "m/s2", displayUnit = "m/s2") annotation(
    Placement(visible = true, transformation(origin = {130, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_u(final quantity = "Velocity", unit = "m/s", displayUnit = "m/s") annotation(
    Placement(visible = true, transformation(origin = {130, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_alpha(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {130, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_q(final quantity = "AngularVelocity", unit = "rad/s", displayUnit = "rad/s") annotation(
    Placement(visible = true, transformation(origin = {130, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_theta(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {130, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  Modelica.Blocks.Interfaces.RealInput u_q1bar(unit = "Pa", displayUnit = "Pa") if use_u_q1bar "dynamic pressure, input" annotation(
    Placement(visible = true, transformation(origin = {-140, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-130, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_S(unit = "m2", displayUnit = "m2") if use_u_S==true "" annotation(
    Placement(visible = true, transformation(origin = {-80, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {10, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_U1(unit = "m/s", displayUnit = "m/s") if use_u_U1 "" annotation(
    Placement(visible = true, transformation(origin = {-140, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_m(unit = "kg", displayUnit = "kg") if use_u_m "mass" annotation(
    Placement(visible = true, transformation(origin = {-40, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {50, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_Iyy(unit = "kg.m2", displayUnit = "kg.m2") if use_u_Iyy "" annotation(
    Placement(visible = true, transformation(origin = {20, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_cBar(unit = "m", displayUnit = "m") if use_u_cBar "mean aerodynamic chord" annotation(
    Placement(visible = true, transformation(origin = {60, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {130, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //---
  Modelica.Blocks.Interfaces.RealInput u_deltaE(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {-140, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-160, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaT(final quantity = "Force", final unit = "N", displayUnit = "N") annotation(
    Placement(visible = true, transformation(origin = {-140, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-160, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //********************************************************************************
  AircraftDynamics.Interfaces.VisualizerInfoOut00 VisInfoOut annotation(
    Placement(visible = true, transformation(origin = {60, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {80, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
protected
  /* ---------------------------------------------
            redeclare protected parameters
      --------------------------------------------- */
  //---
  //redeclare 
  parameter Real mat_A[4, 4] annotation(
    each fixed = false,
    each HideResult = false);
  //redeclare 
  parameter Real mat_B[4, 2] annotation(
    each fixed = false,
    each HideResult = false);
  //redeclare 
  parameter Real mat_C[6, 4] annotation(
    each fixed = false,
    each HideResult = false);
  //redeclare 
  parameter Real mat_D[6, 2] annotation(
    each fixed = false,
    each HideResult = false);
  //---
  //redeclare 
  parameter Real vec_x0[4] "Initial state vector" annotation(
    each fixed= false,
    each HideResult = false);
  
  /* ---------------------------------------------
            parameters not fixed yet
    --------------------------------------------- */
  parameter units.Acceleration g(fixed = false) "";
  parameter units.Velocity U1(fixed = false) "";
  parameter units.Pressure q1bar(fixed = false) "";
  parameter units.Area S(fixed = false) "";
  parameter units.Length cBar(fixed = false) "";
  parameter units.Mass m(fixed = false) "";
  parameter units.MomentOfInertia Iyy(fixed = false) "";
  //---
  parameter units.Angle thetaTi(fixed = false) "";
  parameter units.Angle psiTi(fixed = false) "";
  parameter Real xBarTi(fixed = false) "";
  parameter Real zBarTi(fixed = false) "";
  //---
  parameter units.Angle theta1(fixed = false) annotation(
    fixed = false,
    HideResult = false);
  parameter units.Velocity u1(fixed = false) annotation(
    fixed = false,
    HideResult = false);
  //-----
  parameter Real Xu_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Xalpha_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Xq_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Xtheta_pri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real Zu_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Zalpha_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Zq_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Ztheta_pri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real Mu_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Malpha_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Mq_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Mtheta_pri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real XdeltaE_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real XdeltaT_pri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real ZdeltaE_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real ZdeltaT_pri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real MdeltaE_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real MdeltaT_pri(fixed = false) annotation(
    HideResult = false);
  //----------
  parameter Real Zu_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real Zalpha_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real Zq_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real Ztheta_ppri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real ZdeltaE_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real ZdeltaT_ppri(fixed = false) annotation(
    HideResult = false);
  //-----
  parameter Real Xu_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real Xalpha_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real Xq_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real Xtheta_ppri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real XdeltaE_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real XdeltaT_ppri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real dmy = 1.0;
  //********************************************************************************
initial equation

//----- Dimentional derivatives -----
  Xu_pri = DerLongi.Xu_pri;
  Xalpha_pri = DerLongi.Xalpha_pri;
  Xq_pri = DerLongi.Xq_pri;
  Xtheta_pri = DerLongi.Xtheta_pri;
//---
  Zu_pri = DerLongi.Zu_pri;
  Zalpha_pri = DerLongi.Zalpha_pri;
  Zq_pri = DerLongi.Zq_pri;
  Ztheta_pri = DerLongi.Ztheta_pri;
//---
  Mu_pri = DerLongi.Mu_pri;
  Malpha_pri = DerLongi.Malpha_pri;
  Mq_pri = DerLongi.Mq_pri;
  Mtheta_pri = DerLongi.Mtheta_pri;
//---
  XdeltaE_pri = DerLongi.XdeltaE_pri;
  XdeltaT_pri = DerLongi.XdeltaT_pri;
//---
  ZdeltaE_pri = DerLongi.ZdeltaE_pri;
  ZdeltaT_pri = DerLongi.ZdeltaT_pri;
//---
  MdeltaE_pri = DerLongi.MdeltaE_pri;
  MdeltaT_pri = DerLongi.MdeltaT_pri;
//---

  Zu_ppri = DerLongi.Zu_ppri;
  Zalpha_ppri = DerLongi.Zalpha_ppri;
  Zq_ppri = DerLongi.Zq_ppri;
  Ztheta_ppri = DerLongi.Ztheta_ppri;
//---
  ZdeltaE_ppri = DerLongi.ZdeltaE_ppri;
  ZdeltaT_ppri = DerLongi.ZdeltaT_ppri;
//-----
  Xu_ppri = DerLongi.Xu_ppri;
  Xalpha_ppri = DerLongi.Xalpha_ppri;
  Xq_ppri = DerLongi.Xq_ppri;
  Xtheta_ppri = DerLongi.Xtheta_ppri;
//---
  XdeltaE_ppri = DerLongi.XdeltaE_ppri;
  XdeltaT_ppri = DerLongi.XdeltaT_ppri;
//-----
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
  mat_A = [Xu_pri, Xalpha_pri, Xq_pri, Xtheta_pri; Zu_pri, Zalpha_pri, Zq_pri, Ztheta_pri; Mu_pri, Malpha_pri, Mq_pri, Mtheta_pri; 0.0, 0.0, 1.0, 0.0];
  mat_B = [XdeltaE_pri, XdeltaT_pri; ZdeltaE_pri, ZdeltaT_pri; MdeltaE_pri, MdeltaT_pri; 0.0, 0.0];
  mat_C = [Zu_ppri, Zalpha_ppri, Zq_ppri, Ztheta_ppri; Xu_ppri, Xalpha_ppri, Xq_ppri, Xtheta_ppri; 1.0, 0.0, 0.0, 0.0; 0.0, 1.0, 0.0, 0.0; 0.0, 0.0, 1.0, 0.0; 0.0, 0.0, 0.0, 1.0];
  mat_D = [ZdeltaE_ppri, ZdeltaT_ppri; XdeltaE_ppri, XdeltaT_ppri; 0.0, 0.0; 0.0, 0.0; 0.0, 0.0; 0.0, 0.0];
/**/
//***** initial condition *****
  g = environmentAircraftDynSim.gravity;
//-----
  alpha1 = theta1 - gamma1;
  u1 = U1 * cos(alpha1);
//---
  vec_x0[1] = u0;
  vec_x0[2] = alpha0;
  vec_x0[3] = q0;
  vec_x0[4] = theta0;
//***** flight condition *****
  if use_u_U1 == true then
    U1 = u_U1;
  else
    U1 = U1_par;
  end if;
  //--
  if use_u_q1bar == true then
    q1bar = u_q1bar;
  else
    q1bar = q1bar_par;
  end if;
//***** aircraft properties *****
  if use_u_S == true then
    S = u_S;
  else
    S = S_par;
  end if;
  //--
  if use_u_m == true then
    m = u_m;
  else
    m = m_par;
  end if;
  //--
  if use_u_Iyy == true then
    Iyy = u_Iyy;
  else
    Iyy = Iyy_par;
  end if;
  //--
  if use_u_cBar == true then
    cBar = u_cBar;
  else
    cBar = cBar_par;
  end if;
//---
  zBarTi = zBarTi_par;
  xBarTi = xBarTi_par;
  thetaTi = thetaTi_par;
  psiTi = psiTi_par;
//********************************************************************************
initial algorithm
/*
//----- Dimentional derivatives -----
  Xu_pri := DerLongi.Xu_pri;
  Xalpha_pri := DerLongi.Xalpha_pri;
  Xq_pri := DerLongi.Xq_pri;
  Xtheta_pri := DerLongi.Xtheta_pri;
//---
  Zu_pri := DerLongi.Zu_pri;
  Zalpha_pri := DerLongi.Zalpha_pri;
  Zq_pri := DerLongi.Zq_pri;
  Ztheta_pri := DerLongi.Ztheta_pri;
//---
  Mu_pri := DerLongi.Mu_pri;
  Malpha_pri := DerLongi.Malpha_pri;
  Mq_pri := DerLongi.Mq_pri;
  Mtheta_pri := DerLongi.Mtheta_pri;
//---
  XdeltaE_pri := DerLongi.XdeltaE_pri;
  XdeltaT_pri := DerLongi.XdeltaT_pri;
//---
  ZdeltaE_pri := DerLongi.ZdeltaE_pri;
  ZdeltaT_pri := DerLongi.ZdeltaT_pri;
//---
  MdeltaE_pri := DerLongi.MdeltaE_pri;
  MdeltaT_pri := DerLongi.MdeltaT_pri;
//---

  Zu_ppri := DerLongi.Zu_ppri;
  Zalpha_ppri := DerLongi.Zalpha_ppri;
  Zq_ppri := DerLongi.Zq_ppri;
  Ztheta_ppri := DerLongi.Ztheta_ppri;
//---
  ZdeltaE_ppri := DerLongi.ZdeltaE_ppri;
  ZdeltaT_ppri := DerLongi.ZdeltaT_ppri;
//-----
  Xu_ppri := DerLongi.Xu_ppri;
  Xalpha_ppri := DerLongi.Xalpha_ppri;
  Xq_ppri := DerLongi.Xq_ppri;
  Xtheta_ppri := DerLongi.Xtheta_ppri;
//---
  XdeltaE_ppri := DerLongi.XdeltaE_ppri;
  XdeltaT_ppri := DerLongi.XdeltaT_ppri;
//-----
*/
//***** matrices of state space equation *****
/*
  mat_A := [Xu_pri, Xalpha_pri, Xq_pri, Xtheta_pri; Zu_pri, Zalpha_pri, Zq_pri, Ztheta_pri; Mu_pri, Malpha_pri, Mq_pri, Mtheta_pri; 0.0, 0.0, 1.0, 0.0];
  mat_B := [XdeltaE_pri, XdeltaT_pri; ZdeltaE_pri, ZdeltaT_pri; MdeltaE_pri, MdeltaT_pri; 0.0, 0.0];
  mat_C := [Zu_ppri, Zalpha_ppri, Zq_ppri, Ztheta_ppri; Xu_ppri, Xalpha_ppri, Xq_ppri, Xtheta_ppri; 1.0, 0.0, 0.0, 0.0; 0.0, 1.0, 0.0, 0.0; 0.0, 0.0, 1.0, 0.0; 0.0, 0.0, 0.0, 1.0];
  mat_D := [ZdeltaE_ppri, ZdeltaT_ppri; XdeltaE_ppri, XdeltaT_ppri; 0.0, 0.0; 0.0, 0.0; 0.0, 0.0; 0.0, 0.0];
  */
//********************************************************************************
equation
/* ---------------------------------------------
    Connections, interface <-> internal variables
  --------------------------------------------- */
  vec_u[1] = u_deltaE;
  vec_u[2] = u_deltaT;
//---
  /**/
  y_u = u1 + vec_x[1];
  y_alpha = alpha1 + vec_x[2];
  y_q = q1 + vec_x[3];
  y_theta = theta1 + vec_x[4];
  y_aZ = vec_y[1];
  y_aX = vec_y[2];
  
//-----
  VisInfoOut.r[1] = 0.0;
  VisInfoOut.r[2] = 0.0;
  VisInfoOut.r[3] = 0.0;
  VisInfoOut.theta[1] = 0.0;
  VisInfoOut.theta[2] = y_theta;
  VisInfoOut.theta[3] = 0.0;
  VisInfoOut.alpha= y_alpha;
  VisInfoOut.beta= 0.0;
  VisInfoOut.V[1]= y_u;
  VisInfoOut.V[2]= 0.0;
  VisInfoOut.V[3]= y_u*tan(y_theta);
  
//-----
//----- flight condition -----
  DerLongi.U1= U1;
  DerLongi.q1bar= q1bar;
  DerLongi.g= g;
  DerLongi.theta1= theta1;
  DerLongi.alpha1= alpha1;

//----- aircraft properties -----
  DerLongi.S= S;
  DerLongi.m= m;
  DerLongi.Iyy= Iyy;
  DerLongi.cBar= cBar;
  
//---
  DerLongi.thetaTi= thetaTi;
  DerLongi.psiTi= psiTi;
  DerLongi.xBarTi= xBarTi;
  DerLongi.zBarTi= zBarTi;

//----- Non-dimentional coefficients/derivatives -----
  DerLongi.CDu= CDu;
  DerLongi.CD1= CD1;
  DerLongi.CTXu= CTXu;
  DerLongi.CTX1= CTX1;
  DerLongi.CDalpha= CDalpha;
  DerLongi.CDdeltaE= CDdeltaE;
//---
  DerLongi.CL1= CL1;
  DerLongi.CLu= CLu;
  DerLongi.CLalpha= CLalpha;
  DerLongi.CLalpha_dot= CLalpha_dot;
  DerLongi.CLq= CLq;
  DerLongi.CLdeltaE= CLdeltaE;
//---
  DerLongi.Cm1= Cm1;
  DerLongi.Cmu= Cmu;
  DerLongi.CmAlpha= CmAlpha;
  DerLongi.CmAlpha_dot= CmAlpha_dot;
  DerLongi.Cmq= Cmq;
  DerLongi.CmDeltaE= CmDeltaE;
//---
  DerLongi.CmTu= dmy;
//-- provide dummy input --
  DerLongi.CmT1= dmy;
  DerLongi.CmTalpha= dmy;
  
  
  //-----
  der(vec_x) = mat_A * vec_x + mat_B * vec_u;
  vec_y = mat_C * vec_x + mat_D * vec_u;
  //---
  
//---
/**/
/********************************************************
  Graphics
********************************************************/
  annotation(
    defaultComponentName = "FltDynLongiSS",
    Icon(graphics = {Text(origin = {-21, -113}, extent = {{-129, 5}, {171, -11}}, textString = "%name")}, coordinateSystem(extent = {{-150, -100}, {150, 100}}, initialScale = 0.1)),
    __OpenModelica_commandLineOptions = "",
    Diagram(coordinateSystem(extent = {{-120, -100}, {120, 120}})));
end LongitudinalLTISS00;
