within AircraftDynamics.Utilities;

block AltMN2pTh00
  extends AircraftDynamics.Icons.Icon_FlightCondition2InletFluid00;
  
  /********************************************************
              imports   
  ********************************************************/
  import Modelica.Constants;
  /********************************************************
                     Declaration
  ********************************************************/
  /* ---------------------------------------------
            Package
  --------------------------------------------- */
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  
  
  
  /* ---------------------------------------------
            parameters
  --------------------------------------------- */
  //--- fluid2Inlet ---
  parameter Modelica.SIunits.MassFlowRate m_flow2Inlet_init(displayUnit = "kg/s") = -1.0 "" annotation(
    Dialog(tab = "Initialization", group = "fluid2Inlet"));
  parameter Modelica.SIunits.Pressure p2Inlet_init(displayUnit = "Pa") = 101.3 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid2Inlet"));
  parameter Modelica.SIunits.Temperature T2Inlet_init(displayUnit = "K") = 288.15 "" annotation(
    Dialog(tab = "Initialization", group = "fluid2Inlet"));
  parameter Modelica.SIunits.SpecificEnthalpy h2Inlet_init(displayUnit = "J/kg") = T2Inlet_init*1.004 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid2Inlet"));
  //--- fluidAmb ---
  parameter Modelica.SIunits.MassFlowRate m_flowAmb_init(displayUnit = "kg/s") = -1.0 * m_flow2Inlet_init "" annotation(
    Dialog(tab = "Initialization", group = "fluidAmb"));
  parameter Modelica.SIunits.Pressure pAmb_init(displayUnit = "Pa") = p2Inlet_init "" annotation(
    Dialog(tab = "Initialization", group = "fluidAmb"));
  parameter Modelica.SIunits.Temperature Tamb_init(displayUnit = "K") = T2Inlet_init "" annotation(
    Dialog(tab = "Initialization", group = "fluidAmb"));
  parameter Modelica.SIunits.SpecificEnthalpy hAmb_init(displayUnit = "J/kg") = Tamb_init*1.004 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluidAmb"));
  //--- others ---
  parameter Real MN_init=0.01 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.Length alt_init=1.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.TemperatureDifference dTamb_init=0.01 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.Velocity V_inf_init=0.01 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  
  
  
  /* ---------------------------------------------
          Internal variables
  --------------------------------------------- */
  Modelica.SIunits.Length alt(start=alt_init) "altitude" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real MN(start=MN_init) "flight mach number" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.TemperatureDifference dTamb(start=dTamb_init) "deviation from std atmospheric temperature" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.Velocity V_inf(start=V_inf_init) "free stream velocity" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.Velocity Vsound(start=V_inf_init/MN_init) "speed of sound" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true));
  //----------
  Modelica.SIunits.AbsolutePressure pAmb(start=pAmb_init) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.Temperature Tamb(start=Tamb_init) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  //----------
  Modelica.SIunits.AbsolutePressure pAmbStd(start=pAmb_init) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.Temperature TambStd(start=Tamb_init) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  //----------
  /* ---------------------------------------------
          Internal objects
  --------------------------------------------- */
  inner outer AircraftDynamics.SimEnvironment environmentAircraftDynSim "System wide properties";
  Medium.BaseProperties fluidTot(
    p(start=p2Inlet_init),
    T(start=T2Inlet_init),
    h(start=h2Inlet_init),
    state.p(start=p2Inlet_init),
    state.T(start=T2Inlet_init)
  ) "flow station of total";
  Medium.BaseProperties fluidAmb(
    p(start=pAmb_init),
    T(start=Tamb_init),
    h(start=hAmb_init),
    state.p(start=pAmb_init),
    state.T(start=Tamb_init)
  ) "flow station of static";
  Medium.BaseProperties fluidAmbStd(
    p(start=pAmb_init),
    T(start=Tamb_init),
    h(start=hAmb_init),
    state.p(start=pAmb_init),
    state.T(start=Tamb_init)
  ) "flow station of static, standard condition";
  //----------
  /* ---------------------------------------------
          Interface
  --------------------------------------------- */
  input Modelica.Blocks.Interfaces.RealInput u_alt(quantity = "Length", unit = "m", displayUnit = "m") "[m], flight altitude" annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  input Modelica.Blocks.Interfaces.RealInput u_MN "[nond], flight mach number" annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  input Modelica.Blocks.Interfaces.RealInput u_dTamb(quantity = "ThermodyamicTemperature", unit = "K", displayUnit = "K") "[K], temperature difference from standard atmosphere" annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  input Modelica.Blocks.Interfaces.RealInput u_X[Medium.nX] "[nond], fluid composition" annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_pAmb(quantity = "Pressure", unit = "Pa", displayUnit = "bar", start=pAmb_init, min=1.0e-10) "[Pa], ambient pressure" annotation(
    Placement(visible = true, transformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_Tamb(quantity = "Temperature", unit = "K", displayUnit = "degC", start=Tamb_init, min=1.0e-10) "[K], ambient temperature" annotation(
    Placement(visible = true, transformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_hAmb(quantity = "SpecificEnthalpy", unit = "J/kg", displayUnit = "J/kg", start=hAmb_init, min=1.0e-10) "[J/kg], ambient specific enthalpy" annotation(
    Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_pTot(quantity = "Pressure", unit = "Pa", displayUnit = "bar", start=p2Inlet_init, min=1.0e-10) "[Pa], total pressure of free stream" annotation(
    Placement(visible = true, transformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_Ttot(quantity = "Temperature", unit = "K", displayUnit = "degC", start=T2Inlet_init, min=1.0e-10) "[K], total temperature of free stream" annotation(
    Placement(visible = true, transformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_hTot(quantity = "SpecificEnthalpy", unit = "J/kg", displayUnit = "J/kg", start=h2Inlet_init, min=1.0e-10) "[J/kg], total specific enthalpy of free stream" annotation(
    Placement(visible = true, transformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_V_inf(quantity = "Velocity", unit = "m/s", displayUnit = "m/s", start=V_inf_init) "[m/s], free stream velocity" annotation(
    Placement(visible = true, transformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  AircraftDynamics.Types.InfoBus infoBus1 annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //**************************************************
  output Modelica.Blocks.Interfaces.RealOutput y_Vsound(displayUnit = "m/s", quantity = "Velocity", start = V_inf_init, unit = "m/s") annotation(
    Placement(visible = true, transformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
/* ---------------------------------------------
  Connections, interface <-> internal variables
  --------------------------------------------- */
  alt = u_alt;
  MN = u_MN;
  dTamb = u_dTamb;
  y_pAmb = pAmb;
  y_Tamb = Tamb;
  y_hAmb = fluidAmb.h;
  y_pTot = fluidTot.p;
  y_Ttot = fluidTot.T;
  y_hTot = fluidTot.h;
  y_V_inf = V_inf;
  y_Vsound= Vsound;
  connect(infoBus1.Vsound, Vsound);
/* ---------------------------------------------
  Eqns describing physics
  --------------------------------------------- */
// set fluid station states
  fluidAmbStd.Xi = u_X[1:Medium.nXi];
  fluidAmb.Xi = u_X[1:Medium.nXi];
  fluidTot.Xi = u_X[1:Medium.nXi];
  fluidAmbStd.state.p = pAmbStd;
  fluidAmbStd.state.T = TambStd;
  fluidAmb.state.p = pAmb;
  fluidAmb.state.T = Tamb;
//-- figure out velocity --
  Vsound = Medium.velocityOfSound(fluidAmb.state);
  V_inf = MN * Medium.velocityOfSound(fluidAmb.state);
//-- velocity to total pressure --
  fluidTot.h = fluidAmb.h + V_inf ^ 2.0 / 2.0;
  fluidTot.h = Medium.isentropicEnthalpy(fluidTot.p, fluidAmb.state);
algorithm
//-- regression curve of atmospheric table --
// curves of T, P
  if environmentAircraftDynSim.alt_ground <= alt and alt < environmentAircraftDynSim.alt_UpBdTropos then
    TambStd := max((environmentAircraftDynSim.T_ground - 0.0064878 * (alt - environmentAircraftDynSim.alt_ground)), 1.0e-10);
    Tamb := max((TambStd + dTamb), 1.0e-10);
    pAmbStd := max((environmentAircraftDynSim.p_ground * (TambStd / environmentAircraftDynSim.T_ground) ^ (-1.0 * environmentAircraftDynSim.gravity / (environmentAircraftDynSim.LapseR1 * fluidAmbStd.R))), 1.0e-10);
    pAmb := max((environmentAircraftDynSim.p_ground * (Tamb / environmentAircraftDynSim.T_ground) ^ (-1.0 * environmentAircraftDynSim.gravity / (environmentAircraftDynSim.LapseR1 * fluidAmb.R))), 1.0e-10);
  elseif environmentAircraftDynSim.alt_UpBdTropos <= alt and alt < environmentAircraftDynSim.alt_UpBdStratos then
    TambStd := max(environmentAircraftDynSim.T_UpBdTropos, 1.0e-10);
    Tamb := max((TambStd + dTamb), 1.0e-10);
    pAmbStd := max((environmentAircraftDynSim.p_UpBdTropos * exp(-1.0 * environmentAircraftDynSim.gravity / (fluidAmbStd.R * TambStd) * (alt - environmentAircraftDynSim.T_UpBdTropos))), 1.0e-10);
    pAmb := max((environmentAircraftDynSim.p_UpBdTropos * exp(-1.0 * environmentAircraftDynSim.gravity / (fluidAmb.R * Tamb) * (alt - environmentAircraftDynSim.T_UpBdTropos))), 1.0e-10);
  end if;



/********************************************************
  Graphics
********************************************************/
  annotation(
    defaultComponentName = "AltMN2pTh",
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {-74, 79}, extent = {{-26, 21}, {174, -179}})}));
  
  
end AltMN2pTh00;
