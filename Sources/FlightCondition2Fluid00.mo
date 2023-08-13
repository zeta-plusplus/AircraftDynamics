within AircraftDynamics.Sources;

model FlightCondition2Fluid00
  extends AircraftDynamics.Icons.Icon_FlightCondition2InletFluid00;
  
  /********************************************************
              imports
      ********************************************************/
  import Modelica.Constants;
  import units = Modelica.Units.SI;
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
  parameter Boolean use_u_alt = false "get alt from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true));
  parameter Boolean use_u_MN = false "get MN from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true));
  parameter Boolean use_u_dTamb = false "get dTamb from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true));
  parameter Boolean use_u_X = false "get fluid composition from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true));
  parameter Boolean use_u_C = false "get fluid trace substance from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true));
  parameter Boolean allowFlowReversal = false "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)" annotation(
    Dialog(tab = "Assumptions"),
    Evaluate = true);
  parameter Boolean printCmd = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(tab = "debug setting"));
  /* ---------------------------------------------
                parameters
      --------------------------------------------- */
  parameter units.Length alt_paramInput = 10000.0 "flight altitude, valid only when use_u_alt==false, value fixed through simulation" annotation();
  parameter Real MN_paramInput = 0.80 "flight mach number, valid only when use_u_MN==false, value fixed through simulation" annotation();
  parameter units.TemperatureDifference dTamb_paramInput = 0.0 "temperature diffrence from standard atmosphere, valid only when use_u_dTamb==false, value fixed through simulation" annotation();
  parameter Medium.MassFraction X_fluid_paramInput[Medium.nX] = Medium.X_default "fluid composition, valid only when use_u_X==false, value fixed through simulation" annotation();
  parameter Medium.ExtraProperty C_fluid_paramInput[Medium.nC](quantity = Medium.extraPropertiesNames) = fill(0, Medium.nC) "fluid trace substance, valid only when use_u_C==false, value fixed through simulation" annotation();
  //********** Initialization Parameters **********
  //--- fluid2Inlet ---
  parameter units.MassFlowRate m_flow2Inlet_init(displayUnit = "kg/s") = -1.0 "" annotation(
    Dialog(tab = "Initialization", group = "fluid2Inlet"));
  parameter units.Pressure p2Inlet_init(displayUnit = "Pa") = 101.3 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid2Inlet"));
  parameter units.Temperature T2Inlet_init(displayUnit = "K") = 288.15 "" annotation(
    Dialog(tab = "Initialization", group = "fluid2Inlet"));
  parameter units.SpecificEnthalpy h2Inlet_init(displayUnit = "J/kg") = T2Inlet_init * 1.004 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid2Inlet"));
  //--- fluidAmb ---
  parameter units.MassFlowRate m_flowAmb_init(displayUnit = "kg/s") = -1.0 * m_flow2Inlet_init "" annotation(
    Dialog(tab = "Initialization", group = "fluidAmb"));
  parameter units.Pressure pAmb_init(displayUnit = "Pa") = p2Inlet_init "" annotation(
    Dialog(tab = "Initialization", group = "fluidAmb"));
  parameter units.Temperature Tamb_init(displayUnit = "K") = T2Inlet_init "" annotation(
    Dialog(tab = "Initialization", group = "fluidAmb"));
  parameter units.SpecificEnthalpy hAmb_init(displayUnit = "J/kg") = Tamb_init * 1.004 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluidAmb"));
  //--- others ---
  parameter units.SpecificEntropy s_fluid_amb4source_init = 6800.0 "" annotation(
    Dialog(tab = "Initialization", group = "others"));
  parameter units.SpecificEntropy s_fluid_amb4sink_init = 7000.0 "" annotation(
    Dialog(tab = "Initialization", group = "others"));
  parameter units.SpecificEntropy s_fluid_inlet_init = 7000.0 "" annotation(
    Dialog(tab = "Initialization", group = "others"));
  /* ---------------------------------------------
        Internal variables
    --------------------------------------------- */
  units.SpecificEntropy s_fluid_amb4source(start = s_fluid_amb4source_init) "specific entropy, fluid_1" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  units.SpecificEntropy s_fluid_amb4sink(start = s_fluid_amb4sink_init) "specific entropy, fluid_1" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  units.SpecificEntropy s_fluid_inlet(start = s_fluid_inlet_init) "specific entropy, fluid_2" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  units.Pressure dynP "1/2*rhos*V^2";
  units.Velocity Vsound(start=AltMN2pTh.V_inf_init/AltMN2pTh.MN_init) "speed of sound" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true));
  
  /* ---------------------------------------------
            Internal objects
        --------------------------------------------- */
  inner outer AircraftDynamics.SimEnvironment environmentAircraftDynSim "System wide properties";
  AircraftDynamics.Utilities.AltMN2pTh00 AltMN2pTh(redeclare package Medium = Medium, T2Inlet_init = T2Inlet_init, Tamb_init = Tamb_init, h2Inlet_init = h2Inlet_init, hAmb_init = hAmb_init, m_flow2Inlet_init = m_flow2Inlet_init, m_flowAmb_init = m_flowAmb_init, p2Inlet_init = p2Inlet_init, pAmb_init = pAmb_init) annotation(
    Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT sourceFluidAmb4sink(redeclare package Medium = Medium, nPorts = 1, use_C_in = true, use_T_in = true, use_X_in = true, use_p_in = true, medium.p(start = pAmb_init), medium.T(start = Tamb_init), medium.h(start = hAmb_init), T_in(start = Tamb_init, min = 1.0e-10), p_in(start = pAmb_init, min = 1.0e-10)) annotation(
    Placement(visible = true, transformation(origin = {30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT sourceFluidAmb4source(redeclare package Medium = Medium, nPorts = 1, use_C_in = true, use_T_in = true, use_X_in = true, use_p_in = true, medium.p(start = pAmb_init), medium.T(start = Tamb_init), medium.h(start = hAmb_init), T_in(start = Tamb_init, min = 1.0e-10), p_in(start = pAmb_init, min = 1.0e-10))  annotation(
    Placement(visible = true, transformation(origin = {50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT sourceFluidTotal(redeclare package Medium = Medium, nPorts = 1, use_C_in = true, use_T_in = true, use_X_in = true, use_p_in = true, medium.p(start = p2Inlet_init), medium.T(start = T2Inlet_init), medium.h(start = h2Inlet_init), T_in(start = T2Inlet_init, min = 1.0e-10), p_in(start = p2Inlet_init, min = 1.0e-10)) annotation(
    Placement(visible = true, transformation(origin = {70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  /* ---------------------------------------------
                Interface
        --------------------------------------------- */
  input Modelica.Blocks.Interfaces.RealInput u_alt(quantity = "Length", unit = "m", displayUnit = "m") if use_u_alt "flight altitude, valid only when use_u_alt==true" annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  input Modelica.Blocks.Interfaces.RealInput u_MN if use_u_MN "flight mach number, valid only when use_u_MN==true" annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  input Modelica.Blocks.Interfaces.RealInput u_dTamb(quantity = "ThermodynamicTemperature", unit = "K", displayUnit = "K") if use_u_dTamb "temperature difference from standard atmospere, valid only when use_u_dTamb==true" annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  input Modelica.Blocks.Interfaces.RealInput u_X_fluid[Medium.nX] if use_u_X "composition of fluid, valid only when use_u_X==true" annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  input Modelica.Blocks.Interfaces.RealInput u_C_fluid[Medium.nC] if use_u_C "trace substance of fluid, valid only when use_u_C==true" annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_amb4sink(redeclare package Medium = Medium, m_flow(start = m_flowAmb_init, min = if allowFlowReversal then -Constants.inf else 0.0), h_outflow(start = hAmb_init), p(start = pAmb_init)) "ambient port supposed to used as sink" annotation(
    Placement(visible = true, transformation(origin = {40, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_total(redeclare package Medium = Medium, m_flow(start = m_flow2Inlet_init, max = if allowFlowReversal then +Constants.inf else 0.0), h_outflow(start = h2Inlet_init), p(start = p2Inlet_init)) annotation(
    Placement(visible = true, transformation(origin = {100, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_V_inf(quantity = "Velocity", unit = "m/s", displayUnit = "m/s") "[m/s], free stream velocity" annotation(
    Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_qBar(unit="Pa", displayUnit="Pa") "1/2*rhos*V^2" annotation(
    Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Blocks.Nonlinear.Limiter limiter1(strict = true, uMax = Modelica.Constants.inf, uMin = 1.0e-10) annotation(
    Placement(visible = true, transformation(origin = {0, 58}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter2(strict = true, uMax = Modelica.Constants.inf, uMin = 1.0e-10) annotation(
    Placement(visible = true, transformation(origin = {-1, 28}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter3(strict = true, uMax = Modelica.Constants.inf, uMin = 1.0e-10) annotation(
    Placement(visible = true, transformation(origin = {25, -2}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter4(strict = true, uMax = Modelica.Constants.inf, uMin = 1.0e-10) annotation(
    Placement(visible = true, transformation(origin = {5, -11}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_amb4source(redeclare package Medium = Medium, m_flow(start = m_flowAmb_init, min = if allowFlowReversal then -Constants.inf else 0.0), h_outflow(start = hAmb_init), p(start = pAmb_init)) "ambient port supposed to used as source" annotation(
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus infoBus1 annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                  output Modelica.Blocks.Interfaces.RealOutput y_Vsound(displayUnit = "Pa", unit = "Pa") annotation(
    Placement(visible = true, transformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

//**************************************************
algorithm
//##### none #####
//**************************************************
equation
  connect(AltMN2pTh.y_V_inf, y_V_inf) annotation(
    Line(points = {{-23, -23}, {-24, -23}, {-24, -40}, {110, -40}}, color = {0, 0, 127}));
  connect(sourceFluidAmb4source.ports[1], port_amb4source) annotation(
    Line(points = {{60, 40}, {88, 40}, {88, 60}, {100, 60}, {100, 60}}, color = {0, 127, 255}));
  connect(limiter2.y, sourceFluidAmb4source.T_in) annotation(
    Line(points = {{4, 28}, {18, 28}, {18, 44}, {38, 44}, {38, 44}}, color = {0, 0, 127}));
  connect(limiter1.y, sourceFluidAmb4source.p_in) annotation(
    Line(points = {{6, 58}, {10, 58}, {10, 48}, {38, 48}, {38, 48}}, color = {0, 0, 127}));
  connect(sourceFluidAmb4sink.ports[1], port_amb4sink) annotation(
    Line(points = {{40, 70}, {40, 100}}, color = {0, 127, 255}));
  connect(limiter1.y, sourceFluidAmb4sink.p_in) annotation(
    Line(points = {{5.5, 58}, {8.5, 58}, {8.5, 78}, {18, 78}}, color = {0, 0, 127}));
  connect(limiter2.y, sourceFluidAmb4sink.T_in) annotation(
    Line(points = {{4.5, 28}, {12, 28}, {12, 74}, {18, 74}}, color = {0, 0, 127}));
  connect(AltMN2pTh.y_pAmb, limiter1.u) annotation(
    Line(points = {{-17, 34}, {-12, 34}, {-12, 58}, {-6, 58}}, color = {0, 0, 127}));
  connect(AltMN2pTh.y_Tamb, limiter2.u) annotation(
    Line(points = {{-17, 25}, {-11.5, 25}, {-11.5, 28}, {-7, 28}}, color = {0, 0, 127}));
  connect(AltMN2pTh.y_pTot, limiter3.u) annotation(
    Line(points = {{-17, 7}, {0, 7}, {0, -2}, {19, -2}}, color = {0, 0, 127}));
  connect(limiter3.y, sourceFluidTotal.p_in) annotation(
    Line(points = {{30.5, -2}, {58, -2}}, color = {0, 0, 127}));
  connect(AltMN2pTh.y_Ttot, limiter4.u) annotation(
    Line(points = {{-17, -2}, {-8, -2}, {-8, -11}, {-1, -11}}, color = {0, 0, 127}));
  connect(limiter4.y, sourceFluidTotal.T_in) annotation(
    Line(points = {{10.5, -11}, {39.5, -11}, {39.5, -6}, {58, -6}}, color = {0, 0, 127}));
  connect(sourceFluidTotal.ports[1], port_total) annotation(
    Line(points = {{80, -10}, {100, -10}}, color = {0, 127, 255}));
  if printCmd == true then
    assert(sourceFluidAmb4sink.medium.p <= 0.0, getInstanceName() + ", sourceFluidAmb.medium.p=" + String(sourceFluidAmb4sink.medium.p), AssertionLevel.warning);
    assert(sourceFluidAmb4source.medium.p <= 0.0, getInstanceName() + ", sourceFluidAmb.medium.p=" + String(sourceFluidAmb4source.medium.p), AssertionLevel.warning);
    assert(sourceFluidTotal.medium.p <= 0.0, getInstanceName() + ", sourceFluid2Inlet.medium.p=" + String(sourceFluidTotal.medium.p), AssertionLevel.warning);
  end if;
/* ---------------------------------------------
    Connections, interface <-> internal variables
  --------------------------------------------- */
//--------------------
  if use_u_alt == true then
    AltMN2pTh.u_alt = u_alt;
  elseif use_u_alt == false then
    AltMN2pTh.u_alt = alt_paramInput;
  end if;
//--------------------
  if use_u_MN == true then
    AltMN2pTh.u_MN = u_MN;
  elseif use_u_MN == false then
    AltMN2pTh.u_MN = MN_paramInput;
  end if;
//--------------------
  if use_u_dTamb == true then
    AltMN2pTh.u_dTamb = u_dTamb;
  elseif use_u_dTamb == false then
    AltMN2pTh.u_dTamb = dTamb_paramInput;
  end if;
//--------------------
  if use_u_X == true then
    AltMN2pTh.u_X = u_X_fluid;
    sourceFluidAmb4sink.X_in = u_X_fluid;
    sourceFluidAmb4source.X_in = u_X_fluid;
    sourceFluidTotal.X_in = u_X_fluid;
  elseif use_u_X == false then
    AltMN2pTh.u_X = X_fluid_paramInput;
    sourceFluidAmb4sink.X_in = X_fluid_paramInput;
    sourceFluidAmb4source.X_in = X_fluid_paramInput;
    sourceFluidTotal.X_in = X_fluid_paramInput;
  end if;
//--------------------
  if use_u_C == true then
    sourceFluidAmb4sink.C_in = u_C_fluid;
    sourceFluidAmb4source.C_in = u_C_fluid;
    sourceFluidTotal.C_in = u_C_fluid;
  elseif use_u_C == false then
    sourceFluidAmb4sink.C_in = C_fluid_paramInput;
    sourceFluidAmb4source.C_in = C_fluid_paramInput;
    sourceFluidTotal.C_in = C_fluid_paramInput;
  end if;
  y_qBar = dynP;
//--------------------
  //connect(Vsound, AltMN2pTh.infoBus1.Vsound);
  //Vsound= AltMN2pTh.infoBus1.Vsound;
  Vsound= AltMN2pTh.Vsound;
  //connect(infoBus1.Vsound, Vsound);
  
  /* ---------------------------------------------
    Connections, interface <-> internal variables
  --------------------------------------------- */
  
  s_fluid_amb4sink = Medium.specificEntropy(Medium.setState_phX(sourceFluidAmb4sink.medium.p, sourceFluidAmb4sink.medium.h, sourceFluidAmb4sink.medium.X));
  s_fluid_amb4source = Medium.specificEntropy(Medium.setState_phX(sourceFluidAmb4source.medium.p, sourceFluidAmb4source.medium.h, sourceFluidAmb4source.medium.X));
  s_fluid_inlet = Medium.specificEntropy(Medium.setState_phX(sourceFluidTotal.medium.p, sourceFluidTotal.medium.h, sourceFluidTotal.medium.X));
  
  dynP= 1.0/2.0*(AltMN2pTh.y_V_inf ^2.0)*AltMN2pTh.fluidAmb.d;
/********************************************************
  Graphics
********************************************************/
  connect(AltMN2pTh.y_Vsound, y_Vsound) annotation(
    Line(points = {{-32, -22}, {-32, -80}, {110, -80}}, color = {0, 0, 127}));
  annotation(
    defaultComponentName = "Flt2Fluid",
    Documentation(info = "<html>
  <a href=modelica://PropulsionSystem/docs/Sources/FlightCondition2InletFluid00.html> Document html page</a>
  
  <h4>example/demo models</h4>
    <ul>
    <li><a href=\"modelica://PropulsionSystem.Examples.Elements.BasicElements.FlightCondition2InletFluid00_ex01\"> PropulsionSystem.Examples.BasicElements.FlightCondition2InletFluid00_ex01 </a> </li>
    </ul>
    
  <h4>classes which this component call (those in MSL are not listed) </h4>
    <p> -> none </p>
    
  <h4>classes from which this component extend </h4>
    <ul>
    <li><a href=\"modelica://PropulsionSystem.BaseClasses.BasicElements.FlightCondition2InletFluidBase00\"> PropulsionSystem.BaseClasses.BasicElements.FlightCondition2InletFluidBase00 </a> </li>
    </ul>

</html>"),
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-54, 98}, extent = {{4, -1}, {36, -11}}, textString = "Amb_sink"), Text(origin = {52, 2}, extent = {{4, -1}, {36, -11}}, textString = "Fluid_total"), Rectangle(origin = {-74, 79}, extent = {{-26, 21}, {174, -179}}), Text(origin = {62, -40}, extent = {{10, -1}, {36, -11}}, textString = "V_inf"), Text(origin = {60, 98}, extent = {{-4, -3}, {36, -11}}, textString = "Amb"), Line(origin = {78.3757, 5.42278}, points = {{-6, 0}, {8, 0}}, thickness = 1.5, arrow = {Arrow.None, Arrow.Open}, arrowSize = 5), Line(origin = {77.5507, 78.9134}, points = {{-6, 0}, {8, 0}}, thickness = 1.5, arrow = {Arrow.None, Arrow.Open}, arrowSize = 6), Line(origin = {13.4012, 86.2072}, points = {{-10, 0}, {-10, -12}}, thickness = 1.5, arrow = {Arrow.None, Arrow.Open}, arrowSize = 6), Text(origin = {50, -60}, extent = {{10, -13}, {48, -25}}, textString = "qBar"), Text(origin = {-62, -101}, extent = {{-38, -3}, {162, -19}}, textString = "%name")}));
  
  
end FlightCondition2Fluid00;
