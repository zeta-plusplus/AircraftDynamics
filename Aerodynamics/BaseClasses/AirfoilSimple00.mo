within AircraftDynamics.Aerodynamics.BaseClasses;

model AirfoilSimple00
  extends AircraftDynamics.Icons.Icon_Airfoil2D;
  //----- imports -----
  import Modelica.Constants;
  /********************************************************
               Declaration
            ********************************************************/
  //********** Package **********
  //##### none #####
  //********** Parameters **********
  //--- design parameter ---
  parameter Real ClmaxDes = 1.5 "" annotation(
    Dialog(group = "Characteristics"));
  parameter Modelica.SIunits.Angle alpha4Cl0des = 0.0 "" annotation(
    Dialog(group = "Characteristics"));
  parameter Modelica.SIunits.Angle alpha4ClmaxDes(displayUnit = "deg") = 15.0 * Modelica.Constants.pi / 180 "" annotation(
    Dialog(group = "Characteristics"));
  parameter Modelica.SIunits.Angle alpha4ClminDes(displayUnit = "deg") = -15.0 * Modelica.Constants.pi / 180 "" annotation(
    Dialog(group = "Characteristics"));
  parameter Real CdfDes = 0.01 "" annotation(
    Dialog(group = "Characteristics"));
  parameter Modelica.SIunits.Angle alpha_CdpMinDes(displayUnit = "deg") = 0.0 * Modelica.Constants.pi / 180 "" annotation(
    Dialog(group = "Characteristics"));
  parameter Real kCdpDes = 0.1 "" annotation(
    Dialog(group = "Characteristics"));
  parameter Real pwrCdpDes = 4.0 "" annotation(
    Dialog(group = "Characteristics"));
  parameter Real kCdp_1_des = 0.8 "" annotation(
    Dialog(group = "Characteristics"));
  parameter Real pwrCdp_1_des = 5.0 "" annotation(
    Dialog(group = "Characteristics"));
  //********** Internal variables **********
  //--- calculated parameters ---
  Real Clmax(start = ClmaxDes);
  Real Cl_alpha(start = ClmaxDes / (alpha4ClmaxDes - alpha4Cl0des));
  Real Cl0(start = 0);
  Modelica.SIunits.Angle alpha4Cl0(displayUnit = "deg", start = alpha4Cl0des);
  Modelica.SIunits.Angle alpha4Clmax(displayUnit = "deg", start = alpha4ClmaxDes);
  Modelica.SIunits.Angle alpha4Clmin(displayUnit = "deg", start = alpha4ClminDes);
  Real Cdf(start = CdfDes);
  Real alpha_CdpMin(start = alpha_CdpMinDes);
  Real kCdp(start = kCdpDes);
  Real pwrCdp(start = pwrCdpDes);
  Real kCdp_1(start = kCdp_1_des);
  Real pwrCdp_1(start = pwrCdp_1_des);
  Real intcptCdp_1;
  //---
  Modelica.SIunits.Angle alpha(displayUnit = "deg", start = 5.0 * Modelica.Constants.pi / 180);
  //---
  Real Cdp;
  Real CdpStall;
  Real Cl;
  Real Cd(start = CdfDes);
  //********** Interfaces **********
  AircraftDynamics.Types.InfoBus signalBus1 "" annotation(
    Placement(visible = true, transformation(origin = {-50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus signalBus2 "" annotation(
    Placement(visible = true, transformation(origin = {50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
algorithm
//********** assignment, design parameter to variables **********
  Clmax := ClmaxDes;
  alpha4Cl0 := alpha4Cl0des;
  alpha4Clmax := alpha4ClmaxDes;
  alpha4Clmin := alpha4ClminDes;
  Cdf := CdfDes;
  alpha_CdpMin := alpha_CdpMinDes;
  kCdp := kCdpDes;
  pwrCdp := pwrCdpDes;
  kCdp_1 := kCdp_1_des;
  pwrCdp_1 := pwrCdp_1_des;
equation
//********** interface **********
//***** signalBus1 *****
  connect(alpha, signalBus1.alpha) annotation(
    Line);
//***** signalBus2 *****
  connect(Cd, signalBus2.Cd) annotation(
    Line);
  connect(Cdp, signalBus2.Cdp) annotation(
    Line);
  connect(Cdf, signalBus2.Cdf) annotation(
    Line);
  connect(Cl, signalBus2.Cl) annotation(
    Line);
  connect(Cl0, signalBus2.Cl0) annotation(
    Line);
  connect(Cl_alpha, signalBus2.Cl_alpha) annotation(
    Line);
  connect(alpha4Cl0, signalBus2.alpha4Cl0);
  connect(alpha4Clmin, signalBus2.alpha4Clmin);
  connect(alpha4Clmax, signalBus2.alpha4Clmax);
  connect(alpha, signalBus2.alpha);
//********** Geometries **********
//##### none #####
//********** Connections, interface <-> internal variables *********
//********** Eqns describing physics **********
  Cl_alpha = Clmax / (alpha4Clmax - alpha4Cl0);
  Cl0 = Cl_alpha * (0 - alpha4Cl0);
/*********************************************
  calclate Cl
    linear model
  *********************************************/
  if alpha < alpha4Clmin then
    Cl = 0;
  elseif alpha4Clmax < alpha then
    Cl = 0;
  else
    Cl = Cl0 + Cl_alpha * alpha;
  end if;
/*********************************************
  calclate Cd
    simple power function model
  *********************************************/
  CdpStall = kCdp * (alpha4Clmax - alpha_CdpMin) ^ pwrCdp;
  intcptCdp_1 = kCdp_1 * (alpha4Clmax - alpha_CdpMin) ^ pwrCdp_1 - CdpStall;
  if alpha < alpha4Clmin then
    Cdp = kCdp_1 * abs(alpha - alpha_CdpMin) ^ pwrCdp_1 - intcptCdp_1;
  elseif alpha4Clmax < alpha then
    Cdp = kCdp_1 * (alpha - alpha_CdpMin) ^ pwrCdp_1 - intcptCdp_1;
  else
    Cdp = kCdp * abs(alpha - alpha_CdpMin) ^ pwrCdp;
  end if;
  Cd = Cdf + Cdp;
//--
  annotation(
    defaultComponentName = "airfoil",
    Documentation(info = "<html>
<a href=modelica://AircraftDynamics/docs/Aerodynamics/BaseClasses/AirfoilSimple00.html> Document html page</a>

<h4>example/demo models</h4>
  <ul>
  <li><a href=\"modelica://AircraftDynamics.Aerodynamics.Example.test.airfoil00_test01\"> Aerodynamics.Example.test.airfoil00_test01 </a> </li>
  </ul>
  
<h4>classes which this component call (those in MSL are not listed) </h4>
  <p> -> none </p>

</html>"),
    Icon(graphics = {Text(origin = {4, 72}, extent = {{-104, 8}, {96, -8}}, textString = "%name")}, coordinateSystem(extent = {{-100, -80}, {100, 80}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}}, initialScale = 0.1), graphics = {Line(origin = {-64, -73}, points = {{0, -5}, {0, 5}}, arrow = {Arrow.None, Arrow.Filled}), Text(origin = {-67, -59}, fillPattern = FillPattern.Solid, extent = {{-11, 3}, {11, -3}}, textString = "input"), Line(origin = {62.9258, -61.7799}, points = {{0, -5}, {0, -15}}, arrow = {Arrow.None, Arrow.Filled}), Text(origin = {50, -60}, fillPattern = FillPattern.Solid, extent = {{-8, 4}, {8, -4}}, textString = "outout"), Text(origin = {-40, -7}, fillPattern = FillPattern.Solid, extent = {{-12, 5}, {78, -13}}, textString = "Cl, Cd calculation")}),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end AirfoilSimple00;
