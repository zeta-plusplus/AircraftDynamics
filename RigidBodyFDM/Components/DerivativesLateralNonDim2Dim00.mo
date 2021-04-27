within AircraftDynamics.RigidBodyFDM.Components;

model DerivativesLateralNonDim2Dim00
  import AircraftDynamics;
  /* ---------------------------------------------
            Internal variables
    --------------------------------------------- */
  Modelica.SIunits.Velocity U1;
  Modelica.SIunits.Pressure q1bar;
  Modelica.SIunits.Angle theta1;
  Modelica.SIunits.Acceleration g;
  Modelica.SIunits.Area S;
  Modelica.SIunits.Mass m;
  Modelica.SIunits.MomentOfInertia Ixx;
  Modelica.SIunits.MomentOfInertia Izz;
  Modelica.SIunits.MomentOfInertia Ixz;
  Modelica.SIunits.Length b;
  //----------
  Real CD1;
  Real CDu;
  Real CTXu;
  Real CTX1;
  Real CTu;
  Real CDalpha;
  Real CDdeltaE;
  //---
  Real CL1;
  Real CLu;
  Real CLalpha;
  Real CLalpha_dot;
  Real CLq;
  Real CLdeltaE;
  //---
  Real Cm1;
  Real Cmu;
  Real CmAlpha;
  Real CmAlpha_dot;
  Real Cmq;
  Real CmDeltaE;
  Real CmTu;
  Real CmT1;
  Real CmTalpha;
  //---
  //----------
  Real Xu(unit = "1/s", displayUnit = "1/s");
  Real XTu(unit = "1/s", displayUnit = "1/s");
  Real Xalpha(unit = "m/s2", displayUnit = "m/s2");
  Real XdeltaE(unit = "m/s2", displayUnit = "m/s2");
  //---
  Real Xu_pri;
  Real Xalpha_pri;
  Real Xq_pri;
  Real Xtheta_pri;
  //---
  Real Zu(unit = "1/s", displayUnit = "1/s");
  Real Zalpha(unit = "m/s2", displayUnit = "m/s2");
  Real Zalpha_dot(unit = "m/s", displayUnit = "m/s");
  Real Zq(unit = "m/s", displayUnit = "m/s");
  Real ZdeltaE(unit = "m/s2", displayUnit = "m/s2");
  //---
  Real Zu_pri;
  Real Zalpha_pri;
  Real Zalpha_dot_pri;
  Real Zq_pri;
  Real Ztheta_pri;
  //---
  Real Mu;
  Real MTu;
  Real Malpha;
  Real MTalpha;
  Real Malpha_dot;
  Real Mq;
  Real MdeltaE;
  //---
  Real Mu_pri;
  Real Malpha_pri;
  Real Mq_pri;
  Real Mtheta_pri;
  //---
  //----------
  Real XdeltaE_pri;
  //---
  Real ZdeltaE_pri;
  //---
  Real MdeltaE_pri;
  /* ---------------------------------------------
                Interface
      --------------------------------------------- */
  AircraftDynamics.Types.InfoBus infoBusAircraft annotation(
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus infoBusNonDim annotation(
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus infoBusDim annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus infoBusFlt annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //********************************************************************************
equation
/* ---------------------------------------------
  Connections, interface <-> internal variables
  --------------------------------------------- */
//***** flight condition *****
  connect(U1, infoBusFlt.U1);
  connect(q1bar, infoBusFlt.q1bar);
  connect(theta1, infoBusFlt.theta1);
  connect(g, infoBusFlt.g);
//***** aircraft characteristics *****
  connect(S, infoBusAircraft.S);
  connect(m, infoBusAircraft.m);
  connect(Ixx, infoBusAircraft.Ixx);
  connect(Izz, infoBusAircraft.Izz);
  connect(Ixz, infoBusAircraft.Ixz);
  connect(b, infoBusAircraft.b);
//-----
//***** Non-dimentional coefficients/derivatives *****
  connect(CDdeltaE, infoBusNonDim.CDdeltaE);
  connect(CDalpha, infoBusNonDim.CDalpha);
  connect(CTX1, infoBusNonDim.CTX1);
  connect(CTXu, infoBusNonDim.CTXu);
  connect(CD1, infoBusNonDim.CD1);
  connect(CDu, infoBusNonDim.CDu);
//---
  connect(CL1, infoBusNonDim.CL1);
  connect(CLu, infoBusNonDim.CLu);
  connect(CLalpha, infoBusNonDim.CLalpha);
  connect(CLalpha_dot, infoBusNonDim.CLalpha_dot);
  connect(CLq, infoBusNonDim.CLq);
  connect(CLdeltaE, infoBusNonDim.CLdeltaE);
//---
  connect(Cm1, infoBusNonDim.Cm1);
  connect(Cmu, infoBusNonDim.Cmu);
  connect(CmAlpha, infoBusNonDim.CmAlpha);
  connect(CmAlpha_dot, infoBusNonDim.CmAlpha_dot);
  connect(Cmq, infoBusNonDim.Cmq);
  connect(CmDeltaE, infoBusNonDim.CmDeltaE);
  connect(CmTu, infoBusNonDim.CmTu);
  connect(CmT1, infoBusNonDim.CmT1);
  connect(CmTalpha, infoBusNonDim.CmTalpha);
//-----
//***** Dimentional derivatives *****
  connect(Xu, infoBusDim.Xu);
  connect(XTu, infoBusDim.XTu);
  connect(Xalpha, infoBusDim.Xalpha);
  connect(XdeltaE, infoBusDim.XdeltaE);
//---
  connect(Xu_pri, infoBusDim.Xu_pri);
  connect(Xalpha_pri, infoBusDim.Xalpha_pri);
  connect(Xq_pri, infoBusDim.Xq_pri);
  connect(Xtheta_pri, infoBusDim.Xtheta_pri);
//---
  connect(Zu, infoBusDim.Zu);
  connect(Zalpha, infoBusDim.Zalpha);
  connect(Zalpha_dot, infoBusDim.Zalpha_dot);
  connect(Zq, infoBusDim.Zq);
  connect(ZdeltaE, infoBusDim.ZdeltaE);
//---
  connect(Zu_pri, infoBusDim.Zu_pri);
  connect(Zalpha_pri, infoBusDim.Zalpha_pri);
  connect(Zq_pri, infoBusDim.Zq_pri);
  connect(Ztheta_pri, infoBusDim.Ztheta_pri);
//---
  connect(Mu, infoBusDim.Mu);
  connect(MTu, infoBusDim.MTu);
  connect(Malpha, infoBusDim.Malpha);
  connect(MTalpha, infoBusDim.MTalpha);
  connect(Malpha_dot, infoBusDim.Malpha_dot);
  connect(Mq, infoBusDim.Mq);
  connect(MdeltaE, infoBusDim.MdeltaE);
//---
  connect(Mu_pri, infoBusDim.Mu_pri);
  connect(Malpha_pri, infoBusDim.Malpha_pri);
  connect(Mq_pri, infoBusDim.Mq_pri);
  connect(Mtheta_pri, infoBusDim.Mtheta_pri);
//-----
  connect(XdeltaE_pri, infoBusDim.XdeltaE_pri);
//---
  connect(ZdeltaE_pri, infoBusDim.ZdeltaE_pri);
//---
  connect(MdeltaE_pri, infoBusDim.MdeltaE_pri);
/* ---------------------------------------------
  Eqns describing physics
  --------------------------------------------- */
  CTu = CTXu + CTX1;
//-----
  Xu = (-1.0 * q1bar * S * (CDu + 2.0 * CD1)) / (m * U1);
  XTu = q1bar * S * (CTXu + 2.0 * CTX1) / (m * U1);
  Xalpha = (-1.0 * q1bar * S * (CDalpha - CL1)) / m;
  XdeltaE = (-1.0 * q1bar * S * CDdeltaE) / m;
//---
  Xu_pri = Xu + XTu;
  Xalpha_pri = Xalpha;
  Xtheta_pri = (-1.0) * g * cos(theta1);
  Xq_pri = 0.0;
//---
  Zu = (-1.0 * q1bar * S * (CLu + 2.0 * CL1)) / (m * U1);
  Zalpha = (-1.0 * q1bar * S * (CLalpha + CD1)) / m;
  Zalpha_dot = (-1.0 * q1bar * S * cBar * CLalpha_dot) / (2.0 * m * U1);
  Zq = (-1.0 * q1bar * S * cBar * CLq) / (2.0 * m * U1);
  ZdeltaE = (-1.0 * q1bar * S * CLdeltaE) / m;
//---
  Zalpha_dot_pri = Zalpha_dot;
  Zu_pri = Zu / (U1 - Zalpha_dot_pri);
  Zalpha_pri = Zalpha / (U1 - Zalpha_dot_pri);
  Zq_pri = (Zq + U1) / (U1 - Zalpha_dot_pri);
  Ztheta_pri = (-1.0 * g * sin(theta1)) / (U1 - Zalpha_dot_pri);
//---
  Mu = q1bar * S * cBar * (Cmu + 2.0 * Cm1) / (U1 * Iyy);
  MTu = q1bar * S * cBar * (CmTu + 2.0 * CmT1) / (U1 * Iyy);
  Malpha = q1bar * S * cBar * CmAlpha / Iyy;
  MTalpha = q1bar * S * cBar * CmTalpha / Iyy;
  Malpha_dot = q1bar * S * cBar * CmAlpha_dot / Iyy * (cBar / (2.0 * U1));
  Mq = q1bar * S * cBar * Cmq / Iyy * (cBar / (2.0 * U1));
  MdeltaE = q1bar * S * cBar * CmDeltaE / Iyy;
//---
  Mu_pri = Malpha_dot * Zu_pri + Mu;
  Malpha_pri = Malpha_dot * Zalpha_pri + Malpha;
  Mq_pri = Malpha_dot * Zq_pri + Mq;
  Mtheta_pri = Malpha_dot * Ztheta_pri;
//-----
  XdeltaE_pri = XdeltaE;
//---
  ZdeltaE_pri = ZdeltaE / (U1 - Zalpha_dot);
//---
  MdeltaE_pri = Malpha_dot * ZdeltaE_pri + MdeltaE;
//---
/********************************************************
  Graphics
********************************************************/
  annotation(
    defaultComponentName = "DerLateral",
    Diagram,
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-87, -69}, extent = {{-11, 3}, {23, -7}}, textString = "NonDim."), Text(origin = {75, -9}, extent = {{1, 3}, {23, -7}}, textString = "Dim."), Text(origin = {0, -90}, extent = {{-100, 10}, {100, -10}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
end DerivativesLateralNonDim2Dim00;
