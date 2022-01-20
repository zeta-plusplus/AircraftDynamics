within AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources;

model SourceConstantGravity
  //----- imports -----
  import Const = Modelica.Constants;
  import Units = Modelica.SIunits;
  
  
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  Units.Force Fg[3] "gravity along body frame";
  Units.Force FgG[3] "gravity along Global frame";
  Units.Mass mass;
  Units.Angle phi;
  Units.Angle theta;
  Units.Angle psi;
  Units.Acceleration g;
  
  
  /* ---------------------------------------------
              Internal objects
  --------------------------------------------- */
  inner outer AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  
  
  
  /* ---------------------------------------------
                Interfaces
  --------------------------------------------- */
  AircraftDynamics.Interfaces.OutCntrSrcForceMoment6DoF00 outCntrSrcForceMoment annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {0, 99}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  
//**********************************************************************
protected  
  Units.Force FgG_rot[3] "" annotation(
    fixed = false,
    HideResult = false);
  
  
//**********************************************************************
equation
  /*------------------------------
      interfacing
  ------------------------------*/
  phi= outCntrSrcForceMoment.theta[1];
  theta= outCntrSrcForceMoment.theta[2];
  psi= outCntrSrcForceMoment.theta[3];
  mass= outCntrSrcForceMoment.m;
  g= environmentAircraftDynSim.gravity;
  //-----
  for i in 1:3 loop
    outCntrSrcForceMoment.F[i]= Fg[i];
    outCntrSrcForceMoment.M[i]= 0;
  end for;
  
  
  /*------------------------------
      component physics
  ------------------------------*/
  FgG[1]= 0;
  FgG[2]= 0;
  FgG[3]= mass*g;
  
  FgG_rot=AircraftDynamics.Functions.rotateVector3D00(u=FgG, theta={-psi, -theta, -phi});
  Fg[1]=FgG_rot[1];
  Fg[2]=FgG_rot[2];
  Fg[3]=FgG_rot[3];
  
  /*
  Fg[1]= -1*mass*g*sin(theta);
  Fg[2]= mass*g*cos(theta)*sin(phi);
  Fg[3]= mass*g*cos(theta)*cos(phi);
  */
  
annotation(
    defaultComponentName = "SrcGravity",
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -110}, extent = {{-100, 8}, {100, -8}}, textString = "%name")}));
  
end SourceConstantGravity;
