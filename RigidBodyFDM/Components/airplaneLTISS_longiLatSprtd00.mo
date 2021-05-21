within AircraftDynamics.RigidBodyFDM.Components;

model airplaneLTISS_longiLatSprtd00
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
  parameter Modelica.SIunits.AngularVelocity p1 = 0.0 * (Constants.pi / 180.0) "roll rate, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "in equilibrium"));
  parameter Modelica.SIunits.AngularVelocity r1 = 0.0 * (Constants.pi / 180.0) "yaw rate, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "in equilibrium"));
  parameter Modelica.SIunits.Angle theta1 = 0.8994698 * (Constants.pi / 180.0) "pitch, in equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "in equilibrium"));
  //---
  parameter Modelica.SIunits.Angle beta0 = 0.0 * (Constants.pi / 180.0) "sideslip, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.Angle phi0 = 0.0 * (Constants.pi / 180.0) "roll, deviation from equilibrium at initial" annotation(
    Dialog(tab = "Initial states; Lateral", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.AngularVelocity p0 = 0.0 * (Constants.pi / 180.0) "roll rate, deviation from equilibrium" annotation(
    Dialog(tab = "Initial states; Lateral", group = "deviation from equilibrium"));
  parameter Modelica.SIunits.AngularVelocity r0 = 0.0 * (Constants.pi / 180.0) "yaw rate, deviation from equilibrium" annotation(
    Dialog(tab = "Initial states; Lateral", group = "deviation from equilibrium"));
  //---
  //********** Steady Flight Condition **********
  parameter Real MNfltSteady_par = 0.201 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter SIunits.Length altFltSteady_par = 1524 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter SIunits.TemperatureDifference dTambFltSteady_par = 0.0 "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter Medium.MassFraction X_fluidSurr_paramInput[Medium.nX] = Medium.X_default "" annotation(
    Dialog(group = "Steady Flight Condition"));
  parameter Medium.ExtraProperty C_fluidSurr_paramInput[Medium.nC](quantity = Medium.extraPropertiesNames) = fill(0, Medium.nC) "" annotation(
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
  /* ---------------------------------------------
          Internal objects
      --------------------------------------------- */
  Sources.FlightCondition2Fluid00 Flt2Fluid annotation(
    Placement(visible = true, transformation(origin = {-64, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.LongitudinalLTISS00 FltDynLongiSS(use_u_U1 = false, use_u_q1bar = false) annotation(
    Placement(visible = true, transformation(origin = {10.5, 19.6667}, extent = {{-30.5, -20.3333}, {30.5, 20.3333}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.LateralLTISS00 FltDynLateralSS(use_u_U1 = false, use_u_q1bar = false) annotation(
    Placement(visible = true, transformation(origin = {10, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  /* ---------------------------------------------
                Interface
      --------------------------------------------- */
  Modelica.Blocks.Interfaces.RealInput u_deltaE annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaT annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaA annotation(
    Placement(visible = true, transformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaR annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus infoBusFltStates annotation(
    Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

  annotation(
    defaultComponentName = "AirplaneDyn",
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {1, -89}, extent = {{-101, 9}, {99, -9}}, textString = "%name")}));
end airplaneLTISS_longiLatSprtd00;
