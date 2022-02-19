within AircraftDynamics.RigidBodyFDM.Components.ForceMomentSources;

model SourceArbitraryForceMoment00
  //----- imports -----
  import Const = Modelica.Constants;
  import Units = Modelica.SIunits;
  /* ---------------------------------------------
          switches
    --------------------------------------------- */
  parameter Boolean use_u_Xf = false "get Xf from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_Yf = false "get Yf from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_Zf = false "get Zf from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_L = false "get L from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_M = false "get M from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_N = false "get N from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  /* ---------------------------------------------
                Parameters
    --------------------------------------------- */
  parameter Units.Force Xf_par = 0 annotation(
    Dialog(group = "Forces"));
  parameter Units.Force Yf_par = 0 annotation(
    Dialog(group = "Forces"));
  parameter Units.Force Zf_par = 0 annotation(
    Dialog(group = "Forces"));
  parameter Units.MomentOfForce L_par = 0 annotation(
    Dialog(group = "Moments"));
  parameter Units.MomentOfForce M_par = 0 annotation(
    Dialog(group = "Moments"));
  parameter Units.MomentOfForce N_par = 0 annotation(
    Dialog(group = "Moments"));
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
    outCntrSrcForceMoment.F[i] = F[i];
    outCntrSrcForceMoment.M[i] = M[i];
  end for;
//-----
/*------------------------------
      component physics
  ------------------------------*/
  F[1] = Xf_par;
  F[2] = Yf_par;
  F[3] = Zf_par;
  M[1] = L_par;
  M[2] = M_par;
  M[3] = N_par;
  annotation(
    defaultComponentName = "ForceMomentArbitrary",
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -110}, extent = {{-100, 8}, {100, -8}}, textString = "%name")}));
end SourceArbitraryForceMoment00;
