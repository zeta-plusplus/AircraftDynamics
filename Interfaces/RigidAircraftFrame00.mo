within AircraftDynamics.Interfaces;

partial model RigidAircraftFrame00
  //----- imports -----
  import Const = Modelica.Constants;
  import Units = Modelica.SIunits;
  /********************************************************
         Declaration
  ********************************************************/
  /* ---------------------------------------------
              Parameters
  --------------------------------------------- */
  parameter Integer nSrcForceMoment = 1 "Number of sources of forces&moments" annotation(
    Dialog(group = "Connector setting"));
  
  //---------- Aircraft Properties ----------
  parameter Units.Mass mTot_par= 1202.01978 "total mass of aircraft body";
  parameter Units.MomentOfInertia Ixx_par=1285.3154166;
  parameter Units.MomentOfInertia Iyy_par=1824.9309607;
  parameter Units.MomentOfInertia Izz_par=2666.89390765;
  parameter Units.MomentOfInertia Ixy_par=0.0;
  parameter Units.MomentOfInertia Ixz_par=0.0;
  parameter Units.MomentOfInertia Iyx_par=0.0;
  parameter Units.MomentOfInertia Iyz_par=0.0;
  parameter Units.MomentOfInertia Izx_par=0.0;
  parameter Units.MomentOfInertia Izy_par=0.0;
  //-----
  
  
  
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  Units.Force sum_u_F[3];
  Units.Moment sum_u_M[3];
  
  AircraftDynamics.Records.FlightStates fltStates;
  AircraftDynamics.Records.angles4display fltAng4disp;
  
  //---------- Aircraft Properties ----------
  Units.Mass mTot "total mass of aircraft body";
  Units.MomentOfInertia Ixx;
  Units.MomentOfInertia Iyy;
  Units.MomentOfInertia Izz;
  Units.MomentOfInertia Ixy;
  Units.MomentOfInertia Ixz;
  Units.MomentOfInertia Iyx;
  Units.MomentOfInertia Iyz;
  Units.MomentOfInertia Izx;
  Units.MomentOfInertia Izy;
  //-----
  
  
  
  /* ---------------------------------------------
              Interfaces
  --------------------------------------------- */
  AircraftDynamics.Interfaces.InCntrSrcForceMoment6DoF00 inCntrSrcForceMoment[nSrcForceMoment] annotation(
    Placement(visible = true, transformation(origin = {-100, -2}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-100, -2}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  AircraftDynamics.Interfaces.VisualizerInfoOut00 visInfoOut annotation(
    Placement(visible = true, transformation(origin = {80, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {80, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  AircraftDynamics.Interfaces.FlightStatesBus fltStatesBus annotation(
    Placement(visible = true, transformation(origin = {100, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

//**********************************************************************
protected
  /* ---------------------------------------------
              Parameters
  --------------------------------------------- */
  parameter Real k_u_FM[nSrcForceMoment] = ones(nSrcForceMoment) "sum coefficients, all 1";
  
//**********************************************************************
equation
//--
  for i in 1:3 loop
    sum_u_F[i] = k_u_FM * inCntrSrcForceMoment.F[i];
    sum_u_M[i] = k_u_FM * inCntrSrcForceMoment.M[i];
  end for;
  //-----
  fltStates.X= sum_u_F[1];
  fltStates.Y= sum_u_F[2];
  fltStates.Z= sum_u_F[3];
  fltStates.L= sum_u_M[1];
  fltStates.M= sum_u_M[2];
  fltStates.N= sum_u_M[3];
  //-----
  inCntrSrcForceMoment.r[1] = fltStates.XG;
  inCntrSrcForceMoment.r[2] = fltStates.YG;
  inCntrSrcForceMoment.r[3] = fltStates.alt;
  inCntrSrcForceMoment.theta[1] = fltStates.phi;
  inCntrSrcForceMoment.theta[2] = fltStates.theta;
  inCntrSrcForceMoment.theta[3] = fltStates.psi;
  inCntrSrcForceMoment.alpha = fltStates.alpha;
  inCntrSrcForceMoment.beta= fltStates.beta;
  inCntrSrcForceMoment.omega[1]= fltStates.p;
  inCntrSrcForceMoment.omega[2]= fltStates.q;
  inCntrSrcForceMoment.omega[3]= fltStates.r;
  inCntrSrcForceMoment.v[1]= fltStates.u;
  inCntrSrcForceMoment.v[2]= fltStates.v;
  inCntrSrcForceMoment.v[3]= fltStates.w;
  //-----
  
  
  //----------
  (fltStates.xEast, fltStates.xNorth, fltStates.alt) = AircraftDynamics.Functions.GlobalFrame2earthConvention(XG = fltStates.XG, YG = fltStates.YG, ZG = fltStates.ZG);
  
  /*------------------------------
    convert angles for display (0-360 deg)
  ------------------------------*/
  [fltAng4disp.alpha, fltAng4disp.beta, fltAng4disp.theta, fltAng4disp.gamma, fltAng4disp.phi, fltAng4disp.psi] = AircraftDynamics.Functions.calcAngles4display([fltStates.alpha, fltStates.beta, fltStates.theta, fltStates.gamma, fltStates.phi, fltStates.psi]);
  
  //----------
  
annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end RigidAircraftFrame00;
