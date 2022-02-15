within AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources;

model ArbitraryDamper00
  //----- imports -----
  import Const = Modelica.Constants;
  import Units = Modelica.SIunits;
  
  
  /* ---------------------------------------------
                Parameters
  --------------------------------------------- */
  parameter Units.TranslationalDampingConstant dampX_par=100
    "Damping constant, along body x-axis";
  parameter Units.TranslationalDampingConstant dampY_par=100
    "Damping constant, along body y-axis";
  parameter Units.TranslationalDampingConstant dampZ_par=100
    "Damping constant, along body z-axis";
  
  parameter Units.RotationalDampingConstant dampL_par=100
    "Damping constant, in roll rotation";
  parameter Units.RotationalDampingConstant dampM_par=100
    "Damping constant, in pitch rotation";
  parameter Units.RotationalDampingConstant dampN_par=100
    "Damping constant, in yaw rotation";
  
  
  
  /* ---------------------------------------------
                Internal variables
    --------------------------------------------- */
  Units.Force F[3] "" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  Units.MomentOfForce M[3] "" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  
  Units.TranslationalDampingConstant dampX(start=dampX_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  Units.TranslationalDampingConstant dampY(start=dampY_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  Units.TranslationalDampingConstant dampZ(start=dampZ_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  
  Units.RotationalDampingConstant dampL(start=dampL_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  Units.RotationalDampingConstant dampM(start=dampM_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  Units.RotationalDampingConstant dampN(start=dampN_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  
  Units.Power lossPowerTran[3] "power loss, each translational direction" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  Units.Power lossPowerRot[3] "power loss, each rotational direction" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  Units.Power sumLossPowerTran "power loss, sum, translational" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  Units.Power sumLossPowerRot "power loss, sum, rotational" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  Units.Power sumLossPower "power loss, sum" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = false, showStartAttribute = true));
  /**/
  
  
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
  /* ---------------------------------------------
                Parameters
    --------------------------------------------- */
  parameter Real k_u_FM[3] = ones(3) "sum coefficients, all 1";
  
  
  
  //**********************************************************************
equation
/*------------------------------
      interfacing
  ------------------------------*/
//-----
  for i in 1:3 loop
    outCntrSrcForceMoment.F[i] = F[i];
    outCntrSrcForceMoment.M[i] = M[i];
    /**/
    
  end for;
//-----
  dampX=dampX_par;
  dampY=dampY_par;
  dampZ=dampZ_par;
  
  dampL=dampL_par;
  dampM=dampM_par;
  dampN=dampN_par;
  
  
/*------------------------------
      component physics
  ------------------------------*/
  F[1] = -dampX*outCntrSrcForceMoment.v[1];
  F[2] = -dampY*outCntrSrcForceMoment.v[2];
  F[3] = -dampZ*outCntrSrcForceMoment.v[3];
  
  M[1] = -dampL*outCntrSrcForceMoment.omega[1];
  M[2] = -dampM*outCntrSrcForceMoment.omega[2];
  M[3] = -dampN*outCntrSrcForceMoment.omega[3];
  
  
  for i in 1:3 loop
    lossPowerTran[i]=F[i]*outCntrSrcForceMoment.v[i];
    lossPowerRot[i]=M[i]*outCntrSrcForceMoment.omega[i];
  end for;
  /**/
  sumLossPowerTran= k_u_FM*lossPowerTran;
  sumLossPowerRot= k_u_FM*lossPowerTran;
  sumLossPower= sumLossPowerTran+sumLossPowerRot;
  
  annotation(
    defaultComponentName = "ArbitraryDamper",
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -110}, extent = {{-100, 8}, {100, -8}}, textString = "%name")}));
  
end ArbitraryDamper00;
