within AircraftDynamics.Aerodynamics.Components;

model Flight2Fluid
  extends AircraftDynamics.Icons.Icon_FlightCondition2InletFluid00;
  import Modelica.Constants;
  /********************************************************
                   Declaration
    ********************************************************/
  //********** Package **********
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  //********** Parameters **********
  //----- switches -----
  parameter Boolean allowFlowReversal = true "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)" annotation(
    Dialog(tab = "Assumptions"),
    Evaluate = true);
  parameter AircraftDynamics.Types.switches.switch_input switchInput_alt = AircraftDynamics.Types.switches.switch_input.use_desValue "" annotation(
    Dialog(group = "switch"),
    choicesAllMatching = true,
    Evaluate = true,
    HideResult = true);
  parameter AircraftDynamics.Types.switches.switch_input switchInput_MN = AircraftDynamics.Types.switches.switch_input.use_desValue "" annotation(
    Dialog(group = "switch"),
    choicesAllMatching = true,
    Evaluate = true,
    HideResult = true);
  parameter AircraftDynamics.Types.switches.switch_input switchInput_dTamb = AircraftDynamics.Types.switches.switch_input.use_desValue "" annotation(
    Dialog(group = "switch"),
    choicesAllMatching = true,
    Evaluate = true,
    HideResult = true);
  parameter AircraftDynamics.Types.switches.switch_input switchInput_AoA = AircraftDynamics.Types.switches.switch_input.use_desValue "" annotation(
    Dialog(group = "switch"),
    choicesAllMatching = true,
    Evaluate = true,
    HideResult = true);
  parameter AircraftDynamics.Types.switches.switch_input switchInput_sideSlip = AircraftDynamics.Types.switches.switch_input.use_desValue "" annotation(
    Dialog(group = "switch"),
    choicesAllMatching = true,
    Evaluate = true,
    HideResult = true);
  parameter AircraftDynamics.Types.switches.switch_input switchInput_relHum = AircraftDynamics.Types.switches.switch_input.use_desValue "" annotation(
    Dialog(group = "switch"),
    choicesAllMatching = true,
    Evaluate = true,
    HideResult = true);
  //----- design parameters -----
  parameter Modelica.SIunits.Length altDes = 0.0 "altitude" annotation(
    Evaluate = true,
    Dialog(enable = not use_alt_in));
  parameter Real MNdes = 0.0 "flight mach number" annotation(
    Evaluate = true,
    Dialog(enable = not use_MN_in));
  parameter Modelica.SIunits.TemperatureDifference dTambDes = 0.0 "deviation from std atmospheric temperature" annotation(
    Evaluate = true,
    Dialog(enable = not use_dTamb_in));
  parameter Real relHumDes = 0.0 "relative humidity" annotation(
    Evaluate = true,
    Dialog(enable = not use_dTamb_in));
  parameter Modelica.SIunits.Angle AoAdes = 0.0 "" annotation(
    Evaluate = true,
    Dialog(enable = not use_AOA_in));
  parameter Modelica.SIunits.Angle sideSlipDes = 0.0 "" annotation(
    Evaluate = true,
    Dialog(enable = not use_sideSlip_in));
  parameter Integer n_fluidAmb = 1 "" annotation(
    Dialog(group = "misc setting"));
  //********** Internal variables **********
  Modelica.SIunits.Length alt(start = altDes) "altitude";
  Real MN(start = MNdes) "flight mach number";
  Modelica.SIunits.TemperatureDifference dTamb(start = dTambDes) "deviation from std atmospheric temperature";
  Real relHum(start = relHumDes) "relative humidity";
  Modelica.SIunits.Angle AoA(start = AoAdes) "";
  Modelica.SIunits.Angle sideSlip(start = sideSlipDes) "";
  //***** constants *****
  constant Modelica.SIunits.Acceleration gAccel = 9.81;
  // gound
  constant Modelica.SIunits.Length alt_ground = 0.0;
  constant Modelica.SIunits.Temperature T_ground = 288.16;
  constant Modelica.SIunits.AbsolutePressure p_ground = 101323.7;
  // upper bound of troposhere
  constant Modelica.SIunits.Length alt_UpBdTropos = 11019.1;
  constant Modelica.SIunits.Temperature T_UpBdTropos = 216.67;
  constant Modelica.SIunits.AbsolutePressure p_UpBdTropos = 22632.9;
  constant Real LapseR1 = -0.0064878;
  // upper bound of stratosphere
  constant Modelica.SIunits.Length alt_UpBdStratos = 25099.1;
  constant Modelica.SIunits.Temperature T_UpBdStratos = 216.67;
  constant Modelica.SIunits.AbsolutePressure p_UpBdStratos = 2486.4;
  constant Real LapseR2 = 0.0;
  //*****
  //
  Modelica.SIunits.AbsolutePressure pAmb;
  Modelica.SIunits.Temperature Tamb;
  Real Xamb[Medium.nX] = Medium.X_default;
  Modelica.SIunits.AbsolutePressure pAmbStd;
  Modelica.SIunits.Temperature TambStd;
  Real XambStd[Medium.nX] = Medium.X_default;
  // fluid stations
  Medium.BaseProperties fluid_tot "flow station, total";
  Medium.BaseProperties fluid_ambStd;
  Medium.BaseProperties fluid_amb;
  Modelica.SIunits.Velocity V_tot(start = 100) "";
  Modelica.SIunits.Pressure dynP "1/2*rhos*V^2";
  Modelica.Fluid.Sources.Boundary_pT fluidAmb(redeclare package Medium = Medium, nPorts = 1, use_C_in = false, use_T_in = true, use_X_in = true, use_p_in = true) "" annotation(
    Placement(visible = true, transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  //********** Interfaces **********
  Modelica.Blocks.Interfaces.RealInput u_alt if switchInput_alt == AircraftDynamics.Types.switches.switch_input.use_inputSignal annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_Mn if switchInput_MN == AircraftDynamics.Types.switches.switch_input.use_inputSignal annotation(
    Placement(visible = true, transformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_dTamb if switchInput_dTamb == AircraftDynamics.Types.switches.switch_input.use_inputSignal annotation(
    Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_AoA if switchInput_AoA == AircraftDynamics.Types.switches.switch_input.use_inputSignal annotation(
    Placement(visible = true, transformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_sideSlip if switchInput_sideSlip == AircraftDynamics.Types.switches.switch_input.use_inputSignal annotation(
    Placement(visible = true, transformation(origin = {-120, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_relHum if switchInput_relHum == AircraftDynamics.Types.switches.switch_input.use_inputSignal annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_fluidAmb(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_V_tot(unit="m/s",displayUnit="m/s") annotation(
    Placement(visible = true, transformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //********** Initialization **********
  parameter Medium.AbsolutePressure p_a_start = 101.3 * 1000 "Start value of pressure at port a" annotation(
    Dialog(tab = "Initialization"));
  parameter Medium.AbsolutePressure p_b_start = 101.3 * 1000 * 0.99 "Start value of pressure at port b" annotation(
    Dialog(tab = "Initialization"));
  parameter Medium.MassFlowRate m_flow_start = 10.0 "Start value for mass flow rate" annotation(
    Evaluate = true,
    Dialog(tab = "Initialization"));
  AircraftDynamics.Types.InfoBus signalBus1 annotation(
    Placement(visible = true, transformation(origin = {70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_Mn annotation(
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_dynP(unit="Pa", displayUnit="Pa") "1/2*rhos*V^2" annotation(
    Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  //********** Protected objects **********
  //##### none #####
algorithm
//-- regression curve of atmospheric table --
// curves of T, P
  if alt < alt_ground then
    TambStd := T_ground - 0.0064878 * (0.0 - alt_ground);
    Tamb := TambStd + dTamb;
    pAmbStd := p_ground * (TambStd / T_ground) ^ (-1.0 * gAccel / (LapseR1 * fluid_ambStd.R));
    pAmb := p_ground * (Tamb / T_ground) ^ (-1.0 * gAccel / (LapseR1 * fluid_amb.R));
  elseif alt_ground <= alt and alt < alt_UpBdTropos then
    TambStd := T_ground - 0.0064878 * (alt - alt_ground);
    Tamb := TambStd + dTamb;
    pAmbStd := p_ground * (TambStd / T_ground) ^ (-1.0 * gAccel / (LapseR1 * fluid_ambStd.R));
    pAmb := p_ground * (Tamb / T_ground) ^ (-1.0 * gAccel / (LapseR1 * fluid_amb.R));
  elseif alt_UpBdTropos <= alt and alt < alt_UpBdStratos then
    TambStd := T_UpBdTropos;
    Tamb := TambStd + dTamb;
    pAmbStd := p_UpBdTropos * exp(-1.0 * gAccel / (fluid_ambStd.R * TambStd) * (alt - T_UpBdTropos));
    pAmb := p_UpBdTropos * exp(-1.0 * gAccel / (fluid_amb.R * Tamb) * (alt - T_UpBdTropos));
  elseif alt_UpBdStratos <= alt then
    TambStd := T_UpBdTropos;
    Tamb := TambStd + dTamb;
    pAmbStd := p_UpBdTropos * exp(-1.0 * gAccel / (fluid_ambStd.R * TambStd) * (alt - T_UpBdTropos));
    pAmb := p_UpBdTropos * exp(-1.0 * gAccel / (fluid_amb.R * Tamb) * (alt - T_UpBdTropos));
  end if;
// troposphere, temperature gradient layer model
// stratosphere, temperature is constant
equation
//-- fluid_Amb --
  connect(fluidAmb.ports[1], port_fluidAmb) annotation(
    Line(points = {{0, 60}, {0, 60}, {0, 100}, {0, 100}}, color = {0, 127, 255}, thickness = 0.5));
  connect(fluid_amb.p, fluidAmb.p_in) annotation(
    Line);
  connect(fluid_amb.T, fluidAmb.T_in) annotation(
    Line);
  connect(fluid_amb.X, fluidAmb.X_in) annotation(
    Line);
//-- fluid_tot --
//********** Geometries **********
//##### none #####
//********** Connections, interface <-> internal variables **********
//-- alt --
  if switchInput_alt == AircraftDynamics.Types.switches.switch_input.use_inputSignal then
    alt = u_alt;
  elseif switchInput_alt == AircraftDynamics.Types.switches.switch_input.use_desValue then
    alt = altDes;
  end if;
//-- MN --
  if switchInput_MN == AircraftDynamics.Types.switches.switch_input.use_inputSignal then
    MN = u_Mn;
  elseif switchInput_MN == AircraftDynamics.Types.switches.switch_input.use_desValue then
    MN = MNdes;
  end if;
//-- dTamb --
  if switchInput_dTamb == AircraftDynamics.Types.switches.switch_input.use_inputSignal then
    dTamb = u_dTamb;
  elseif switchInput_dTamb == AircraftDynamics.Types.switches.switch_input.use_desValue then
    dTamb = dTambDes;
  end if;
//-- relHum --
  if switchInput_relHum == AircraftDynamics.Types.switches.switch_input.use_inputSignal then
    relHum = u_relHum;
  elseif switchInput_relHum == AircraftDynamics.Types.switches.switch_input.use_desValue then
    relHum = relHumDes;
  end if;
//-- AoA --
  if switchInput_AoA == AircraftDynamics.Types.switches.switch_input.use_inputSignal then
    AoA = u_AoA;
  elseif switchInput_AoA == AircraftDynamics.Types.switches.switch_input.use_desValue then
    AoA = AoAdes;
  end if;
//-- sieslip --
  if switchInput_sideSlip == AircraftDynamics.Types.switches.switch_input.use_inputSignal then
    sideSlip = u_sideSlip;
  elseif switchInput_sideSlip == AircraftDynamics.Types.switches.switch_input.use_desValue then
    sideSlip = sideSlipDes;
  end if;
//***** output signal *****
  y_V_tot = V_tot;
  y_Mn = MN;
  y_dynP= dynP;
// set fluid station states
  fluid_ambStd.state = Medium.setState_pTX(pAmbStd, TambStd, XambStd);
  fluid_amb.state = Medium.setState_pTX(pAmb, Tamb, Xamb);
//-- figure out velocity --
  V_tot = MN * Medium.velocityOfSound(fluid_amb.state);
  dynP= 1.0/2.0*fluid_amb.d*V_tot ^2.0;
//-- velocity to total pressure --
  fluid_tot.h = fluid_amb.h + V_tot ^ 2.0 / 2.0;
  fluid_tot.h = Medium.isentropicEnthalpy(fluid_tot.p, fluid_amb.state);
//---
  port_fluidAmb.Xi_outflow = fluid_tot.Xi;
/********************************************************
  Graphics
  ********************************************************/
  annotation(
    defaultComponentName = "flight2fluid",
    Icon(coordinateSystem(initialScale = 0.05)),
    Diagram(coordinateSystem(initialScale = 1.0)));
end Flight2Fluid;
