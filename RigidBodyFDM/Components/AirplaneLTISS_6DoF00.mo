within AircraftDynamics.RigidBodyFDM.Components;

model AirplaneLTISS_6DoF00
  
  extends AircraftDynamics.Icons.Icon_LogitudinalLateralSeparated;
  /********************************************************
                      imports
          ********************************************************/
  import Modelica.Constants;
  import Modelica.SIunits;
  /********************************************************
                         Declaration
          ********************************************************/
  /* ---------------------------------------------
                      Package
            --------------------------------------------- */
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  /* ---------------------------------------------
              switches
        --------------------------------------------- */
  /* ---------------------------------------------
                parameters
          --------------------------------------------- */
  //********** Initial States **********
  //--- longitidinal ---
  parameter Modelica.SIunits.Angle alpha1 = 5.0 * (Constants.pi / 180.0) "AoA, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states; longitudinal", group = "in equilibrium"));
  parameter Modelica.SIunits.Angle gamma1 = 0.0 "flight path, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states; longitudinal", group = "in equilibrium"));
  parameter Modelica.SIunits.AngularVelocity q1 = 0.0 "pitch rate, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states; longitudinal", group = "in equilibrium"));
  //---
  parameter Modelica.SIunits.Velocity u0 = 0.0 "velocity along x-axis, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states; longitudinal", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.Angle alpha0 = 0.0 "AoA, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states; longitudinal", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.AngularVelocity q0 = 0.0 "pitch rate, deviation from equilibrium" annotation(
    Dialog(tab = "Initial states; longitudinal", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.Angle theta0 = 0.0 "pitch, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states; longitudinal", group = "deviation from equilibrium"));
  //--- lateral ---
  parameter Modelica.SIunits.Angle beta1 = 0.0 * (Constants.pi / 180.0) "sideslip, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "in equilibrium"));
  parameter Modelica.SIunits.Angle phi1 = 0.0 * (Constants.pi / 180.0) "roll, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "in equilibrium"));
  parameter Modelica.SIunits.Angle psi1 = 0.0 * (Constants.pi / 180.0) "heading, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "in equilibrium"));
  parameter Modelica.SIunits.AngularVelocity p1 = 0.0 * (Constants.pi / 180.0) "roll rate, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "in equilibrium"));
  parameter Modelica.SIunits.AngularVelocity r1 = 0.0 * (Constants.pi / 180.0) "yaw rate, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "in equilibrium"));
  //---
  parameter Modelica.SIunits.Angle beta0 = 0.0 * (Constants.pi / 180.0) "sideslip, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.Angle phi0 = 0.0 * (Constants.pi / 180.0) "roll, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.Angle psi0 = 0.0 * (Constants.pi / 180.0) "heading, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.AngularVelocity p0 = 0.0 * (Constants.pi / 180.0) "roll rate, deviation from equilibrium" annotation(
    Dialog(tab = "Initial states; Lateral", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.AngularVelocity r0 = 0.0 * (Constants.pi / 180.0) "yaw rate, deviation from equilibrium" annotation(
    Dialog(tab = "Initial states; Lateral", group = "deviation from equilibrium"));
  //---
  //********** Steady Flight Condition **********
  parameter Real MNfltSteady_par = 0.201 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter SIunits.Position altFltSteady_par = 1524 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter SIunits.TemperatureDifference dTambFltSteady_par = 0.0 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter Medium.MassFraction X_fluidSurr_par[Medium.nX] = Medium.X_default "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter Medium.ExtraProperty C_fluidSurr_par[Medium.nC](quantity = Medium.extraPropertiesNames) = fill(0, Medium.nC) "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter SIunits.Position XGfltSteady_par = 0.0 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter SIunits.Position YGfltSteady_par = 0.0 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  //********** Aircraft Properties **********
  parameter SIunits.Area S_par = 16.165129 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.Length cBar_par = 1.49352 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.Length b_par = 10.9728 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.Mass m_par = 1202.01978 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.MomentOfInertia Iyy_par = 1824.9309607 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.MomentOfInertia Ixx_par = 1285.3154166 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.MomentOfInertia Izz_par = 2666.89390765 "" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.MomentOfInertia Ixz_par = 0.0 "" annotation(
    Dialog(group = "Aircraft Properties"));
  //---
  parameter SIunits.Angle thetaTi_par = 2.0 * (Constants.pi / 180.0) "inclination of thrust instllation, in pich" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter SIunits.Angle psiTi_par = 0.0 * (Constants.pi / 180.0) "inclination of thrust installation, in yaw" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter Real xBarTi_par = 0.1 "non-dim distance, + == foward of CG, thrust acting point - C.G., x-axis" annotation(
    Dialog(group = "Aircraft Properties"));
  parameter Real zBarTi_par = 0.1 "non-dim distance, + == below CG, thrust acting point - C.G., z-axis" annotation(
    Dialog(group = "Aircraft Properties"));
  //********** Characteristics **********
  //--- longitudinal ---
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
  //--- lateral ---
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
  /* ---------------------------------------------
              Internal variables
    --------------------------------------------- */
  AircraftDynamics.Records.FlightStates fltStates;
  AircraftDynamics.Records.angles4display fltAng4disp;
  
  /**/
  /* ---------------------------------------------
              Internal objects
    --------------------------------------------- */
  inner outer AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {10, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Sources.FlightCondition2Fluid00 Flt2Fluid(redeclare package Medium = Medium, C_fluid_paramInput = C_fluidSurr_par, MN_paramInput = MNfltSteady_par, X_fluid_paramInput = X_fluidSurr_par, alt_paramInput = altFltSteady_par, dTamb_paramInput = dTambFltSteady_par) annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.LongitudinalLTISS00 FltDynLongiSS(CD1 = CD1, CDalpha = CDalpha, CDdeltaE = CDdeltaE, CDu = CDu, CL1 = CL1, CLalpha = CLalpha, CLalpha_dot = CLalpha_dot, CLdeltaE = CLdeltaE, CLq = CLq, CLu = CLu, CTX1 = CTX1, CTXu = CTXu, Cm1 = Cm1, CmAlpha = CmAlpha, CmAlpha_dot = CmAlpha_dot, CmDeltaE = CmDeltaE, Cmq = Cmq, Cmu = Cmu, Iyy_par = Iyy_par, S_par = S_par, alpha1 = alpha1, cBar_par = cBar_par, gamma1 = gamma1, m_par = m_par, psiTi_par = psiTi_par, q1 = q1, thetaTi_par = thetaTi_par, use_u_U1 = true, use_u_q1bar = true, xBarTi_par = xBarTi_par, zBarTi_par = zBarTi_par) annotation(
    Placement(visible = true, transformation(origin = {-10.5, 20.3334}, extent = {{-29.5, -19.6666}, {29.5, 19.6666}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.LateralLTISS00 FltDynLateralSS(CYbeta = CYbeta, CYdeltaA = CYdeltaA, CYdeltaF = CYdeltaF, CYdeltaR = CYdeltaR, CYdeltaS = CYdeltaS, CYp = CYp, CYr = CYr, Clbeta = Clbeta, CldeltaA = CldeltaA, CldeltaF = CldeltaF, CldeltaR = CldeltaR, CldeltaS = CldeltaS, Clp = Clp, Clr = Clr, Cnbeta = Cnbeta, CndeltaA = CndeltaA, CndeltaF = CndeltaF, CndeltaR = CndeltaR, CndeltaS = CndeltaS, Cnp = Cnp, Cnr = Cnr, Ixx_par = Ixx_par, Ixz_par = Ixz_par, Izz_par = Izz_par, S_par = S_par, b_par = b_par, beta0 = beta0, beta1 = beta1, m_par = m_par, p0 = p0, p1 = p1, phi0 = phi0, phi1 = phi1, psi0 = psi0, psi1 = psi1, r0 = r0, r1 = r1, theta1 = alpha1 + gamma1, use_u_U1 = true, use_u_q1bar = true) annotation(
    Placement(visible = true, transformation(origin = {-10, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  /**/
  //-----
  /* ---------------------------------------------
                Interface
    --------------------------------------------- */
  Modelica.Blocks.Interfaces.RealInput u_deltaE annotation(
    Placement(visible = true, transformation(origin = {-140, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-190, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaT annotation(
    Placement(visible = true, transformation(origin = {-140, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-190, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaA annotation(
    Placement(visible = true, transformation(origin = {-140, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-190, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaR annotation(
    Placement(visible = true, transformation(origin = {-140, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-190, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.AttitudeVelocity2Position00 ResolveFrameTranslational annotation(
    Placement(visible = true, transformation(origin = {80, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus InfoBus1 annotation(
    Placement(visible = true, transformation(origin = {120, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {180, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.BodyAngularRate2AttitudeAngularRate00 ResolveFrameRotational annotation(
    Placement(visible = true, transformation(origin = {80, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    AircraftDynamics.Interfaces.FlightStatesBus FltStatesBus1 annotation(
    Placement(visible = true, transformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {180, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //**********************************************************************
  AircraftDynamics.Interfaces.VisualizerInfoOut00 VisInfoOut annotation(
    Placement(visible = true, transformation(origin = {100, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {160, 180}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
initial equation
  fltStates.alt = altFltSteady_par;
  fltStates.XG = XGfltSteady_par;
  fltStates.YG = YGfltSteady_par;
  fltStates.ZG = -1.0 * altFltSteady_par;
  fltStates.gamma = gamma1;
//**********************************************************************
equation
  connect(ResolveFrameTranslational.busAttitude.psi, fltStates.psi) annotation(
    Line);
  connect(ResolveFrameTranslational.busAttitude.theta, fltStates.theta) annotation(
    Line);
  connect(ResolveFrameTranslational.busAttitude.phi, fltStates.phi) annotation(
    Line);
  connect(ResolveFrameTranslational.busVelocityAlongBody.w, fltStates.w) annotation(
    Line);
  connect(ResolveFrameTranslational.busVelocityAlongBody.v, fltStates.v) annotation(
    Line);
  connect(ResolveFrameTranslational.busVelocityAlongBody.u, fltStates.u) annotation(
    Line);
//--
  connect(fltStates.ZGdot, ResolveFrameTranslational.busVelocityInGlobal.ZGdot) annotation(
    Line);
  connect(fltStates.YGdot, ResolveFrameTranslational.busVelocityInGlobal.YGdot) annotation(
    Line);
  connect(fltStates.XGdot, ResolveFrameTranslational.busVelocityInGlobal.XGdot) annotation(
    Line);
  connect(fltStates.ZG, ResolveFrameTranslational.busPosition.ZG) annotation(
    Line);
  connect(fltStates.YG, ResolveFrameTranslational.busPosition.YG) annotation(
    Line);
  connect(fltStates.XG, ResolveFrameTranslational.busPosition.XG) annotation(
    Line);
//-----
  connect(ResolveFrameRotational.busBodyAngularRate.p, fltStates.p);
  connect(ResolveFrameRotational.busBodyAngularRate.q, fltStates.q);
  connect(ResolveFrameRotational.busBodyAngularRate.r, fltStates.r);
//--
  connect(fltStates.phi, ResolveFrameRotational.busAttitude.phi);
  connect(fltStates.theta, ResolveFrameRotational.busAttitude.theta);
  connect(fltStates.psi, ResolveFrameRotational.busAttitude.psi);
//-----
  VisInfoOut.r[1] = fltStates.YG;
  VisInfoOut.r[2] = fltStates.XG;
  VisInfoOut.r[3] = -1.0*fltStates.ZG;
  VisInfoOut.theta[1] = fltStates.phi;
  VisInfoOut.theta[2] = fltStates.theta;
  VisInfoOut.theta[3] = fltStates.psi;
  VisInfoOut.alpha= fltStates.alpha;
  VisInfoOut.beta= fltStates.beta;
  VisInfoOut.V[1]=fltStates.u;
  VisInfoOut.V[2]=fltStates.v;
  VisInfoOut.V[3]=fltStates.w;
  //-----
  
  /*------------------------------
  interface; internal -- connector
  ------------------------------*/
  //connect(FltStatesBus1.fltStates, fltStates);
  //connect(FltStatesBus1.fltAng4disp, fltAng4disp);
//--
  connect(u_deltaT, FltDynLongiSS.u_deltaT) annotation(
    Line(points = {{-140, 40}, {-116, 40}, {-116, 9}, {-42, 9}}, color = {0, 0, 127}));
  connect(u_deltaE, FltDynLongiSS.u_deltaE) annotation(
    Line(points = {{-140, 80}, {-108, 80}, {-108, 32}, {-42, 32}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_V_inf, FltDynLongiSS.u_U1) annotation(
    Line(points = {{-79, 67}, {-28, 67}, {-28, 42}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_qBar, FltDynLongiSS.u_q1bar) annotation(
    Line(points = {{-79, 64}, {-36, 64}, {-36, 42}}, color = {0, 0, 127}));
  connect(u_deltaA, FltDynLateralSS.u_deltaA) annotation(
    Line(points = {{-140, -20}, {-108, -20}, {-108, -54}, {-42, -54}}, color = {0, 0, 127}));
  connect(u_deltaR, FltDynLateralSS.u_deltaR) annotation(
    Line(points = {{-140, -60}, {-114, -60}, {-114, -66}, {-42, -66}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_V_inf, FltDynLateralSS.u_U1) annotation(
    Line(points = {{-79, 67}, {-64, 67}, {-64, -26}, {-42, -26}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_qBar, FltDynLateralSS.u_q1bar) annotation(
    Line(points = {{-79, 64}, {-72, 64}, {-72, -38}, {-42, -38}}, color = {0, 0, 127}));
//-----
/*------------------------------
  connection; internal -- internal
  ------------------------------*/
//-----
/*------------------------------
    equation describing physics
  ------------------------------*/
  fltStates.u = FltDynLongiSS.y_u;
  fltStates.v = tan(FltDynLateralSS.y_beta) * sqrt(fltStates.u ^ 2.0 + fltStates.w ^ 2.0);
  fltStates.w = fltStates.u * tan(FltDynLongiSS.y_alpha);
  fltStates.V = sqrt(fltStates.u ^ 2.0 + fltStates.v ^ 2.0 + fltStates.w ^ 2.0);
  fltStates.Mn = fltStates.V / Flt2Fluid.y_Vsound;
//---
//fltStates.phi = FltDynLateralSS.y_phi;
//fltStates.theta= FltDynLongiSS.y_theta;
//fltStates.psi= FltDynLateralSS.y_psi;
  fltStates.alpha = FltDynLongiSS.y_alpha;
  fltStates.beta = FltDynLateralSS.y_beta;
  fltStates.gamma = fltStates.theta - fltStates.alpha;
//---
  fltStates.p = FltDynLateralSS.y_p;
  fltStates.q = FltDynLongiSS.y_q;
  fltStates.r = FltDynLateralSS.y_r;
//---
  fltStates.X = FltDynLongiSS.y_aX * m_par;
  fltStates.Y = FltDynLateralSS.y_aY * m_par;
  fltStates.Z = FltDynLongiSS.y_aZ * m_par;
//---
  (fltStates.xEast, fltStates.xNorth, fltStates.alt) = AircraftDynamics.Functions.GlobalFrame2earthConvention(XG = fltStates.XG, YG = fltStates.YG, ZG = fltStates.ZG);
//fltStates.alt = -1.0 * fltStates.ZG;
//---
/*------------------------------
    Unused flight states
  ------------------------------*/
  fltStates.Ftan = 0.0;
  fltStates.Fcentr = 0.0;
  fltStates.Fturn = 0.0;
  fltStates.L = 0.0;
  fltStates.M = 0.0;
  fltStates.N = 0.0;
/*------------------------------
    convert angles for display
  ------------------------------*/
  [fltAng4disp.alpha, fltAng4disp.beta, fltAng4disp.theta, fltAng4disp.gamma, fltAng4disp.phi, fltAng4disp.psi] = AircraftDynamics.Functions.calcAngles4display([fltStates.alpha, fltStates.beta, fltStates.theta, fltStates.gamma, fltStates.phi, fltStates.psi]);
/*
*/
//----------

  annotation(
    defaultComponentName = "AirplaneDyn",
    Icon(graphics = {Text(origin = {2, -192}, extent = {{-181, 8}, {178, -8}}, textString = "%name")}, coordinateSystem(initialScale = 0.1, extent = {{-180, -180}, {180, 180}})),
    Diagram(coordinateSystem(extent = {{-120, -100}, {120, 100}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end AirplaneLTISS_6DoF00;
