within AircraftDynamics.Aerodynamics.Components;

model WingSimple00
  extends AircraftDynamics.Icons.Icon_WingSimple;
  //----- imports -----
  import Modelica.Constants;
  /********************************************************
             Declaration
          ********************************************************/
  //********** Package **********
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  //********** Parameters **********
  parameter Modelica.SIunits.Angle inciAng_param(displayUnit = "deg") = 0.0 "wing incident angle with respect to aircraft ref. center line" annotation(
    Dialog(group = "Geometry and Characteristics, wing"));
  //--- inner-connected, to AirfoilSimple ---
  inner parameter Real ClmaxDes = 1.5 "" annotation(
    Dialog(group = "Characteristics, airfoil"));
  inner parameter Modelica.SIunits.Angle alpha4Cl0des(displayUnit = "deg") = 0.0 "" annotation(
    Dialog(group = "Characteristics, airfoil"));
  inner parameter Modelica.SIunits.Angle alpha4ClmaxDes(displayUnit = "deg") = 15.0 * Modelica.Constants.pi / 180 "" annotation(
    Dialog(group = "Characteristics, airfoil"));
  inner parameter Modelica.SIunits.Angle alpha4ClminDes(displayUnit = "deg") = -15.0 * Modelica.Constants.pi / 180 "" annotation(
    Dialog(group = "Characteristics, airfoil"));
  inner parameter Real CdfDes = 0.01 "" annotation(
    Dialog(group = "Characteristics, airfoil"));
  inner parameter Real alpha_CdpMinDes(displayUnit = "deg") = 0.0 * Modelica.Constants.pi / 180 "" annotation(
    Dialog(group = "Characteristics, airfoil"));
  inner parameter Real kCdpDes = 0.1 "" annotation(
    Dialog(group = "Characteristics, airfoil"));
  inner parameter Real pwrCdpDes = 4.0 "" annotation(
    Dialog(group = "Characteristics, airfoil"));
  inner parameter Real kCdp_1_des = 0.8 "" annotation(
    Dialog(group = "Characteristics, airfoil"));
  inner parameter Real pwrCdp_1_des = 5.0 "" annotation(
    Dialog(group = "Characteristics, airfoil"));
  //--- inner-connected, to Airfoil2WingSimple ---
  inner parameter Real ARdes = 5.0 "" annotation(
    Dialog(group = "Geometry and Characteristics, wing"));
  inner parameter Real rambdaDes = 1.0 "" annotation(
    Dialog(group = "Geometry and Characteristics, wing"));
  inner parameter Modelica.SIunits.Angle sweepDes(displayUnit = "deg") = 0.0 "" annotation(
    Dialog(group = "Geometry and Characteristics, wing"));
  inner parameter Modelica.SIunits.Area Sdes = 1.0 "" annotation(
    Dialog(group = "Geometry and Characteristics, wing"));
  inner parameter Real effOsDes = 0.8 "" annotation(
    Dialog(group = "Geometry and Characteristics, wing"));
  inner parameter Modelica.SIunits.Length ChRootDes = 1.0 "" annotation(
    Dialog(group = "Geometry and Characteristics, wing"));
  //********** Initialization Parameters **********
  //--- fluid_amb, port_amb ---
  parameter Modelica.SIunits.MassFlowRate m_flowAmb_init(displayUnit = "kg/s") = 0.0 "" annotation(
    Dialog(tab = "Initialization", group = "Fluid states"));
  parameter Modelica.SIunits.Pressure pAmb_init(displayUnit = "Pa") = 101.3 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "Fluid states"));
  parameter Modelica.SIunits.Temperature Tamb_init(displayUnit = "K") = 288.15 "" annotation(
    Dialog(tab = "Initialization", group = "Fluid states"));
  parameter Modelica.SIunits.SpecificEnthalpy hAmb_init(displayUnit = "J/kg") = 1.004 * 1000 * 288.15 "" annotation(
    Dialog(tab = "Initialization", group = "Fluid states"));
  //********** Internal variables **********
  Modelica.SIunits.Force Lf;
  Modelica.SIunits.Force Df;
  Modelica.SIunits.Force Fz "force along z-axis of flt. obj.";
  Modelica.SIunits.Force Fx "force along x-axis of flt. obj.";
  Modelica.SIunits.Force Df0 "total of zero-lift(parasite) drag";
  Modelica.SIunits.Force DfFric "friction drag";
  Modelica.SIunits.Force DfPress "pressure drag";
  Modelica.SIunits.Force DfInduced "induced drag";
  Modelica.SIunits.Velocity Vflow;
  Modelica.SIunits.Velocity Vsound;
  Modelica.SIunits.Angle alpha;
  Modelica.SIunits.Angle alphaFlt;
  Modelica.SIunits.Angle inciAng;
  Real Mn;
  Real CL;
  Real CD;
  Real CD0;
  Real CDf;
  Real CDp;
  Real CDi;
  Real LqD;
  Modelica.SIunits.Area S;
  Real AR;
  Real rambda;
  Real sweep;
  Real effOs;
  Modelica.SIunits.Length ChRoot;
  Medium.BaseProperties fluid_amb(p.start = pAmb_init, T.start = Tamb_init, state.p.start = pAmb_init, state.T.start = Tamb_init, h.start = hAmb_init) "flow station of amb";
  //********** Interfaces **********
  Modelica.Fluid.Interfaces.FluidPort_a port_amb(redeclare package Medium = Medium, m_flow.start = m_flowAmb_init, h_outflow.start = hAmb_init) "" annotation(
    Placement(visible = true, transformation(origin = {-80, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-21, 139}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_Lf annotation(
    Placement(visible = true, transformation(origin = {40, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {20, 145}, extent = {{-5, -5}, {5, 5}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput y_Df annotation(
    Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {45, -21}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.BaseClasses.AirfoilSimple00 airfoilSimple001 annotation(
    Placement(visible = true, transformation(origin = {-49.75, 39.8}, extent = {{-50.25, -40.2}, {50.25, 40.2}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus busFltStates1 annotation(
    Placement(visible = true, transformation(origin = {-80, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.BaseClasses.Airfoil2WingSimple00 airfoil2WingSimple001(
    switchInput_ARdes = AircraftDynamics.Types.switches.switch_input.via_expConnector, 
    switchInput_ChRootDes = AircraftDynamics.Types.switches.switch_input.via_expConnector, 
    switchInput_Sdes = AircraftDynamics.Types.switches.switch_input.via_expConnector, 
    switchInput_effOsDes = AircraftDynamics.Types.switches.switch_input.via_expConnector, 
    switchInput_rambdaDes = AircraftDynamics.Types.switches.switch_input.via_expConnector, 
    switchInput_sweepDes = AircraftDynamics.Types.switches.switch_input.via_expConnector
  ) annotation(
    Placement(visible = true, transformation(origin = {40, -30}, extent = {{-50, -50}, {50, 50}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_Fz annotation(
    Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {0, 145}, extent = {{-5, -5}, {5, 5}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput y_Fx annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {45, 0}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
algorithm

equation
  connect(alpha, airfoilSimple001.signalBus1.alpha) annotation(
    Line);
  connect(airfoilSimple001.signalBus2, airfoil2WingSimple001.signalBus1) annotation(
    Line(points = {{-25, 0}, {-25, -89}, {15, -89}, {15, -80}}, color = {255, 204, 51}, thickness = 0.5));
  connect(Mn, airfoil2WingSimple001.signalBus1.Mn) annotation(
    Line);
  connect(busFltStates1.Vflow, Vflow);
  connect(busFltStates1.Vsound, Vsound);
  connect(alphaFlt, busFltStates1.alpha);
  connect(Mn, busFltStates1.Mn);
//********** Connections, interface <-> internal variables **********
//-- port_amb --
  fluid_amb.p = port_amb.p;
  port_amb.h_outflow = fluid_amb.h;
  port_amb.Xi_outflow= fluid_amb.Xi;
  fluid_amb.h = actualStream(port_amb.h_outflow);
  fluid_amb.Xi = actualStream(port_amb.Xi_outflow);
  port_amb.m_flow = 1.0;
//-- else --
  y_Lf = Lf;
  y_Df = Df;
  y_Fz = Fz;
  y_Fx = Fx;
  CL = airfoil2WingSimple001.signalBus2.CL;
  CD = airfoil2WingSimple001.signalBus2.CD;
  CD0 = airfoil2WingSimple001.signalBus2.CD0;
  CDf = airfoil2WingSimple001.signalBus2.CDf;
  CDp = airfoil2WingSimple001.signalBus2.CDp;
  CDi = airfoil2WingSimple001.signalBus2.CDi;
  S = Sdes;
  S = airfoil2WingSimple001.signalBus1.S;
  AR = ARdes;
  AR = airfoil2WingSimple001.signalBus1.AR;
  rambda = rambdaDes;
  rambda = airfoil2WingSimple001.signalBus1.rambda;
  sweep = sweepDes;
  sweep = airfoil2WingSimple001.signalBus1.sweep;
  effOs = effOsDes;
  effOs = airfoil2WingSimple001.signalBus1.effOs;
  ChRoot = ChRootDes;
  ChRoot = airfoil2WingSimple001.signalBus1.ChRoot;
//********** Eqns describing physics **********
  inciAng = inciAng_param;
  alpha = alphaFlt + inciAng;
  Vsound = Medium.velocityOfSound(fluid_amb.state);
  Mn = Vflow / Vsound;
  Lf = CL * S * 1 / 2 * fluid_amb.d * (sign(Vflow) * abs(Vflow) ^ 2.0);
  Df = CD * S * 1 / 2 * fluid_amb.d * (sign(Vflow) * abs(Vflow) ^ 2.0);
  Df0 = CD0 * S * 1 / 2 * fluid_amb.d * (sign(Vflow) * abs(Vflow) ^ 2.0);
  DfFric = CDf * S * 1 / 2 * fluid_amb.d * (sign(Vflow) * abs(Vflow) ^ 2.0);
  DfPress = CDp * S * 1 / 2 * fluid_amb.d * (sign(Vflow) * abs(Vflow) ^ 2.0);
  DfInduced = CDi * S * 1 / 2 * fluid_amb.d * (sign(Vflow) * abs(Vflow) ^ 2.0);
  Fz = Lf * cos(alpha) + Df * sin(alpha);
  Fx = Df * cos(alpha) - Lf * sin(alpha);
  if 0 < Df and 0 < Lf then
    LqD = Lf / Df;
  else
    LqD = 0.0;
  end if;
  
  annotation(
    defaultComponentName="wing",
    Documentation(
    info = "<html>
<a href=\"modelica://AircraftDynamics/docs/Aerodynamics/Components/WingSimple00.html\"> Document html page</a>
<p>&emsp; </p>
<h4>example/demo models</h4>
  <ul>
  <li><a href=\"modelica://AircraftDynamics.Aerodynamics.Example.test.WingSimple00_test01\">AircraftDynamics.Aerodynamics.Example.test.WingSimple00_test01 </a> </li>
  <li><a href=\"modelica://AircraftDynamics.Aerodynamics.Example.test.WingSimple00_test02\">AircraftDynamics.Aerodynamics.Example.test.WingSimple00_test02 </a> </li>
  </ul>

<h4>classes which this component call (those of MSL are not listed) </h4>
  <ul>
  <li><a href=\"modelica://AircraftDynamics.Aerodynamics.BaseClasses.AirfoilSimple00\">AircraftDynamics.Aerodynamics.BaseClasses.AirfoilSimple00 </a></li>
  </ul>

</html>"
    ),
    Icon(coordinateSystem(initialScale = 0.05, extent = {{-40, -140}, {40, 140}}), graphics = {Text(origin = {-44, -107}, extent = {{4, -13}, {84, -25}}, textString = "%name"), Text(origin = {24, 134}, fillPattern = FillPattern.Solid, extent = {{-10, 4}, {4, -6}}, textString = "L"), Text(origin = {29, 6}, fillPattern = FillPattern.Solid, extent = {{-6, 0}, {10, -10}}, textString = "Fx"), Text(origin = {2, 134}, fillPattern = FillPattern.Solid, extent = {{-10, 4}, {6, -6}}, textString = "Fz"), Text(origin = {31, -14}, fillPattern = FillPattern.Solid, extent = {{-8, 0}, {10, -10}}, textString = "D"), Text(origin = {-28, 130}, fillPattern = FillPattern.Solid, extent = {{-10, 4}, {6, -6}}, textString = "amb")}),
    Diagram(graphics = {Line(origin = {-19.8305, -47.7914}, points = {{-9.59038, 8.93611}, {-9.5904, -17.0639}}, thickness = 1.25, arrow = {Arrow.None, Arrow.Open}, arrowSize = 4), Text(origin = {-68, -10}, extent = {{-26, 4}, {26, -4}}, textString = "2D airfoil calc."), Text(origin = {10, -58}, extent = {{-14, 6}, {78, -26}}, textString = "calc of 2D airfoil -> 3D wing")}, coordinateSystem(initialScale = 0.05)),
    __OpenModelica_commandLineOptions = ""
    );
  
end WingSimple00;
