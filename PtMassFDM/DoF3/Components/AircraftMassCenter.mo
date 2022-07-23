within AircraftDynamics.PtMassFDM.DoF3.Components;

model AircraftMassCenter
  extends AircraftDynamics.Icons.Icon_AircraftMass3DoF;
  extends AircraftDynamics.Interfaces.PtMassFrame;
  //----- imports -----
  import Modelica.Constants;
  import AircraftDynamics.Types.switches;
  import AircraftDynamics.Functions;
  
  /********************************************************
       Declaration
  ********************************************************/
  //********** Parameters **********
  //----- switches -----
  parameter switches.switch_modeStabilityLongi switchDef_modeStabilityLongi
      =switches.switch_modeStabilityLongi.maintainAoA
   ""
    annotation(
    Dialog(group = "switch"),
    choicesAllMatching= true,   
    Evaluate = true,
    HideResult = true
    );
  
  parameter Modelica.SIunits.Mass massBase = 1.0 "" annotation(
    Dialog(group = "Characteristics"));
  //********** Initialization Parameters **********
  parameter Modelica.SIunits.Velocity Vinit=150.0 ""
    annotation(
    Dialog(tab = "Initialization", group = "Flight states"));
  
  parameter Modelica.SIunits.Angle alphaInit=3.0*Modelica.Constants.pi/180.0 ""
    annotation(
    Dialog(tab = "Initialization", group = "Flight states"));
  
  parameter Modelica.SIunits.Angle gammaInit=0.000001*Modelica.Constants.pi/180.0 ""
    annotation(
    Dialog(tab = "Initialization", group = "Flight states"));
  
  parameter Modelica.SIunits.AngularVelocity qInit=0.000001*Modelica.Constants.pi/180.0 ""
    annotation(
    Dialog(tab = "Initialization", group = "Flight states"));
  
  parameter Modelica.SIunits.Position xWorldInit=0.0 ""
    annotation(
    Dialog(tab = "Initialization", group = "Flight states"));
  
  parameter Modelica.SIunits.Position altInit=3000.0 ""
    annotation(
    Dialog(tab = "Initialization", group = "Flight states"));
  //---
  parameter Modelica.SIunits.Position yWorldInit=0.0 ""
    annotation(
    Dialog(tab = "Initialization", group = "Flight states")); 
// added, 2DoF -> 3DoF
  //********** Internal variables **********
  Modelica.SIunits.Mass massTotal(start = massBase);
  
  Modelica.SIunits.Force lift;
  Modelica.SIunits.Force drag;
  Modelica.SIunits.Force thrust;
  
  Modelica.SIunits.Force weight(start = massBase * 9.81);
  Modelica.SIunits.Length radiPerpend(start=0) "radius of centripital motion, perpendicular to aircraft center line";
  Modelica.SIunits.Position xWorld(start=xWorldInit) "x-position in world frame";
  Modelica.SIunits.Position alt(start=altInit) "altitude(y-position) in world frame";
  
  Modelica.SIunits.KineticEnergy EKinetic "";
  Modelica.SIunits.PotentialEnergy EPotential "";
  Modelica.SIunits.Energy EMechanical "";
  
  Real LqD;
  //---
  Modelica.SIunits.Length radiTurn(start=0) "radius of centripital motion, horizontal turning circle";      // added, 2DoF -> 3DoF
  Modelica.SIunits.Position yWorld(start=yWorldInit) "";      // added, 2DoF -> 3DoF
  Modelica.SIunits.Position fltDist(start=yWorldInit) "";
  // added, 2DoF -> 3DoF
  //********** Internal objects **********
  AircraftDynamics.Interfaces.VisualizerInfoOut00 VisInfoOut annotation(
    Placement(visible = true, transformation(origin = {80, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {80, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));    initial equation
  fltStates.q= qInit;
  
equation
  connect(InfoBus1.alpha, fltStates.alpha);
  connect(InfoBus1.Vflow, fltStates.V);
  connect(InfoBus1.Mn, fltStates.Mn);
//---
  connect(InfoBus1.phi, fltStates.phi);// added, 2DoF -> 3DoF
  //-----
  VisInfoOut.r[1] = fltStates.xEast;
  VisInfoOut.r[2] = fltStates.xNorth;
  VisInfoOut.r[3] = fltStates.alt;
  VisInfoOut.theta[1] = fltStates.phi;
  VisInfoOut.theta[2] = fltStates.theta;
  VisInfoOut.theta[3] = fltStates.psi;
  VisInfoOut.alpha= fltStates.alpha;
  VisInfoOut.beta= fltStates.beta;
  VisInfoOut.V[1]= fltStates.u;
  VisInfoOut.V[2]= fltStates.v;
  VisInfoOut.V[3]= fltStates.w;
//-----
  
  
  
  /*------------------------------
  specify witch angle is fixed by command signal from outside of component
  ------------------------------*/
  if switchDef_modeStabilityLongi == switches.switch_modeStabilityLongi.maintainAoA then
    connect(fltStates.alpha, InfoBus1.alphaCmd);
  elseif switchDef_modeStabilityLongi == switches.switch_modeStabilityLongi.maintainFltPath then
    connect(fltStates.gamma, InfoBus1.gammaCmd);
  elseif switchDef_modeStabilityLongi == switches.switch_modeStabilityLongi.maintainPitch then
    connect(fltStates.theta, InfoBus1.thetaCmd);
  end if;
  
  if (0 < nIn_mass) then
    massTotal = sum_u_mass + massBase;
  else
    massTotal = massBase;
  end if;
  
  weight = world.g * massTotal;
  
  /*------------------------------
  eqns of kinematics
  ------------------------------*/
  fltStates.theta = fltStates.gamma + fltStates.alpha;
// relation among angles
  der(xWorld) = fltStates.V * cos(fltStates.gamma) * sin(fltStates.psi);
// edited, 2DoF -> 3DoF
  der(alt) = fltStates.V * sin(fltStates.gamma);
  fltStates.u= fltStates.V*cos(fltStates.alpha);
  fltStates.w= fltStates.V*sin(fltStates.alpha);
//---
  der(yWorld) = fltStates.V * cos(fltStates.gamma) * cos(fltStates.psi);
// added, 2DoF -> 3DoF
  der(fltDist) ^ 2 = der(xWorld) ^ 2 + der(yWorld) ^ 2;
// added, 2DoF -> 3DoF
  fltStates.XG = xWorld;
  fltStates.YG= yWorld;
  fltStates.ZG= -1.0*alt;
  (fltStates.xEast, fltStates.xNorth, fltStates.alt)= AircraftDynamics.Functions.GlobalFrame2earthConvention(XG= fltStates.XG, YG= fltStates.YG, ZG= fltStates.ZG);
  
  fltStates.XGdot= der(fltStates.XG);
  fltStates.YGdot= der(fltStates.YG);
  fltStates.ZGdot= der(fltStates.ZG);
  
  
  /*------------------------------
  eqns of dynamics
  ------------------------------*/
  thrust= sum_u_FxForward;
  fltStates.Ftan= thrust*cos(fltStates.alpha) - drag - weight*sin(fltStates.gamma);
  fltStates.Fcentr= (thrust*sin(fltStates.alpha) + lift) *cos(fltStates.phi) - weight*cos(fltStates.gamma);
// edited, 2DoF -> 3DoF
  fltStates.X = sum_u_FxForward - sum_u_FxBackward - weight * sin(fltStates.theta);
  fltStates.Z= -1.0*(sum_u_Fz - weight*cos(fltStates.theta));
  
  fltStates.X= ( thrust + lift*sin(fltStates.alpha) - drag*cos(fltStates.alpha) - weight*sin(fltStates.theta) );
  fltStates.Z= -1.0*( lift*cos(fltStates.alpha) + drag*sin(fltStates.alpha) - weight*cos(fltStates.theta) );
  
  massTotal*(der(fltStates.V))= fltStates.Ftan;
  massTotal*(fltStates.V*der(fltStates.gamma))= fltStates.Fcentr;
  
  der(fltStates.gamma)=fltStates.q;
  
  fltStates.V= radiPerpend*der(fltStates.gamma);
  
  LqD= lift/drag;
  
  EKinetic= (1.0/2.0)*massTotal*fltStates.V^(2.0);
  EPotential= massTotal*world.g*alt;
  EMechanical= EKinetic + EPotential;
//---
  fltStates.Fturn = (thrust * sin(fltStates.alpha) + lift) * sin(fltStates.phi);
// added, 2DoF -> 3DoF
  fltStates.Y = fltStates.Fturn;
// added, 2DoF -> 3DoF
  massTotal * (fltStates.V * der(fltStates.psi)) = fltStates.Fturn;
// added, 2DoF -> 3DoF
  der(fltStates.phi) = fltStates.p;
// added, 2DoF -> 3DoF
  der(fltStates.psi) = fltStates.r;
// added, 2DoF -> 3DoF
  fltStates.V = radiTurn * der(fltStates.psi);
// added, 2DoF -> 3DoF
/*------------------------------
  convert angles for display
  ------------------------------*/
  [fltAng4disp.alpha, fltAng4disp.theta, fltAng4disp.gamma, fltAng4disp.phi, fltAng4disp.psi] = AircraftDynamics.Functions.calcAngles4display([fltStates.alpha, fltStates.theta, fltStates.gamma, fltStates.phi, fltStates.psi]);
// edited, 2DoF -> 3DoF
/*------------------------------
  Unused flight states
  ------------------------------*/
//--- velocity ---
  fltStates.v = 0.0;
//--- force ---
//fltStates.Y = 0.0;  //removed, 2DoF -> 3DoF
//--- angle ---
  fltStates.beta = 0.0;
//fltStates.phi=0.0;  //removed, 2DoF -> 3DoF
//fltStates.psi=0.0;  //removed, 2DoF -> 3DoF
//--
//fltAng4disp.psi = 0.0;  //removed, 2DoF -> 3DoF
//fltAng4disp.phi=0.0;  //removed, 2DoF -> 3DoF
  fltAng4disp.beta = 0.0;
//--- angular velocity ---
//fltStates.p = 0.0;  //removed, 2DoF -> 3DoF
//fltStates.r=0.0;  //removed, 2DoF -> 3DoF
//--- moment ---
  fltStates.L = 0.0;
  fltStates.M= 0.0;
  fltStates.N= 0.0;
  
  
  annotation(
    Icon(graphics = {Text(origin = {4, -74}, extent = {{-104, 8}, {96, -6}}, textString = "%name"), Text(origin = {3, 87}, extent = {{-9, 5}, {3, -5}}, textString = "Fzu"), Text(origin = {-91, -15}, extent = {{-9, 5}, {5, -3}}, textString = "Fxf"), Text(origin = {95, -13}, extent = {{-7, 5}, {5, -5}}, textString = "Fxb"), Text(origin = {-1, -85}, extent = {{-7, 1}, {9, -7}}, textString = "m")}, coordinateSystem(initialScale = 0.1)),
    Diagram,
    __OpenModelica_commandLineOptions = "",
  experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-6, Interval = 0.002),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));

end AircraftMassCenter;
