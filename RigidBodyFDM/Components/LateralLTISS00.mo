within AircraftDynamics.RigidBodyFDM.Components;

block LateralLTISS00 "Lateral/Directional FDM with Linear Time Invariant Steady State equations"
  extends AircraftDynamics.Icons.Icon_LateralDynamics;
  extends AircraftDynamics.RigidBodyFDM.BaseClasses.LTISS00;
  /********************************************************
                            imports
          ********************************************************/
  import Modelica.Constants;
  import Modelica.Utilities.Streams;
  import Modelica.SIunits;
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
  parameter Boolean use_u_b = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_m = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_Ixx = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_Izz = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_Ixz = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  /* ---------------------------------------------
                      parameters
          --------------------------------------------- */
  //********** Initial States **********
  parameter Modelica.SIunits.Angle beta1 = 0.0 * (Constants.pi / 180.0) "sideslip, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "in equilibrium"));
  parameter Modelica.SIunits.Angle phi1 = 0.0 * (Constants.pi / 180.0) "roll, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "in equilibrium"));
  parameter Modelica.SIunits.Angle psi1 = 0.0 * (Constants.pi / 180.0) "heading, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "in equilibrium"));
  parameter Modelica.SIunits.AngularVelocity p1 = 0.0 * (Constants.pi / 180.0) "roll rate, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "in equilibrium"));
  parameter Modelica.SIunits.AngularVelocity r1 = 0.0 * (Constants.pi / 180.0) "yaw rate, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "in equilibrium"));
  parameter Modelica.SIunits.Angle theta1 = 0.8994698 * (Constants.pi / 180.0) "pitch, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "in equilibrium"));
  //---
  parameter Modelica.SIunits.Angle beta0 = 0.0 * (Constants.pi / 180.0) "sideslip, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.Angle phi0 = 0.0 * (Constants.pi / 180.0) "roll, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.Angle psi0 = 0.0 * (Constants.pi / 180.0) "heading, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.AngularVelocity p0 = 0.0 * (Constants.pi / 180.0) "roll rate, deviation from equilibrium" annotation(
    Dialog(tab = "Initial states", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.AngularVelocity r0 = 0.0 * (Constants.pi / 180.0) "yaw rate, deviation from equilibrium" annotation(
    Dialog(tab = "Initial states", group = "deviation from equilibrium"));
  //---
  //********** Aircraft Properties **********
  parameter SIunits.Area S_par = 16.165129 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.Length b_par = 10.9728 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.Mass m_par = 1202.01978 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.MomentOfInertia Ixx_par = 1285.3154166 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.MomentOfInertia Izz_par = 2666.89390765 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.MomentOfInertia Ixz_par = 0.0 "" annotation(
    Dialog(group = "Aircraft Properties"));
  //********** Characteristics **********
  parameter Real CYbeta = -0.393 annotation(
    Dialog(group = "Y-related-Coefficients"));
  parameter Real CYp = -0.075 annotation(
    Dialog(group = "Y-related-Coefficients"));
  parameter Real CYr = 0.214 annotation(
    Dialog(group = "Y-related-Coefficients"));
  parameter Real CYdeltaA = 0.0 annotation(
    Dialog(group = "Y-related-Coefficients"));
  parameter Real CYdeltaR = 0.187 annotation(
    Dialog(group = "Y-related-Coefficients"));
  parameter Real CYdeltaF = 0.0 annotation(
    Dialog(group = "Y-related-Coefficients"));
  parameter Real CYdeltaS = 0.0 annotation(
    Dialog(group = "Y-related-Coefficients"));
  //-----
  parameter Real Clbeta = -0.0923 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real Clp = -0.484 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real Clr = 0.0798 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CldeltaA = 0.229 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CldeltaR = 0.0147 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CldeltaF = 0.0 annotation(
    Dialog(group = "L-related-Coefficients"));
  parameter Real CldeltaS = 0.0 annotation(
    Dialog(group = "L-related-Coefficients"));
  //-----
  parameter Real Cnbeta = 0.0587 annotation(
    Dialog(group = "N-related-Coefficients"));
  parameter Real Cnp = -0.0278 annotation(
    Dialog(group = "N-related-Coefficients"));
  parameter Real Cnr = -0.0937 annotation(
    Dialog(group = "N-related-Coefficients"));
  parameter Real CndeltaA = -0.0216 annotation(
    Dialog(group = "N-related-Coefficients"));
  parameter Real CndeltaR = -0.0645 annotation(
    Dialog(group = "N-related-Coefficients"));
  parameter Real CndeltaF = -0.0 annotation(
    Dialog(group = "N-related-Coefficients"));
  parameter Real CndeltaS = -0.0 annotation(
    Dialog(group = "N-related-Coefficients"));
  //-----
  //********** Steady Flight Condition **********
  parameter SIunits.Velocity U1_par = 67.3295 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter SIunits.Pressure q1bar_par = 2384.17 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  /* ---------------------------------------------
                      Internal variables
                --------------------------------------------- */
  redeclare Real x[5](start = x0, final quantity = {"Angle", "AngularVelocity", "AngularVelocity", "Angle", "Angle"}) "State vector" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  redeclare Real u[2] "Input vector" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  redeclare Real y[6] "output vector" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  //---
  /* ---------------------------------------------
                    Internal objects
                --------------------------------------------- */
  inner outer AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discrete AircraftDynamics.RigidBodyFDM.Components.DerivativesLateralNonDim2Dim00 DerLateral annotation(
    Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  /* ---------------------------------------------
                          Interface
        --------------------------------------------- */
  AircraftDynamics.Types.InfoBus infoBus1 annotation(
    Placement(visible = true, transformation(origin = {120, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {140, -150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  Modelica.Blocks.Interfaces.RealOutput y_beta(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {130, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_p(final quantity = "AngularVelocity", final unit = "rad/s") annotation(
    Placement(visible = true, transformation(origin = {130, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_r(final quantity = "AngularVelocity", final unit = "rad/s") annotation(
    Placement(visible = true, transformation(origin = {130, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_phi(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {130, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_psi(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {130, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_aY(final quantity = "Acceleration", final unit = "m/s2", displayUnit = "m/s2") annotation(
    Placement(visible = true, transformation(origin = {130, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {160, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  Modelica.Blocks.Interfaces.RealInput u_q1bar(final quantity = "Pressure", unit = "Pa", displayUnit = "Pa") if use_u_q1bar "dynamic pressure, input" annotation(
    Placement(visible = true, transformation(origin = {-140, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-160, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_S(final quantity = "Area", unit = "m2", displayUnit = "m2") if use_u_S annotation(
    Placement(visible = true, transformation(origin = {-100, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-120, 160}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_U1(final quantity = "Velocity", unit = "m/s", displayUnit = "m/s") if use_u_U1 annotation(
    Placement(visible = true, transformation(origin = {-140, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-160, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_m(final quantity = "Mass", unit = "kg", displayUnit = "kg") if use_u_m "mass" annotation(
    Placement(visible = true, transformation(origin = {-60, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 160}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_Ixx(final quantity = "MomentOfInertia", unit = "kg.m2", displayUnit = "kg.m2") if use_u_Ixx annotation(
    Placement(visible = true, transformation(origin = {-20, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 160}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_Izz(final quantity = "MomentOfInertia", unit = "kg.m2", displayUnit = "kg.m2") if use_u_Izz annotation(
    Placement(visible = true, transformation(origin = {20, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {40, 160}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_Ixz(final quantity = "MomentOfInertia", unit = "kg.m2", displayUnit = "kg.m2") if use_u_Ixz annotation(
    Placement(visible = true, transformation(origin = {60, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {80, 160}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_b(final quantity = "Length", unit = "m", displayUnit = "m") if use_u_b "wing span" annotation(
    Placement(visible = true, transformation(origin = {100, 140}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 160}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  //---
  Modelica.Blocks.Interfaces.RealInput u_deltaA(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {-140, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-160, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaR(final quantity = "Angle", final unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {-140, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-160, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //---
  //********************************************************************************
  AircraftDynamics.Interfaces.VisualizerInfoOut00 VisInfoOut annotation(
    Placement(visible = true, transformation(origin = {60, -100}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {100, -150}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
protected
  /* ---------------------------------------------
                      calculated parameters
          --------------------------------------------- */
  redeclare parameter Real A[5, 5](each fixed = false) annotation(
    fixed = false,
    HideResult = false);
  redeclare parameter Real B[5, 2](each fixed = false) annotation(
    fixed = false,
    HideResult = false);
  redeclare parameter Real C[6, 5](each fixed = false) annotation(
    fixed = false,
    HideResult = false);
  redeclare parameter Real D[6, 2](each fixed = false) annotation(
    fixed = false,
    HideResult = false);
  redeclare parameter Real x0[5](each fixed = false) "Initial state vector" annotation(
    HideResult = false);
  //-----
  parameter SIunits.Acceleration g(fixed = false) "";
  parameter SIunits.Velocity U1(fixed = false) "";
  parameter SIunits.Pressure q1bar(fixed = false) "";
  parameter SIunits.Area S(fixed = false) "";
  parameter SIunits.Length b(fixed = false) "";
  parameter SIunits.Mass m(fixed = false) "";
  parameter SIunits.MomentOfInertia Ixx(fixed = false) "";
  parameter SIunits.MomentOfInertia Izz(fixed = false) "";
  parameter SIunits.MomentOfInertia Ixz(fixed = false) "";
  //---
  parameter Real Ybeta_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Yp_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Yr_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Yphi_pri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real Lbeta_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Lp_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Lr_pri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real Nbeta_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Np_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real Nr_pri(fixed = false) annotation(
    HideResult = false);
  //-----
  parameter Real YdeltaA_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real YdeltaR_pri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real LdeltaA_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real LdeltaR_pri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real NdeltaA_pri(fixed = false) annotation(
    HideResult = false);
  parameter Real NdeltaR_pri(fixed = false) annotation(
    HideResult = false);
  //---
  //----------
  //---
  parameter Real Ybeta_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real Yp_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real Yr_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real Yphi_ppri(fixed = false) annotation(
    HideResult = false);
  //---
  parameter Real YdeltaA_ppri(fixed = false) annotation(
    HideResult = false);
  parameter Real YdeltaR_ppri(fixed = false) annotation(
    HideResult = false);
  //---
  //********************************************************************************
initial equation
//----- Dimentional derivatives -----
  Ybeta_pri = DerLateral.Ybeta_pri;
  Yp_pri = DerLateral.Yp_pri;
  Yr_pri = DerLateral.Yr_pri;
  Yphi_pri = DerLateral.Yphi_pri;
//---
  Lbeta_pri = DerLateral.Lbeta_pri;
  Lp_pri = DerLateral.Lp_pri;
  Lr_pri = DerLateral.Lr_pri;
//---
  Nbeta_pri = DerLateral.Nbeta_pri;
  Np_pri = DerLateral.Np_pri;
  Nr_pri = DerLateral.Nr_pri;
//-----
  YdeltaA_pri = DerLateral.YdeltaA_pri;
  YdeltaR_pri = DerLateral.YdeltaR_pri;
//---
  LdeltaA_pri = DerLateral.LdeltaA_pri;
  LdeltaR_pri = DerLateral.LdeltaR_pri;
//---
  NdeltaA_pri = DerLateral.NdeltaA_pri;
  NdeltaR_pri = DerLateral.NdeltaR_pri;
//---
//----------
  Ybeta_ppri = DerLateral.Ybeta_ppri;
  Yp_ppri = DerLateral.Yp_ppri;
  Yr_ppri = DerLateral.Yr_ppri;
  Yphi_ppri = DerLateral.Yphi_ppri;
//---
  YdeltaA_ppri = DerLateral.YdeltaA_ppri;
  YdeltaR_ppri = DerLateral.YdeltaR_ppri;
/**/
//----- test -----
/*  Ybeta_pri = -0.2356;
  Yp_pri = -0.0006;
  Yr_pri = -0.99671;
  Yphi_pri = 0.0551;
//---
  Lbeta_pri = -60.0566;
  Lp_pri = -4.9625;
  Lr_pri = 3.8814;
//---
  Nbeta_pri = 13.1748;
  Np_pri = 0.030895;
  Nr_pri = -0.40815;
//-----
  YdeltaA_pri = 0.0;
  YdeltaR_pri = 0.006598;
//---
  LdeltaA_pri = 56.7314;
  LdeltaR_pri = 26.6886;
//---
  NdeltaA_pri = 0.99368;
  NdeltaR_pri = -9.6945;
*/
//***** matrices of state space equation *****
  A = [Ybeta_pri, Yp_pri, Yr_pri, Yphi_pri, 0.0; Lbeta_pri, Lp_pri, Lr_pri, 0.0, 0.0; Nbeta_pri, Np_pri, Nr_pri, 0.0, 0.0; 0.0, 1.0, tan(theta1), 0.0, 0.0; 0.0, 0.0, 1.0 / cos(theta1), 0.0, 0.0];
  B = [YdeltaA_pri, YdeltaR_pri; LdeltaA_pri, LdeltaR_pri; NdeltaA_pri, NdeltaR_pri; 0.0, 0.0; 0.0, 0.0];
  C = [Ybeta_ppri, Yp_ppri, Yr_ppri, Yphi_ppri, 0.0; 1.0, 0.0, 0.0, 0.0, 0.0; 0.0, 1.0, 0.0, 0.0, 0.0; 0.0, 0.0, 1.0, 0.0, 0.0; 0.0, 0.0, 0.0, 1.0, 0.0; 0.0, 0.0, 0.0, 0.0, 1.0];
  D = [YdeltaA_ppri, YdeltaR_ppri; 0.0, 0.0; 0.0, 0.0; 0.0, 0.0; 0.0, 0.0; 0.0, 0.0];
//***** initial condition *****
  g = environmentAircraftDynSim.gravity;
//---
  x0[1] = beta0;
  x0[2] = p0;
  x0[3] = r0;
  x0[4] = phi0;
  x0[5] = psi0;
//---
//***** flight condition *****
  if use_u_U1 == true then
    U1 = u_U1;
  else
    U1 = U1_par;
  end if;
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
  if use_u_b == true then
    b = u_b;
  else
    b = b_par;
  end if;
  if use_u_m == true then
    m = u_m;
  else
    m = m_par;
  end if;
  if use_u_Ixx == true then
    Ixx = u_Ixx;
  else
    Ixx = Ixx_par;
  end if;
  if use_u_Izz == true then
    Izz = u_Izz;
  else
    Izz = Izz_par;
  end if;
  if use_u_Ixz == true then
    Ixz = u_Ixz;
  else
    Ixz = Ixz_par;
  end if;
//---
//********************************************************************************
initial algorithm
//********************************************************************************
equation
/* ---------------------------------------------
    Connections, interface <-> internal variables
  --------------------------------------------- */
//---
  u[1] = u_deltaA;
  u[2] = u_deltaR;
//---
  y_beta = beta1 + x[1];
  y_p = p1 + x[2];
  y_r = r1 + x[3];
  y_phi = phi1 + x[4];
  y_psi = psi1 + x[5];
  y_aY = y[1];
//-----
  VisInfoOut.r[1] = 0.0;
  VisInfoOut.r[2] = 0.0;
  VisInfoOut.r[3] = 0.0;
  VisInfoOut.theta[1] = y_phi;
  VisInfoOut.theta[2] = 0.0;
  VisInfoOut.theta[3] = y_psi;
  VisInfoOut.alpha= 0.0;
  VisInfoOut.beta=y_beta;
//-----

//----- flight condition -----
  connect(DerLateral.infoBusFlt.U1, U1);
  connect(DerLateral.infoBusFlt.q1bar, q1bar);
  connect(DerLateral.infoBusFlt.g, g);
  connect(DerLateral.infoBusFlt.theta1, theta1);
//---
//----- aircraft characteristics -----
  connect(DerLateral.infoBusAircraft.S, S);
  connect(DerLateral.infoBusAircraft.m, m);
  connect(DerLateral.infoBusAircraft.b, b);
  connect(DerLateral.infoBusAircraft.Ixx, Ixx);
  connect(DerLateral.infoBusAircraft.Izz, Izz);
  connect(DerLateral.infoBusAircraft.Ixz, Ixz);
//---
//----- Non-dimentional coefficients/derivatives -----
  connect(DerLateral.infoBusNonDim.CYbeta, CYbeta);
  connect(DerLateral.infoBusNonDim.CYp, CYp);
  connect(DerLateral.infoBusNonDim.CYr, CYr);
  connect(DerLateral.infoBusNonDim.CYdeltaA, CYdeltaA);
  connect(DerLateral.infoBusNonDim.CYdeltaR, CYdeltaR);
//---
  connect(DerLateral.infoBusNonDim.Clbeta, Clbeta);
  connect(DerLateral.infoBusNonDim.Clp, Clp);
  connect(DerLateral.infoBusNonDim.Clr, Clr);
  connect(DerLateral.infoBusNonDim.CldeltaA, CldeltaA);
  connect(DerLateral.infoBusNonDim.CldeltaR, CldeltaR);
//---
  connect(DerLateral.infoBusNonDim.Cnbeta, Cnbeta);
  connect(DerLateral.infoBusNonDim.Cnp, Cnp);
  connect(DerLateral.infoBusNonDim.Cnr, Cnr);
  connect(DerLateral.infoBusNonDim.CndeltaA, CndeltaA);
  connect(DerLateral.infoBusNonDim.CndeltaR, CndeltaR);
//---
  connect(DerLateral.infoBusNonDim.CYdeltaS, CYdeltaS);
  connect(DerLateral.infoBusNonDim.CYdeltaF, CYdeltaF);
  connect(DerLateral.infoBusNonDim.CldeltaS, CldeltaS);
  connect(DerLateral.infoBusNonDim.CldeltaF, CldeltaF);
  connect(DerLateral.infoBusNonDim.CndeltaS, CndeltaS);
  connect(DerLateral.infoBusNonDim.CndeltaF, CndeltaF);
/**/
/********************************************************
  Graphics
********************************************************/
  annotation(
    defaultComponentName = "FltDynLateralSS",
    Icon(graphics = {Text(origin = {-35, -166}, extent = {{-109, 8}, {171, -14}}, textString = "%name")}, coordinateSystem(extent = {{-150, -150}, {150, 150}}, initialScale = 0.1)),
    __OpenModelica_commandLineOptions = "",
    Diagram(coordinateSystem(extent = {{-120, -100}, {120, 120}})));
end LateralLTISS00;
