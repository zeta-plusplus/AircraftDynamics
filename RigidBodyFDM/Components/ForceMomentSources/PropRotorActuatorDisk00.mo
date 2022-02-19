within AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources;

model PropRotorActuatorDisk00
  //----- imports -----
  import Const = Modelica.Constants;
  import Units = Modelica.SIunits;
  import Math= Modelica.Math;
  /* ---------------------------------------------
          switches
    --------------------------------------------- */
  /* ---------------------------------------------
                Parameters
    --------------------------------------------- */
  parameter Real vectThrustDir_par[3]={1,0,0} "vector of thrust direction wrt aircraft body";
  parameter Units.Length vectPosIF_par[3]={0,0,0} "position vector of propeller interface, wrt datum of aircraft";
  parameter Real CQqCT_par = 0.006/0.05 "torque/thrust";
  parameter Real diam_par= 0.1 "";
  parameter Boolean thrustVectorEQrotationalVector=true "if true, vector direction of rotation and torque are same as thrust vector";
  
  
  
  /* ---------------------------------------------
                Internal variables
    --------------------------------------------- */
  Real CQqCT;
  Real QqT;
  Real vectThrustDir[3];
  Units.Position vectPosIF[3] "position vector of propeller interface, wrt datum of aircraft";
  Units.Length vectArm[3] "vector of moment arms";
  Units.Force thrust "";
  Units.Force F[3] "force vector, input to aircraft body";
  Units.Torque trq "torque into prop component to drive prop";
  Units.Torque countTrq "counter-torque outof prop component";
  Units.Torque vectCountTrq[3] "";
  Units.MomentOfForce MbyT[3] "moment due to thrust and arm length";
  Units.MomentOfForce M[3] "moment vector, input to aircraft body";
  Units.Length diam "";
  
  
  /* ---------------------------------------------
                  Internal objects
    --------------------------------------------- */
  /* ---------------------------------------------
                    Interfaces
    --------------------------------------------- */
  AircraftDynamics.Interfaces.OutCntrSrcForceMoment6DoF00 outCntrSrcForceMoment annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_thrust annotation(
    Placement(visible = true, transformation(origin = {50, 40}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {60, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));

//**********************************************************************
equation
/*------------------------------
      interfacing
  ------------------------------*/
  diam=diam_par;
  CQqCT=CQqCT_par;
  thrust=u_thrust;
//-----
  for i in 1:3 loop
    vectThrustDir[i] = vectThrustDir_par[i];
    vectPosIF[i] = vectPosIF_par[i];
//-----
    outCntrSrcForceMoment.F[i] = F[i];
    outCntrSrcForceMoment.M[i] = M[i];
  end for;
  
  
/*------------------------------
      component physics
  ------------------------------*/
  for i in 1:3 loop
    vectArm[i]= vectPosIF[i]-outCntrSrcForceMoment.rCG[i];
    F[i]= thrust *vectThrustDir[i]/Math.Vectors.length(vectThrustDir);
  end for;
//-----
  MbyT = cross(vectArm, F);
  QqT= CQqCT*diam;
  trq= QqT*thrust;
  countTrq= -1*trq;
  
  if(thrustVectorEQrotationalVector==true)then
    for i in 1:3 loop
      vectCountTrq[i]= -1* trq *vectThrustDir[i]/Math.Vectors.length(vectThrustDir);
    end for;
  else
    for i in 1:3 loop
      vectCountTrq[i]= trq *vectThrustDir[i]/Math.Vectors.length(vectThrustDir);
    end for;
  end if;
  
  
  
  for i in 1:3 loop
    M[i]= vectCountTrq[i]+MbyT[i];
  end for;
  
  annotation(
    defaultComponentName = "Rotor",
    Icon(graphics = {Text(origin = {0, -110}, extent = {{-100, 8}, {100, -8}}, textString = "%name"), Ellipse(origin = {-53, 0}, extent = {{-47, 100}, {43, -100}}), Rectangle(origin = {-63, 8}, fillPattern = FillPattern.Solid, extent = {{-1, 0}, {163, -16}}), Polygon(origin = {-53, 44}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-12, -44}, {-8, 50}, {2, 56}, {10, -44}, {-12, -44}}), Polygon(origin = {-77, 0}, fillPattern = FillPattern.Solid, points = {{-18, 0}, {10, 14}, {10, -14}, {-18, 0}}), Polygon(origin = {-57, -44}, rotation = 180, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-12, -44}, {-8, 50}, {2, 56}, {8, -44}, {-12, -44}}), Rectangle(origin = {-58, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 13}, {15, -15}})}));
end PropRotorActuatorDisk00;
