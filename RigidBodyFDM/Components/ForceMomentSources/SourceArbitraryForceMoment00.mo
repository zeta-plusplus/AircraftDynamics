within AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources;

model SourceArbitraryForceMoment00
  //----- imports -----
  import Const = Modelica.Constants;
  import Units = Modelica.SIunits;
  
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  parameter Units.Force Xf_par=0;
  parameter Units.Force Yf_par=0;
  parameter Units.Force Zf_par=0;
  parameter Units.MomentOfForce L_par=0;
  parameter Units.MomentOfForce M_par=0;
  parameter Units.MomentOfForce N_par=0;
  
  
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  Units.Force F[3] "";
  Units.MomentOfForce M[3] "";
  
  /* ---------------------------------------------
                Internal objects
    --------------------------------------------- */
  /* ---------------------------------------------
                  Interfaces
    --------------------------------------------- */
  AircraftDynamics.Interfaces.OutCntrSrcForceMoment6DoF00 outCntrSrcForceMoment annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  
//**********************************************************************
protected  
  
//**********************************************************************
equation
  /*------------------------------
      interfacing
  ------------------------------*/
  //-----
  for i in 1:3 loop
    outCntrSrcForceMoment.F[i]= F[i];
    outCntrSrcForceMoment.M[i]= M[i];
  end for;
  //-----
  
  /*------------------------------
      component physics
  ------------------------------*/
  F[1]=Xf_par;
  F[2]=Yf_par;
  F[3]=Zf_par;
  M[1]=L_par;
  M[2]=M_par;
  M[3]=N_par;
  
  
annotation(
    defaultComponentName = "ForceMomentArbitrary",
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -110}, extent = {{-100, 8}, {100, -8}}, textString = "%name")}));
  
  
end SourceArbitraryForceMoment00;
