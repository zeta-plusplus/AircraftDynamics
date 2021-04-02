within AircraftDynamics.RigidBodyFDM.Components;

model DerivativesLongitudinalNonDim2Dim00
  import AircraftDynamics;
  
  /* ---------------------------------------------
          Internal variables
  --------------------------------------------- */
  Modelica.SIunits.Velocity U1;
  Modelica.SIunits.Pressure q1bar;
  Modelica.SIunits.Area S;
  Modelica.SIunits.Mass m;
  Modelica.SIunits.MomentOfInertia Iyy;
  Modelica.SIunits.Length cBar;
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
  
  //----------
  Real Xu(displayUnit = "1/s");
  Real XTu(displayUnit="1/s");
  Real Xalpha(displayUnit="m/s2");
  Real XdeltaE(displayUnit="m/s2");
  //---
  //Real Xu_pri;
  //Real Xalpha_pri;
  //Real Xq_pri;
  //Real Xtheta_pri;
  //---
  //Real Zu_pri;
  //Real Zalpha_pri;
  //Real Zq_pri;
  //Real Ztheta_pri;
  //---
  //Real Mu_pri;
  //Real Malpha_pri;
  //Real Mq_pri;
  //Real Mtheta_pri;
  //---
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
  connect(CDdeltaE, infoBusNonDim.CDdeltaE) annotation(
    Line);
  connect(CL1, infoBusNonDim.CL1) annotation(
    Line);
  connect(CDalpha, infoBusNonDim.CDalpha) annotation(
    Line);
  connect(CTX1, infoBusNonDim.CTX1) annotation(
    Line);
  connect(CTXu, infoBusNonDim.CTXu) annotation(
    Line);
  connect(CD1, infoBusNonDim.CD1) annotation(
    Line);
  connect(CDu, infoBusNonDim.CDu) annotation(
    Line);
/* ---------------------------------------------
  Connections, interface <-> internal variables
  --------------------------------------------- */
  connect(U1, infoBusFlt.U1);
  connect(q1bar, infoBusFlt.q1bar);
  //---
  connect(S, infoBusAircraft.S);
  connect(m, infoBusAircraft.m);
  connect(Iyy, infoBusAircraft.Iyy);
  connect(cBar, infoBusAircraft.cBar);

//---
  connect(Xu, infoBusDim.Xu);
  connect(XTu, infoBusDim.XTu);
  connect(Xalpha, infoBusDim.Xalpha);
  connect(XdeltaE, infoBusDim.XdeltaE);
  //-----
  
  /* ---------------------------------------------
  Eqns describing physics
  --------------------------------------------- */
  CTu= CTXu + CTX1;
  Xu = (-1.0 * q1bar * S * (CDu + 2.0 * CD1)) / (m * U1);
  XTu= (q1bar*S*(CTXu + 2.0*CTX1))/(m*U1);
  Xalpha= (-1.0*q1bar*S*(CDalpha-CL1))/(m);
  XdeltaE= (-1.0*q1bar*S*CDdeltaE)/(m);
  
  
/********************************************************
  Graphics
********************************************************/
  annotation(
    defaultComponentName = "DerLongiNonDim2Dim",
    Diagram,
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-87, -69}, extent = {{-11, 3}, {23, -7}}, textString = "NonDim."), Text(origin = {75, -9}, extent = {{1, 3}, {23, -7}}, textString = "Dim."), Text(origin = {0, -90}, extent = {{-100, 10}, {100, -10}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
end DerivativesLongitudinalNonDim2Dim00;
