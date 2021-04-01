within AircraftDynamics.Utilities;

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
  Real CDu;
  Real CD1;
  //----------
  Real Xu(displayUnit = "1/s");
  //-----
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
  AircraftDynamics.Types.InfoBus infoBusInputs annotation(
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus infoBusNonDim annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus infoBusDim annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  //********************************************************************************
equation  
  /* ---------------------------------------------
  Connections, interface <-> internal variables
  --------------------------------------------- */
  connect(U1, infoBusInputs.U1);
  connect(q1bar, infoBusInputs.q1bar);
  connect(S, infoBusInputs.S);
  connect(m, infoBusInputs.m);
  connect(Iyy, infoBusInputs.Iyy);
  connect(cBar, infoBusInputs.cBar);
  //---
  connect(CDu, infoBusNonDim.CDu);
  connect(CD1, infoBusNonDim.CD1);
//---
  connect(Xu, infoBusDim.Xu);
//-----
  
  /* ---------------------------------------------
  Eqns describing physics
  --------------------------------------------- */
  Xu = (-1.0 * q1bar * S * (CDu + 2.0 * CD1)) / (m * U1);
  
/********************************************************
  Graphics
********************************************************/
  annotation(
    defaultComponentName = "DerLongiNonDim2Dim",
    Diagram,
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-85, -9}, extent = {{-11, 3}, {23, -7}}, textString = "NonDim."), Text(origin = {75, -9}, extent = {{1, 3}, {23, -7}}, textString = "Dim."), Text(origin = {0, -90}, extent = {{-100, 10}, {100, -10}}, textString = "%name")}));
end DerivativesLongitudinalNonDim2Dim00;
