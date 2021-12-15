within AircraftDynamics.Aerodynamics.BaseClasses;

model Airfoil2WingSimple00
  extends AircraftDynamics.Icons.Icon_Airfoil2Wing;
  //----- imports -----
  import Modelica.Constants;
  /********************************************************
       Declaration
    ********************************************************/
  //********** Package **********
  //##### none #####
  //********** Parameters **********
  //----- switches -----
  parameter AircraftDynamics.Types.switches.switch_input switchInput_Sdes
      =AircraftDynamics.Types.switches.switch_input.use_desValue
   ""
    annotation(
    Dialog(group = "switch"),
    choicesAllMatching= true,   
    Evaluate = true,
    HideResult = true
    );
  
  parameter AircraftDynamics.Types.switches.switch_input switchInput_ARdes
      =AircraftDynamics.Types.switches.switch_input.use_desValue
   ""
    annotation(
    Dialog(group = "switch"),
    choicesAllMatching= true,   
    Evaluate = true,
    HideResult = true
    );
  
  parameter AircraftDynamics.Types.switches.switch_input switchInput_rambdaDes
      =AircraftDynamics.Types.switches.switch_input.use_desValue
   ""
    annotation(
    Dialog(group = "switch"),
    choicesAllMatching= true,   
    Evaluate = true,
    HideResult = true
    );
  
  parameter AircraftDynamics.Types.switches.switch_input switchInput_sweepDes
      =AircraftDynamics.Types.switches.switch_input.use_desValue
   ""
    annotation(
    Dialog(group = "switch"),
    choicesAllMatching= true,   
    Evaluate = true,
    HideResult = true
    );
  
  parameter AircraftDynamics.Types.switches.switch_input switchInput_effOsDes
      =AircraftDynamics.Types.switches.switch_input.use_desValue
   ""
    annotation(
    Dialog(group = "switch"),
    choicesAllMatching= true,   
    Evaluate = true,
    HideResult = true
    );
  
  parameter AircraftDynamics.Types.switches.switch_input switchInput_ChRootDes
      =AircraftDynamics.Types.switches.switch_input.use_desValue
   ""
    annotation(
    Dialog(group = "switch"),
    choicesAllMatching= true,   
    Evaluate = true,
    HideResult = true
    );
  
  
  parameter Real ARdes = 5.0 "" annotation(
    Dialog(group = "Geometry"));
  parameter Real rambdaDes = 1.0 "" annotation(
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Angle sweepDes = 0.0 "" annotation(
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Area Sdes = 1.0 "" annotation(
    Dialog(group = "Geometry"));
  parameter Real effOsDes = 0.8 "" annotation(
    Dialog(group = "Characteristics"));
  parameter Modelica.SIunits.Length ChRootDes = 1.0 "" annotation(
    Dialog(group = "Geometry"));
  //********** Internal variables **********
  //***** calculated parameters *****
  Real AR(start = ARdes) "";
  Real rambda(start = rambdaDes) "";
  Modelica.SIunits.Angle sweep(start = sweepDes) "";
  Real effOs(start = effOsDes) "";
  Modelica.SIunits.Area S(start = Sdes) "";
  Modelica.SIunits.Length b(start = sqrt(ARdes * Sdes)) "";
  Modelica.SIunits.Length MAC "";
  Modelica.SIunits.Length ChRoot "";
  Modelica.SIunits.Length ChTip "";
  //---
  Real Cl_alpha;
  Real Cl0;
  Real Cdf;
  Real Cdp;
  Modelica.SIunits.Angle alpha;
  Real Mn;
  Modelica.SIunits.Angle alpha4Cl0;
  Modelica.SIunits.Angle alpha4Clmin;
  Modelica.SIunits.Angle alpha4Clmax;
  //---
  Real CL_alpha;
  Real CL0;
  Real CL;
  Real CD;
  Real CD0;
  Real CDf;
  Real CDp;
  Real CDi;
  Modelica.SIunits.Angle alphaEff;
  Modelica.SIunits.Angle alphaInd;
  Modelica.SIunits.Angle alpha4CL0;
  Modelica.SIunits.Angle alpha4CLmin;
  Modelica.SIunits.Angle alpha4CLmax;
  //---
  //********** Interfaces **********
  AircraftDynamics.Types.InfoBus signalBus1 annotation(
    Placement(visible = true, transformation(origin = {-50, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus signalBus2 annotation(
    Placement(visible = true, transformation(origin = {50, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
algorithm
//********** assignment, design parameter to variables (calculated parameters) **********
//rambda := rambdaDes;
//sweep := sweepDes;
//effOs := effOsDes;
//ChRoot := ChRootDes;
equation
  connect(alpha, signalBus1.alpha) annotation(
    Line);
  connect(Mn, signalBus1.Mn) annotation(
    Line);
  connect(Cl_alpha, signalBus1.Cl_alpha) annotation(
    Line);
  connect(Cl0, signalBus1.Cl0) annotation(
    Line);
  connect(Cdf, signalBus1.Cdf);
  connect(Cdp, signalBus1.Cdp);
  connect(alpha4Cl0, signalBus1.alpha4Cl0);
  connect(alpha4Clmin, signalBus1.alpha4Clmin);
  connect(alpha4Clmax, signalBus1.alpha4Clmax);
  
  connect(CL_alpha, signalBus2.CL_alpha);
  connect(CL0, signalBus2.CL0);
  connect(CL, signalBus2.CL) annotation(
    Line);
  connect(CD, signalBus2.CD) annotation(
    Line);
  connect(CD0,signalBus2.CD0);
  connect(CDi, signalBus2.CDi);
  connect(CDf, signalBus2.CDf);
  connect(CDp, signalBus2.CDp);
  connect(S,signalBus2.S);
//----- S -----
  if switchInput_Sdes == AircraftDynamics.Types.switches.switch_input.use_desValue then
    S = Sdes;
  elseif switchInput_Sdes == AircraftDynamics.Types.switches.switch_input.via_expConnector then
    connect(S, signalBus1.S);
  end if;
//----- AR -----
  if switchInput_ARdes == AircraftDynamics.Types.switches.switch_input.use_desValue then
    AR = ARdes;
  elseif switchInput_ARdes == AircraftDynamics.Types.switches.switch_input.via_expConnector then
    connect(AR, signalBus1.AR);
  end if;
//----- rambda -----
  if switchInput_rambdaDes == AircraftDynamics.Types.switches.switch_input.use_desValue then
    rambda = rambdaDes;
  elseif switchInput_rambdaDes == AircraftDynamics.Types.switches.switch_input.via_expConnector then
    connect(rambda, signalBus1.rambda);
  end if;
//----- sweep -----
  if switchInput_sweepDes == AircraftDynamics.Types.switches.switch_input.use_desValue then
    sweep = sweepDes;
  elseif switchInput_sweepDes == AircraftDynamics.Types.switches.switch_input.via_expConnector then
    connect(sweep, signalBus1.sweep);
  end if;
//----- effOs -----
  if switchInput_effOsDes == AircraftDynamics.Types.switches.switch_input.use_desValue then
    effOs = effOsDes;
  elseif switchInput_effOsDes == AircraftDynamics.Types.switches.switch_input.via_expConnector then
    connect(effOs, signalBus1.effOs);
  end if;
//----- ChRoot -----
  if switchInput_ChRootDes == AircraftDynamics.Types.switches.switch_input.use_desValue then
    ChRoot = ChRootDes;
  elseif switchInput_ChRootDes == AircraftDynamics.Types.switches.switch_input.via_expConnector then
    connect(ChRoot, signalBus1.ChRoot);
  end if;
//********** Geometries **********
  AR = b ^ 2 / S;
  MAC = 2 / 3 * ChRoot * ((1 + rambda + rambda ^ 2) / (1 + rambda));
  rambda = ChTip / ChRoot;
//********** Eqns describing physics **********
/*********************************************
  calclate CL
    linear model
  *********************************************/
  alpha4CL0 = alpha4Cl0;
  alpha4CLmin= alpha4Clmin;
  alpha4CLmax= alpha4Clmax;
    
  CL_alpha = Cl_alpha * cos(sweep) / (sqrt(abs(1 - Mn ^ 2 * cos(sweep) ^ 2 + (Cl_alpha * cos(sweep) / (Modelica.Constants.pi * effOs * AR)) ^ 2)) + Cl_alpha * cos(sweep) / (Modelica.Constants.pi * effOs * AR));
  
  CL0= CL_alpha*(0-alpha4CL0);
  
  if (alpha < alpha4CLmin) then
    CL = 0.0;
  elseif (alpha4CLmax < alpha) then
    CL = 0.0;
  else
    CL = CL0 + CL_alpha * alpha;
  end if;
  
  alphaInd= CL/(Modelica.Constants.pi*effOs*AR);
  alphaEff= alpha - alphaInd;
  
  /*********************************************
  calclate Cd
    linear model
  *********************************************/
  CDf=Cdf;
  CDp= Cdp;
  CD0= CDf+CDp;
  CDi= CL^2/(Modelica.Constants.pi*effOs*AR);
  CD= CD0+CDi;
  
annotation(
  defaultComponentName="airfoil2wing",
  
    Icon(graphics = {Text(origin = {0, 112}, extent = {{-100, 8}, {100, -8}}, textString = "%name")}));

end Airfoil2WingSimple00;
