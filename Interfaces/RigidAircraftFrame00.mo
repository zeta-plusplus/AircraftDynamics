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
  
  
  
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  Units.Force sum_u_F[3];
  Units.Moment sum_u_M[3];
  
  AircraftDynamics.Records.FlightStates fltStates;
  AircraftDynamics.Records.angles4display fltAng4disp;
  
  
  /* ---------------------------------------------
              Interfaces
  --------------------------------------------- */
  AircraftDynamics.Interfaces.InCntrSrcForceMoment6DoF00 inCntrSrcForceMoment[nSrcForceMoment] annotation(
    Placement(visible = true, transformation(origin = {-100, -2}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-100, -2}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  
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
  inCntrSrcForceMoment.r[1] = fltStates.XG;
  inCntrSrcForceMoment.r[2] = fltStates.YG;
  inCntrSrcForceMoment.r[3] = fltStates.alt;
  inCntrSrcForceMoment.theta[1] = fltStates.phi;
  inCntrSrcForceMoment.theta[2] = fltStates.theta;
  inCntrSrcForceMoment.theta[3] = fltStates.psi;
  inCntrSrcForceMoment.alpha = fltStates.alpha;
  inCntrSrcForceMoment.beta= fltStates.beta;
  
  //----------
  (fltStates.xEast, fltStates.xNorth, fltStates.alt) = AircraftDynamics.Functions.GlobalFrame2earthConvention(XG = fltStates.XG, YG = fltStates.YG, ZG = fltStates.ZG);
  
  /*------------------------------
    convert angles for display (0-360 deg)
  ------------------------------*/
  [fltAng4disp.alpha, fltAng4disp.beta, fltAng4disp.theta, fltAng4disp.gamma, fltAng4disp.phi, fltAng4disp.psi] = AircraftDynamics.Functions.calcAngles4display([fltStates.alpha, fltStates.beta, fltStates.theta, fltStates.gamma, fltStates.phi, fltStates.psi]);
  
  //----------
  
end RigidAircraftFrame00;
