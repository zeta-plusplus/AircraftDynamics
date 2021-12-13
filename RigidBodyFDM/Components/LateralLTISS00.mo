within AircraftDynamics.RigidBodyFDM.Components;

block LateralLTISS00 "Lateral/Directional FDM with Linear Time Invariant Steady State equations"
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
    Placement(visible = true, transformation(origin = {120, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, -150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
  
  //***** flight condition *****
  /*
  DerLateral.U1 = U1;
  DerLateral.q1bar = q1bar;
  DerLateral.g = environmentAircraftDynSim.gravity;
  DerLateral.theta1 = theta1;
  */
//---
//***** aircraft characteristics *****
  /*
  DerLateral.S = S;
  DerLateral.m = m;
  DerLateral.b = b;
  DerLateral.Ixx = Ixx;
  DerLateral.Izz = Izz;
  DerLateral.Ixz = Ixz;
  */
//---
//***** Non-dimentional coefficients/derivatives *****
  /*
  DerLateral.CYbeta = CYbeta;
  DerLateral.CYp = CYp;
  DerLateral.CYr = CYr;
  DerLateral.CYdeltaA = CYdeltaA;
  DerLateral.CYdeltaR = CYdeltaR;
  */
//---
  /*
  DerLateral.Clbeta = Clbeta;
  DerLateral.Clp = Clp;
  DerLateral.Clr = Clr;
  DerLateral.CldeltaA = CldeltaA;
  DerLateral.CldeltaR = CldeltaR;
  */
//---
  /*
  DerLateral.Cnbeta = Cnbeta;
  DerLateral.Cnp = Cnp;
  DerLateral.Cnr = Cnr;
  DerLateral.CndeltaA = CndeltaA;
  DerLateral.CndeltaR = CndeltaR;
  */
//---
  /*
  DerLateral.CYdeltaS = CYdeltaS;
  DerLateral.CYdeltaF = CYdeltaF;
  DerLateral.CldeltaS = CldeltaS;
  DerLateral.CldeltaF = CldeltaF;
  DerLateral.CndeltaS = CndeltaS;
  DerLateral.CndeltaF = CndeltaF;
  */
  
  //***** Dimentional derivatives *****
  
  Ybeta_pri = DerLateral.Ybeta_pri;
  Yp_pri = DerLateral.Yp_pri;
  Yr_pri = DerLateral.Yr_pri;
  Yphi_pri = DerLateral.Yphi_pri;
  /**/
//---
  
  Lbeta_pri = DerLateral.Lbeta_pri;
  Lp_pri = DerLateral.Lp_pri;
  Lr_pri = DerLateral.Lr_pri;
  /**/
//---
  
  Nbeta_pri = DerLateral.Nbeta_pri;
  Np_pri = DerLateral.Np_pri;
  Nr_pri = DerLateral.Nr_pri;
  /**/
//-----
  
  YdeltaA_pri = DerLateral.YdeltaA_pri;
  YdeltaR_pri = DerLateral.YdeltaR_pri;
  /**/
//---
  
  LdeltaA_pri = DerLateral.LdeltaA_pri;
  LdeltaR_pri = DerLateral.LdeltaR_pri;
  /**/
//---
  
  NdeltaA_pri = DerLateral.NdeltaA_pri;
  NdeltaR_pri = DerLateral.NdeltaR_pri;
  /**/
//---
//----------
  
  Ybeta_ppri = DerLateral.Ybeta_ppri;
  Yp_ppri = DerLateral.Yp_ppri;
  Yr_ppri = DerLateral.Yr_ppri;
  Yphi_ppri = DerLateral.Yphi_ppri;
  /**/
//---
  
  YdeltaA_ppri = DerLateral.YdeltaA_ppri;
  YdeltaR_ppri = DerLateral.YdeltaR_ppri;
  /**/
  
  
  
  
  
  
  //***** flight condition *****
  /*
  DerLateral.infoBusFlt.U1 = U1;
  DerLateral.infoBusFlt.q1bar = q1bar;
  DerLateral.infoBusFlt.g = environmentAircraftDynSim.gravity;
  DerLateral.infoBusFlt.theta1 = theta1;
  */
//---
//***** aircraft characteristics *****
  /*
  DerLateral.infoBusAircraft.S = S;
  DerLateral.infoBusAircraft.m = m;
  DerLateral.infoBusAircraft.b = b;
  DerLateral.infoBusAircraft.Ixx = Ixx;
  DerLateral.infoBusAircraft.Izz = Izz;
  DerLateral.infoBusAircraft.Ixz = Ixz;
  */
//---
//***** Non-dimentional coefficients/derivatives *****
  /*
  DerLateral.infoBusNonDim.CYbeta = CYbeta;
  DerLateral.infoBusNonDim.CYp = CYp;
  DerLateral.infoBusNonDim.CYr = CYr;
  DerLateral.infoBusNonDim.CYdeltaA = CYdeltaA;
  DerLateral.infoBusNonDim.CYdeltaR = CYdeltaR;
  */
//---
  /*
  DerLateral.infoBusNonDim.Clbeta = Clbeta;
  DerLateral.infoBusNonDim.Clp = Clp;
  DerLateral.infoBusNonDim.Clr = Clr;
  DerLateral.infoBusNonDim.CldeltaA = CldeltaA;
  DerLateral.infoBusNonDim.CldeltaR = CldeltaR;
  */
//---
  /*
  DerLateral.infoBusNonDim.Cnbeta = Cnbeta;
  DerLateral.infoBusNonDim.Cnp = Cnp;
  DerLateral.infoBusNonDim.Cnr = Cnr;
  DerLateral.infoBusNonDim.CndeltaA = CndeltaA;
  DerLateral.infoBusNonDim.CndeltaR = CndeltaR;
  */
//---
  /*
  DerLateral.infoBusNonDim.CYdeltaS = CYdeltaS;
  DerLateral.infoBusNonDim.CYdeltaF = CYdeltaF;
  DerLateral.infoBusNonDim.CldeltaS = CldeltaS;
  DerLateral.infoBusNonDim.CldeltaF = CldeltaF;
  DerLateral.infoBusNonDim.CndeltaS = CndeltaS;
  DerLateral.infoBusNonDim.CndeltaF = CndeltaF;
  */
  
  //***** Dimentional derivatives *****
  /*
  Ybeta_pri = DerLateral.infoBusDim.Ybeta_pri;
  Yp_pri = DerLateral.infoBusDim.Yp_pri;
  Yr_pri = DerLateral.infoBusDim.Yr_pri;
  Yphi_pri = DerLateral.infoBusDim.Yphi_pri;
  */
//---
  /*
  Lbeta_pri = DerLateral.infoBusDim.Lbeta_pri;
  Lp_pri = DerLateral.infoBusDim.Lp_pri;
  Lr_pri = DerLateral.infoBusDim.Lr_pri;
  */
//---
  /*
  Nbeta_pri = DerLateral.infoBusDim.Nbeta_pri;
  Np_pri = DerLateral.infoBusDim.Np_pri;
  Nr_pri = DerLateral.infoBusDim.Nr_pri;
  */
//-----
  /*
  YdeltaA_pri = DerLateral.infoBusDim.YdeltaA_pri;
  YdeltaR_pri = DerLateral.infoBusDim.YdeltaR_pri;
  */
//---
  /*
  LdeltaA_pri = DerLateral.infoBusDim.LdeltaA_pri;
  LdeltaR_pri = DerLateral.infoBusDim.LdeltaR_pri;
  */
//---
  /*
  NdeltaA_pri = DerLateral.infoBusDim.NdeltaA_pri;
  NdeltaR_pri = DerLateral.infoBusDim.NdeltaR_pri;
  */
//---
//----------
  /*
  Ybeta_ppri = DerLateral.infoBusDim.Ybeta_ppri;
  Yp_ppri = DerLateral.infoBusDim.Yp_ppri;
  Yr_ppri = DerLateral.infoBusDim.Yr_ppri;
  Yphi_ppri = DerLateral.infoBusDim.Yphi_ppri;
  */
//---
  /*
  YdeltaA_ppri = DerLateral.infoBusDim.YdeltaA_ppri;
  YdeltaR_ppri = DerLateral.infoBusDim.YdeltaR_ppri;
  */
//---
/**/
//***** test *****
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
  //***** flight condition *****
  /*
  //DerLateral.infoBusFlt.U1 := U1;
  DerLateral.infoBusFlt.q1bar := q1bar;
  DerLateral.infoBusFlt.g := environmentAircraftDynSim.gravity;
  DerLateral.infoBusFlt.theta1 := theta1;
  */
  //---
//***** aircraft characteristics *****
  /*
  DerLateral.infoBusAircraft.S := S;
  DerLateral.infoBusAircraft.m := m;
  DerLateral.infoBusAircraft.b := b;
  DerLateral.infoBusAircraft.Ixx := Ixx;
  DerLateral.infoBusAircraft.Izz := Izz;
  DerLateral.infoBusAircraft.Ixz := Ixz;
  */
//---
//***** Non-dimentional coefficients/derivatives *****
  /*
  DerLateral.infoBusNonDim.CYbeta := CYbeta;
  DerLateral.infoBusNonDim.CYp := CYp;
  DerLateral.infoBusNonDim.CYr := CYr;
  DerLateral.infoBusNonDim.CYdeltaA := CYdeltaA;
  DerLateral.infoBusNonDim.CYdeltaR := CYdeltaR;
  */
//---
  /*
  DerLateral.infoBusNonDim.Clbeta := Clbeta;
  DerLateral.infoBusNonDim.Clp := Clp;
  DerLateral.infoBusNonDim.Clr := Clr;
  DerLateral.infoBusNonDim.CldeltaA := CldeltaA;
  DerLateral.infoBusNonDim.CldeltaR := CldeltaR;
  */
//---
  /*
  DerLateral.infoBusNonDim.Cnbeta := Cnbeta;
  DerLateral.infoBusNonDim.Cnp := Cnp;
  DerLateral.infoBusNonDim.Cnr := Cnr;
  DerLateral.infoBusNonDim.CndeltaA := CndeltaA;
  DerLateral.infoBusNonDim.CndeltaR := CndeltaR;
  */
//---
  /*
  DerLateral.infoBusNonDim.CYdeltaS := CYdeltaS;
  DerLateral.infoBusNonDim.CYdeltaF := CYdeltaF;
  DerLateral.infoBusNonDim.CldeltaS := CldeltaS;
  DerLateral.infoBusNonDim.CldeltaF := CldeltaF;
  DerLateral.infoBusNonDim.CndeltaS := CndeltaS;
  DerLateral.infoBusNonDim.CndeltaF := CndeltaF;
  */
  //------------------------------------------------------------
  //***** Dimentional derivatives *****
  /*
  Ybeta_pri := DerLateral.infoBusDim.Ybeta_pri;
  Yp_pri := DerLateral.infoBusDim.Yp_pri;
  Yr_pri := DerLateral.infoBusDim.Yr_pri;
  Yphi_pri := DerLateral.infoBusDim.Yphi_pri;
  */
//---
  /*
  Lbeta_pri := DerLateral.infoBusDim.Lbeta_pri;
  Lp_pri := DerLateral.infoBusDim.Lp_pri;
  Lr_pri := DerLateral.infoBusDim.Lr_pri;
  */
//---
  /*
  Nbeta_pri := DerLateral.infoBusDim.Nbeta_pri;
  Np_pri := DerLateral.infoBusDim.Np_pri;
  Nr_pri := DerLateral.infoBusDim.Nr_pri;
  */
//-----
  /*
  YdeltaA_pri := DerLateral.infoBusDim.YdeltaA_pri;
  YdeltaR_pri := DerLateral.infoBusDim.YdeltaR_pri;
  */
//---
  /*
  LdeltaA_pri := DerLateral.infoBusDim.LdeltaA_pri;
  LdeltaR_pri := DerLateral.infoBusDim.LdeltaR_pri;
  */
//---
  /*
  NdeltaA_pri := DerLateral.infoBusDim.NdeltaA_pri;
  NdeltaR_pri := DerLateral.infoBusDim.NdeltaR_pri;
  */
//---
//----------
  /*
  Ybeta_ppri := DerLateral.infoBusDim.Ybeta_ppri;
  Yp_ppri := DerLateral.infoBusDim.Yp_ppri;
  Yr_ppri := DerLateral.infoBusDim.Yr_ppri;
  Yphi_ppri := DerLateral.infoBusDim.Yphi_ppri;
  */
//---
  /*
  YdeltaA_ppri := DerLateral.infoBusDim.YdeltaA_ppri;
  YdeltaR_ppri := DerLateral.infoBusDim.YdeltaR_ppri;
  */
  
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
  
  //----- flight condition -----
  connect(DerLateral.infoBusFlt.U1 , U1);
  connect(DerLateral.infoBusFlt.q1bar , q1bar);
  connect(DerLateral.infoBusFlt.g , environmentAircraftDynSim.gravity);
  connect(DerLateral.infoBusFlt.theta1 , theta1);
  
//---
//----- aircraft characteristics -----
  connect(DerLateral.infoBusAircraft.S , S);
  connect(DerLateral.infoBusAircraft.m , m);
  connect(DerLateral.infoBusAircraft.b , b);
  connect(DerLateral.infoBusAircraft.Ixx , Ixx);
  connect(DerLateral.infoBusAircraft.Izz , Izz);
  connect(DerLateral.infoBusAircraft.Ixz , Ixz);
//---
  
  //----- Non-dimentional coefficients/derivatives -----
  connect(DerLateral.infoBusNonDim.CYbeta , CYbeta);
  connect(DerLateral.infoBusNonDim.CYp , CYp);
  connect(DerLateral.infoBusNonDim.CYr , CYr);
  connect(DerLateral.infoBusNonDim.CYdeltaA , CYdeltaA);
  connect(DerLateral.infoBusNonDim.CYdeltaR , CYdeltaR);
  //---
  connect(DerLateral.infoBusNonDim.Clbeta , Clbeta);
  connect(DerLateral.infoBusNonDim.Clp , Clp);
  connect(DerLateral.infoBusNonDim.Clr , Clr);
  connect(DerLateral.infoBusNonDim.CldeltaA , CldeltaA);
  connect(DerLateral.infoBusNonDim.CldeltaR , CldeltaR);
  //---
  connect(DerLateral.infoBusNonDim.Cnbeta , Cnbeta);
  connect(DerLateral.infoBusNonDim.Cnp , Cnp);
  connect(DerLateral.infoBusNonDim.Cnr , Cnr);
  connect(DerLateral.infoBusNonDim.CndeltaA , CndeltaA);
  connect(DerLateral.infoBusNonDim.CndeltaR , CndeltaR);
  //---
  connect(DerLateral.infoBusNonDim.CYdeltaS , CYdeltaS);
  connect(DerLateral.infoBusNonDim.CYdeltaF , CYdeltaF);
  connect(DerLateral.infoBusNonDim.CldeltaS , CldeltaS);
  connect(DerLateral.infoBusNonDim.CldeltaF , CldeltaF);
  connect(DerLateral.infoBusNonDim.CndeltaS , CndeltaS);
  connect(DerLateral.infoBusNonDim.CndeltaF , CndeltaF);
  
  
/* ---------------------------------------------
    Eqns describing physics
  --------------------------------------------- */
  //connect(DerLateral.infoBusFlt.U1, U1);
  
  
  //when initial() then
//***** flight condition *****
    /*
    //DerLateral.infoBusFlt.U1 = U1;
    DerLateral.infoBusFlt.q1bar = q1bar;
    DerLateral.infoBusFlt.g = environmentAircraftDynSim.gravity;
    DerLateral.infoBusFlt.theta1 = theta1;
    */
//---
//***** aircraft characteristics *****
    /*
    DerLateral.infoBusAircraft.S = S;
    DerLateral.infoBusAircraft.m = m;
    DerLateral.infoBusAircraft.b = b;
    DerLateral.infoBusAircraft.Ixx = Ixx;
    DerLateral.infoBusAircraft.Izz = Izz;
    DerLateral.infoBusAircraft.Ixz = Ixz;
    */
//---
//***** Non-dimentional coefficients/derivatives *****
    /*
    DerLateral.infoBusNonDim.CYbeta = CYbeta;
    DerLateral.infoBusNonDim.CYp = CYp;
    DerLateral.infoBusNonDim.CYr = CYr;
    DerLateral.infoBusNonDim.CYdeltaA = CYdeltaA;
    DerLateral.infoBusNonDim.CYdeltaR = CYdeltaR;
    */
//---
    /*
    DerLateral.infoBusNonDim.Clbeta = Clbeta;
    DerLateral.infoBusNonDim.Clp = Clp;
    DerLateral.infoBusNonDim.Clr = Clr;
    DerLateral.infoBusNonDim.CldeltaA = CldeltaA;
    DerLateral.infoBusNonDim.CldeltaR = CldeltaR;
    */
//---
    /*
    DerLateral.infoBusNonDim.Cnbeta = Cnbeta;
    DerLateral.infoBusNonDim.Cnp = Cnp;
    DerLateral.infoBusNonDim.Cnr = Cnr;
    DerLateral.infoBusNonDim.CndeltaA = CndeltaA;
    DerLateral.infoBusNonDim.CndeltaR = CndeltaR;
    */
//---
    /*
    DerLateral.infoBusNonDim.CYdeltaS = CYdeltaS;
    DerLateral.infoBusNonDim.CYdeltaF = CYdeltaF;
    DerLateral.infoBusNonDim.CldeltaS = CldeltaS;
    DerLateral.infoBusNonDim.CldeltaF = CldeltaF;
    DerLateral.infoBusNonDim.CndeltaS = CndeltaS;
    DerLateral.infoBusNonDim.CndeltaF = CndeltaF;
    */
/**/
  //end when;
//-----
/**/
/********************************************************
  Graphics
********************************************************/
  annotation(
    defaultComponentName = "FltDynLateralSS",
    Icon(graphics = {Rectangle(origin = {66, 152}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-216, -2}, {84, -302}}), Text(origin = {-33, -130}, extent = {{-109, 8}, {171, -14}}, textString = "%name"), Bitmap(origin = {34, 19}, extent = {{-172, 127}, {108, -139}}, imageSource = "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xwSCM44NAHzb/wAEsv8Akxf4df7+p/8Apxua+sK8/wDgN8E9B/Z3+FejeAPDNxf3Wi6SZjBNqcqSXDebM8zbmREU/NI2MKOMV6BQAUUUUAFFFFAHm/xI+Dv/AAsL4jfDLxV/a/2D/hC9Rur/AOyfZvM+2edbPBs37x5eN+7OGzjGB1r0iiihabev5L9Aeru/T83+rCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooryH4r/tVfDn4Pma31bW1vtWjyDpWlgT3APo2DtQ/wC+wrWnSnWly043ZEpxpq8nZHr1VNU1ex0OxkvdSvbfT7OMZe4upVijX6sxAFfnr44/b8+InxE1P+yPh3oI0ZZspF5MBvr+TJxkDbtXqOApIP8AFWRpH7IXxz+OF0uqeMtRl02N/nEviO9eSbB/uwruKfRtlezHKnTXNiqigvvZwPGqTtRi5fkfYHir9sz4QeEpXhm8XQajOv8Ayz0uGS6B/wCBopT/AMerzLWP+ClHw/tQRpvh7xDfuO8scMKH8fMY/pVXwj/wTV8HafHG/iLxLq2szgZZLNY7SIn0wQ7Y/wCBCvU9H/Yq+DWjqNng2K6cdXvLy4mz+DSbf0p/8JdLT3p/h/kL/bJ9o/18z5v8Qf8ABTfWpsjQ/A1hZejahfPcZ98Isf8AOuO1L9tj49a/YXWo6faRabp9tC089xp2iGSGGNQSzs8okCqBkkk4AFfoL4e+E3gnwmyto3hHRNMdeklrp8SP/wB9Bc/rWB+00Av7NvxXAGB/wiWrf+kctL69g6f8LDr5u/8AmH1evL46v3HwX4T+K37Tnxn0ODW/DOqa5rOjXRdYdQ0u3git5CjFWCyIqqcMCp56gjtWv/wrr9rq4Oftfiwd/wDkYY0/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ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACuB/aA0a+8R/Ab4k6TplrJfalf8AhrUrW1tYV3PNK9rIqIo7ksQB9a76igD5o/4JyeA/EXwz/ZC8GeHfFWjXmga5ay37T2F9EY5Yw95M6ZU+qsp/GvpeiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooryT4qftafB/wCCvnJ4w+IOi6XdxZ36fHcfabwY/wCmEQaT/wAdoA9bor4S8Wf8FbvAkO+PwX4B8X+MJR924mt49OtH9MSOzN+cdeMeLP8Agpl8dPFG9PDvhPwl4Htm/jvpZdSuk+jApGT9Urhq47DUP4lRL5/ofU5fwtnmaWeDwdSSfXlaX/gTsvxP1Upk0yW8bSSuscajLO5wAPUmvxM8SfHr47eOZHfXvjV4lhD/APLLw95ekoo9B5CqfxPNec6x4Qj8USeZ4j1fXPE8uc79Y1We4JPry1eTU4gwUPhbl6L/ADsfoWE8IeJ8Sk6sYUv8U7/+kKR+2nir9pL4T+CN4174l+E9KkXrDc6zbrL+Cb9x/AV5lq3/AAUi/Zt0Xd9o+KWnyY/59LK7uf8A0XC1fkzZ+A/Dun48nRbIEdGeEOfzbJrXhsre2/1NvFF/uIB/KvPnxNTXwUm/V2/zPr8P4H4yS/2nHRi/7sHL83E/STUP+CrH7P1vn7FrGvaz6fYdBuefp5ipXmfxk/4KjfDfxx8LvGXhjRPBXxCu7zWtGvdOguG0aFIEkmgeNWYmfdtBYZwpOM8V8W0Vyy4mqfZpL7/+Ae7S8D8JH+LjpP0gl+cm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k1loNp56lcfvnjEkvH++7V6rQAUUUUAFFFFABRRRQAUUUUAY3ijwX4f8cacdP8R6FpviCwOc2uqWcdzEc9fldSK+b/Hn/BMr4A+NpZLmz8K3Hg3UX/5fPC19JZlfpHloh/3xX1TRSaTVmXCcqclKDs12Pza8Zf8ABJ/xXpO+XwD8XBexj7mn+LtOD/Tdcwnd/wCQ68K8Zfsk/tEfDne+pfDRfFNmnW+8I3yXW7/dgbEx/wC+a/ZqivLrZXgq/wAdNfLT8j7zLePeJcrsqGNk0ukvfX/k17fKx+AeoeMrTw/qP9neIrPUvCupDrZa9Yy2ko+oYcfnV241u0bR7u+tLqG5ihheTzIZA68KT1H0r92/EXhfRvF2nPp+u6RY61YP9611G2S4ib6q4Ir5x+In/BNL9nz4hedL/wAIQvhi9kBU3Xhm5kscA9QIlJhx9UrxKnDdBu9ObXrr/kfp2D8a80hTcMbhoTdtHFuL9deZP5WNf/gnf4Z/4RT9i/4WWZXa0+mvqB9T9onknB/KUV9F1g+AfBth8OfAvh3wppZlbTNC0630y1aYgyGKGJY0LEAAthRnAHPat6vsD+cgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooqO4uIrWCSaaRIYY1LvJIwVVUDJJJ6ACgD5o/bk+M2s+EPB2kfDjwNMR8SfiFM2laa8Z+awtcf6Xet3AjjJwRyCcjO01wepfDSw+Ef7N134F8I6LdX8K6W+lRQ2UQaaWWdTG9w4zySzl2PbnoBxzvwN1CX9oL4weNfj5qCOdKvGbw74NhmB/daVBIQ84B6GaUM3HTDDoa9117Wbfw7oeo6tebhaWFtJdTeWMtsRSzYHc4BrxsRXTqpWuovbuedXm5PlXQ+aPgT+yPq/hP4a6V4U8V+JbxdAtTJL/YGnyhFkZ3Lv58q/eyW+6OBgYNeifsV3Fv8ACP47fE74PajDEHnZfFXhm/kjXzp9OlxHLbeZjcwhkCgAknBc9BXV/B34v+H/AI5eB7fxZ4ZN02kzzSQobuLypCyNtb5cnjIrzH9qa6l+FPiT4a/HGyR9/gjWEg1cRA5l0m7IguQQPvbSylQRwWJrohj69SryTdovotF936u7M6KUKnvbs++qKjgnjuoY5oZFlhkUOkkbBlZSMggjqCKkr0T1QrjviF8IPBvxUsWtfFHh6y1XK7VuJI9s8f8AuSrh1/A12NFXGUoPmi7MUoqSs0fNs3hX4n/s3q134Xvbr4neA4jul8P6i5bVLKPP/LtL/wAtQF/gPpgL3rs1T4T/ALY3w/jh1PS7Hxdo1tdCWTTNUhImsbkKyjemd0bhWcZBwQTgkV6/Xyzr/wAE/iHP+25pPjLQray8O/Dn+z1Oqahp06pdX9ypZjHNFnDK+UUnaSAmcg4Ndbqwrr97pLuuvqv1Xzuc6hKm/c1Xb/L/ACPqRFWNVVVCqowFUYAHpTqKK4TpCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK+Xf+Cg3xC1PRfhHp3w88Mz+T4v8AiVqCeG7J1zugtnGbyc4I+VIsqSDkeaD2r6ir4WOon44/txeNPE7MZvD3wxsl8LaUP4DqMwL30q/7SD9yfbFY1qns4ORE5csWz1nwV4R07wD4R0bw3pEPkaZpVpHZ26d9iKFBPqTjJPckms34uf8AJKfGn/YFvf8A0Q9dZVXVtLtdc0u802+i8+yvIXt54txXfG6lWXIIIyCelfMp63Z5F9bnzF/wTR/5NR0T/sIXv/o419C/EbwTZ/EjwD4h8LagB9j1ixmsnbGdm9Coce6khh7gVD8N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EHw/rEFv4S+Hlr4u09rcSSXs/iCPTykpZgY/LaJycAKd2f4sY4r0KigD5I/YB/Z38c/AU/FW58b2Nnp83ijX/wC1bSGzvFudsbeYSrMAOQWA96+t6KKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACvzB/wCC1F0W1T4DWPaW+1OQ/g1iB/6Ea/T6vzO/4LWacy6V8FtZ2ny7PVb6BpOymRbdwPx8k/lWdS7hK3Y7MHJRxNJy2Ul+Z8VVU1ZDJpN6g6tA4H/fJq3Udw0awv5zKkeMMzHAx9a/KIu0kz/QCtFTpSi3a6Z+l3/BH28S6/Y8gjQANb69fRPjuT5b/wAnFfblfnH/AMEUfFguPhL8R/CPmrI2j6/HfDBB+W4hEY/Am1Y/nX6OV+tLXU/z1lFxbi90Fct8VDj4YeLz/wBQe8/9EPXU15z+0R440D4e/BPxlq3iTV7TRdO/su5gWe7kCB5XidUjXuzsTgKMk9hTJPmT9ivj9lf4bf8AYLX/ANDava68W/Yu/wCTWfht/wBgpf8A0Nq6X4u/H7wT8EbO3bxPqwj1C7wLLR7NDPfXjFtoEUK/M2W4ycLnvXy805VGkup5Ek3JpHolZ3iX/kXdV/69Jf8A0A14/o9j+078bYUutB8MaD8GfDlx80V54tZ7zWDH0DC0QbY277JcY9al8e/sQ+LLL4d+Jta8SftE/ELVtQsdKursJo7w6TbSOkLNgxIrfKSOgPQ9a64YKo9XobRw8up47/wTN1a30H9k7WdTu38u0stYvrmZvREghZj+QNfDPiz4meKP2hvGVprevtFca5qPlWca20WxMbtsahfx/EnNeWeH/iv418LeHbzw/o3izWtM0K9WRLnS7W/ljtphIuyTdEG2ncvBOORXaeCfFcHw28QeHvEVzp/9qwaLd2121iZfK8/y5FbZvwducYzg/Q19xkNH2NWvi3raP/B/Q5cdDaPWT/r8z9xtD0mDQNF0/S7Ubbayt47aJfREUKv6AUmvNt0PUT6W0h/8dNeNfs+/tkfDr9ohYbPRtRbSvEzIWfQNTxHcHC5YxHO2VQAx+U5AGWVa9h8TNt8OaqfS0lP/AI4a/O5KUZe/uVyuLszO/wCCa67f2IvhcP8Ap0uj/wCTs9fTNfmr/wAE7f22vD/gD4JeAvAHxH0u48F6fJ59voHi25OdL1H/AEiUskkvSCRX3L83ykLnK5Gf0mhnjuoY5oZFlikUOkiEFWUjIII6givqmmtz2E09iSiiikMKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAr5C/4Kh/A7xD8dP2a4dO8J6Nca74i0zXLS/trO0UGV1IkgfHsBNuPYBc9q+vaKAPxh8E/8Ez/2mfHqwtrc+geALRgC63t4ss+31CwCXn2LrXvvgb/gi34VV4rj4g/ErX/E8w+ZoNLhSzjz/dLSGViPcbT9K/SGisKeHpUf4cUvkerjM2zDMP8Ae68p+sm192x4/wDAP9k34Y/szR3x+H+gSaTc38axXt1LfT3ElyFJK7w7lcgk42gYycdTn2CszxL4m0nwboN9revala6Po9jEZrq+vZVihhQdWZmOAK+HfiB+1b49/abu7nQPgiZ/BngBZTDe/Ei+gKXN6o4ZdOhYAgHp5rYI7bCBnrp05VZcsFdnjTqRpx5puyPav2iv2z/Dvwa1QeDvDWnzfEL4pXUZNp4W0hwTB/00u5fuwRjOTu+bGOADuHxt8afhP4o+JHw68e/ET41a6vifxVa+HdQuNK0KyLR6RoTC2kK+RFn55AQP3jZOQOpAavaPhV8GfDHwd0mW00GzZru5cy32q3jede30pOWeaU8sSSTjoMnAGao/tJalbaX+z78R5rudLeJvD99ArucAySQPHGv1Z2VR7kV9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r8RviHL45OhSzTeHdFt9Jj02y06SRShmdVd2nmEZKK7EBQzEKCcj3CihaSUlv/X9eQPVOPcKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKo65rmneGdIu9V1e/ttL0yzjM1xeXkqxQwoOrO7EBQPU15V+0N+1T4J/Zx022XXJ59V8T6iCuk+F9JTz9R1B+gCRj7q54LtgdcZPB+RNZ8JfED9qjVLfXvjbcDSfC0bpcad8M9JuG+yQsDlXvZBg3Ent90dsAla6aOHqYiVoI561eFBXmzsfiD+1941/aKvrnw18BVfw94PSVrbUfiZqVv/rAOGXToWwXbqPNbGO204Yx/Cf4J+GvhBY3H9lQzXus3p36lr2oyGe/v5Ccl5ZTyckk4GB7Zya7exsbbTbOG0s7eK0tYUEcUECBEjUDAVVHAA9BU9fUYbB08Or7y7nzWIxc8Q7bLsFFFFd5whRRRQAUUUUAFFFFABRRRQAUUUUAFcB+0F/yQT4lf9izqX/pLJXf1wH7QX/JBPiV/wBizqX/AKSyVnU+CXoaU/jXqdF+yT/ybL8Mv+wDa/8AosV61Xk37Jf/ACbN8Mv+wBaf+ixXrNfjNT436nvS+JhRRRUEhRRRQAVwX7QDbfgN8ST6eGtSP/krJXe157+0U239n34nN6eF9UP/AJKS1UPiRUd0eD/sHf8AJqPgf/t+/wDS64r32vAv2Dv+TUfA/wD2/f8ApdcV77X7Hh/4MPRfkeLiP40/V/mFFFFdBzhRRRQAUUUUAFFFFABRRRQAUUUUAFR3FvFdQSQzRpNDIpR45FDKykYIIPUEVJRQB4pa/Cvxj8AfEFz4q+AmrQ6OLiQTal4E1IltF1LHXy1628hHAZSB0HyjIP03+zv+2d4T+OGoP4X1S0uPAfxLtUzeeEdbOyYkdXt5CAtxHxkFecclQME8fXCfFX4K+FvjFp0MGvWTJf2rCSx1eyfyb6xkByHh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9Pin4fT/AMiSV7/XgP7WH7zXP2e4v7/xb8P5+gabNdGH/ixNaXxo+9KKKK+lPWCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKZJDHK0bPGrtG29GYAlWwRkehwSPoTT6KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDyr9rH/k1n4yf9iZrP8A6QzV5V/wS4/5MT+GX/cT/wDTpd16r+1j/wAms/GT/sTNZ/8ASGavKv8Aglx/yYn8Mv8AuJ/+nS7oA+qqKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACvL/ANqbn9mL4vD/AKk/WP8A0imr1CvMP2pOf2Zfi4P+pQ1f/wBIpaAPDv2Zf+Tcvhb/ANivpn/pLHXpVeafsx8/s4/C7/sWNN/9Jo69Lr5WfxM8aW7CiiioJCiiigArwP8Aai/eeNP2dY/X4p6M/wD3z5pr3yvBf2lR5nxM/Zyj9fiRpz/98pIa6cN/FibUvjR94UUUV9IeqFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAHlX7WP/JrPxk/7EzWf/SGavKv+CXH/ACYn8Mv+4n/6dLuvVf2sf+TWfjJ/2Jms/wDpDNXlX/BLj/kxP4Zf9xP/ANOl3QB9VUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFeZftPjP7NPxaH/Uo6t/6Ry16bXmv7TS7v2b/iuPXwnqw/8k5aAPBv2YDn9m/4Xf8AYs6d/wCk0dem15h+y6279m34X/8AYtaf/wCk6V6fXys/iZ40t2FFFFQSFFFFABXgn7RDiT40fs2W+Gy3jyCX7px8kT9+g6/z9DXvdeEfHj958fv2aofXxi0n/fNuxrpwv8aJtR+NH3bRRRX0h6oUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAeVftY/8AJrPxk/7EzWf/AEhmryr/AIJcf8mJ/DL/ALif/p0u69V/ax/5NZ+Mn/Ymaz/6QzV5V/wS4/5MT+GX/cT/APTpd0AfVVFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABXnf7RsZm/Z6+KEY5LeFtUX87SWvRK5z4kaC/ir4d+KdFQZfUtKurNQBnmSFkHH/AqAPlj9lOTzP2afhgR/wBC7ZD8oVFeqV4d+xDrS69+yn8Obhf+WWntaH2MMskJ/wDRde418tU0nL1PHl8TCiiisyAooooAK8L+MS/af2pP2ZLUclvEGoT49o7Mkn9a90rxXTbM+Pv+ChngDTm+a08CeEtQ8RcdPPu5BZhT6kJ8wrrwivWRvRV5o+4KKKK+iPUCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDyr9rH/k1n4yf9iZrP8A6QzV5V/wS4/5MT+GX/cT/wDTpd16r+1j/wAms/GT/sTNZ/8ASGavKv8Aglx/yYn8Mv8AuJ/+nS7oA+qqKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiqesaxYeH9LudS1S+ttN061Qyz3l5KsUMSDqzuxAUD1JoA+D/2HI/7M+EuvaCPlGg+LNY0wJ/d23LNj/x+voavmn9i/wAXaN4q1f47y+H7+PU9Fn+I2p6lZXUOdkkFxsZCuR935TivpavmsQrVZHk1fjYUUUVzmQUUUUAFeVfsqQ/8JB+2h+0LrRG6PR9P0LRYX9d8Mk0gH0YDP1r1Wvin9n/9prxH8D/ij8a/GF54HuPFPwy1jxlc2d7quit5mo6e1qRGsxg/5awbCOmCpDEnoD6mXwlKo2leyOmg1GV2z9TKK5H4X/Frwf8AGjwnbeJPBOv2fiHR5xxPav8ANG39yRDho3HdWAI9K66vZPSCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDyr9rH/k1n4yf9iZrP8A6QzV5V/wS4/5MT+GX/cT/wDTpd16r+1j/wAms/GT/sTNZ/8ASGavKv8Aglx/yYn8Mv8AuJ/+nS7oA+qqKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKK5b4kfFDwn8H/Ctz4k8Z69Z+HdEt+Hu72TaCx6IijLOx7KoJPYV8V+MP2lPix+1LvsfhlDefCX4ayHa/i7UYsazqSZ5NpDn9wjDpI3zcggggrWtOnOrLlgrszqVIUo803ZHvv7QX7aHgv4GagnhqzhuvHXxFuQPsnhDQP3tySejTuAVgTuS/OOQpGa+YdY+Hfj/9pPVIdb+O+sodHikE1l8O9CmaPS7Yhsoblwc3Mg9zgHODg7a7H4WfBXwn8HtPmg8PaeReXTF73Vbx/Ovb1yclppj8zEkk44GScAV3VfRYfLoU/eq6v8D5/EZhKp7tPRfieMfsw2dr4R/aQ+PHhmztobKwP9jajZW1ugjjRGtWVwqjgAMAMCvqSvlvwjJ/YP7eV7Eflg1/wIsoP96eC824/CM5r6kr4HNYcmMqLzOiL5oRfkgoooryRhRRRQBBf30Om2Nxd3DbILeNpZG9FUEk/kK+Uv2JbWY/s96Pq1yu271y8vtVm/3pLmTB/FVWvZv2n/E3/CI/s7/EbVA2ySPQrqOJvSSSMxof++nWuX+Bfh7/AIRP4MeBtJK7JLXRbRJB/wBNPKUuf++ia+y4cp+/Un5WObFO1K3dnLeIPgJc+HfFk3jn4R+IJfhp45fBnkskzp2pgHPl3dt91wT/ABAZBOcE1618If28oIdds/BHxz0aP4Z+M5cR22q7y2h6s2cZguDkRMf7kh4yBuydtWKxvF3g7Q/HmhXGi+ItLtdY0u4H7y1u4w6k9iPRh2YYI7Gvp8RgKdb3o6Mzw+OnR92WqPspHWRFdGDKwyGU5BHrTq/OnwjN8Wv2R2Q/Du6m+JXwziwH8C61cn7bYRg5b7BcnsO0TZHYAk5r64+AH7U3gD9o7S5X8Mak9trlov8AxMfDeqJ9n1LT2zgrLCecA8bl3L2znivmq1CpQdpo+hpVoVleDPXqKKKwNwooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAPKv2sf8Ak1n4yf8AYmaz/wCkM1eVf8EuP+TE/hl/3E//AE6Xdeq/tY/8ms/GT/sTNZ/9IZq8q/4Jcf8AJifwy/7if/p0u6APqqiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooryz48ftMfD/APZx0OK/8ZayIby5+Wx0azXz9Qv2JwFhgB3NzgbjhQSMkUAep18mfGT9vPT7DxBdeCPgxo6/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7if/AKdLuvVf2sf+TWfjJ/2Jms/+kM1eVf8ABLj/AJMT+GX/AHE//Tpd0AfVVFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFea/Ff8AZv8Ahl8ctT0bUfHfg3TvEt7o7Zs5rtWDIMhijbSN6ZGdj5Xrxya9KooAZDDHbwpFFGsUUahUjQAKqgYAAHQU+iigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDyr9rH/k1n4yf9iZrP8A6QzV5V/wS4/5MT+GX/cT/wDTpd16r+1j/wAms/GT/sTNZ/8ASGavKv8Aglx/yYn8Mv8AuJ/+nS7oA+qqKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKK+b/ANqb9g/wD+11r+h6v4w1fxJptzo9q9pAuh3NvEjIz7iXEsEhJz6EV4h/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0AfVX7WP/ACaz8ZP+xM1n/wBIZq8q/wCCXH/Jifwy/wC4n/6dLuvnX43f8Eifg98Nfgv4+8XaZ4k8cT6l4f8AD+oaraxXd/ZtC8sFtJKiuFtFJUsgyAQcZwR1rif2M/8Agl/8LP2if2bPB/xC8Sa/4wsta1j7Z58Gl3lrHbr5V5PAuxXtnYZWJScseSeg4AB+tVFfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0Aff9FfAH/DlT4If9DT8QP/BjY/8AyHR/w5U+CH/Q0/ED/wAGNj/8h0Aff9FfAH/DlT4If9DT8QP/AAY2P/yHR/w5U+CH/Q0/ED/wY2P/AMh0AfRH7XPwQ8ffGrwXpSfDX4kah8OfFei3hvraW3nkitb07CvlXBj+bbznOHH3gUbPHzj8Pf8AgoZ40+BPii38A/tWeD7rwvqTHba+M9NtvMsrtc43ukeVI9XhzjIBjXBNcx8Tv+CVn7MPwZ8Kz+I/G3xK8ZeHNHh+X7RearYqZGwSEjX7HukcgHCKCxweK+NPD/7H9t+0346Ww/Z28NeLz4MtpWiu/F/jq8gW1OO6rDbptI/uBpHORlV5oA/eLwv4q0bxtoVprXh/VbPW9Iu08y3vtPnWaGVfVXUkGtWvmr9i79iXRv2P/DN5DbeI9U8Q67qYDahPJPJDYlhjHl2oYoCMY8xtz4zyAdtfStABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB5V+1j/yaz8ZP+xM1n/0hmryr/glx/yYn8Mv+4n/AOnS7r1X9rH/AJNZ+Mn/AGJms/8ApDNXlX/BLj/kxP4Zf9xP/wBOl3QB9VUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAHm3xo/Z1+H/7QcOgw+PtAj1+DRLz7bZwyTSRoHIwQ4RhvUgDKtkHArudB8P6Z4V0e00jRdOtdJ0qzjEVvY2MKwwwoOioigBR7AVoUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB5V+1j/AMms/GT/ALEzWf8A0hmryr/glx/yYn8Mv+4n/wCnS7r1X9rH/k1n4yf9iZrP/pDNXlX/AAS4/wCTE/hl/wBxP/06XdAH1VRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFeeX3xw0LSfjdp3wu1G01HT9c1TTJNU0y+uI4xZX6xtiWGGQOWMyD5mQqPl5BNeh14n+1j8F9Q+Lnw5hvPC840/4ieFbpdc8L6gODHeRc+Ux7xyrmNgePmBOcVLkotSlt19O/wAt7dbW6lKPNeK36ev/AAdvK9+h7BrOsWXh7SL3VNSuo7LTrKF7m5uZm2pFGilmdj2AAJ/CuY+D/wAULH4z/D3SfGWlaZqmlaVqqtNZx6xCkM8sO4hJtiu2EcDcuSCVYEgZr5Mn+Nq/t8W3gr4Y6DDcaVpdxAmq/EyLDo+nRQylDpJbAIkmnjYHofKQno2K+4LOzg0+zgtbWFLe2gRYooY1CqiKMBQB0AAAxWnK4puXy+W79G9F6N7NMz5r2S+fl2Xr1fqvMmoooqSgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDB8e+DbD4jeBvEXhPVTMul69ptzpd21uwWQQzxNE+wkEBtrnBwee1YXwP+Degfs/fC7RfAPhh7yTQ9J8/7O1/KJZj5s8kz7mCqD88rY4HGK7uigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigD5c/Y7sba1+LP7TTwW8ULN49YM0aBSf9FibnH+0zH6sT3r6jrmPCHw08N+A9W8TaloWm/Yb3xJf/2pqsvnyyfaLkoqb8OxCfKqjCADjpXT1ME404Qe6jFfdFL9Aes5S7uT+9thRRRVAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAf/Z")}, coordinateSystem(extent = {{-150, -150}, {150, 150}}, initialScale = 0.1)),
    __OpenModelica_commandLineOptions = "",
    Diagram(coordinateSystem(extent = {{-120, -100}, {120, 120}})));
end LateralLTISS00;
