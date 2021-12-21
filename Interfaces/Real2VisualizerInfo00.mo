within AircraftDynamics.Interfaces;

model Real2VisualizerInfo00
  /* ---------------------------------------------
                switches
    --------------------------------------------- */
  parameter Boolean use_u_xEast = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_xNorth = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_alt = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_phi = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_theta = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_psi = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_alpha = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_beta = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  /* ---------------------------------------------
                  Interface
    --------------------------------------------- */
  AircraftDynamics.Interfaces.VisualizerInfoOut00 VisInfoOut annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {20, -3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_xEast if use_u_xEast annotation(
    Placement(visible = true, transformation(origin = {-120, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-30, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_xNorth if use_u_xNorth annotation(
    Placement(visible = true, transformation(origin = {-120, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-30, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_alt if use_u_alt annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-30, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_phi if use_u_phi annotation(
    Placement(visible = true, transformation(origin = {-120, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_theta if use_u_theta annotation(
    Placement(visible = true, transformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-30, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_psi if use_u_psi annotation(
    Placement(visible = true, transformation(origin = {-120, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-30, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_alpha if use_u_alpha annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-30, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_beta if use_u_beta annotation(
    Placement(visible = true, transformation(origin = {-120, -110}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-30, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
//**********************************************************************
equation
  if use_u_xEast == true then
    VisInfoOut.r[1] = u_xEast;
  else
    VisInfoOut.r[1] = 0.0;
  end if;
//-----
  if use_u_xNorth == true then
    VisInfoOut.r[2] = u_xNorth;
  else
    VisInfoOut.r[2] = 0.0;
  end if;
//-----
  if use_u_alt == true then
    VisInfoOut.r[3] = u_alt;
  else
    VisInfoOut.r[3] = 0.0;
  end if;
//-----
//----------
  if use_u_phi == true then
    VisInfoOut.theta[1] = u_phi;
  else
    VisInfoOut.theta[1] = 0.0;
  end if;
//-----
  if use_u_theta == true then
    VisInfoOut.theta[2] = u_theta;
  else
    VisInfoOut.theta[2] = 0.0;
  end if;
//-----
  if use_u_psi == true then
    VisInfoOut.theta[3] = u_psi;
  else
    VisInfoOut.theta[3] = 0.0;
  end if;
//-----
  if use_u_alpha == true then
    VisInfoOut.alpha = u_alpha;
  else
    VisInfoOut.alpha = 0.0;
  end if;
//-----
  if use_u_beta == true then
    VisInfoOut.beta = u_beta;
  else
    VisInfoOut.beta = 0.0;
  end if;
//-----


  annotation(
    defaultComponentName = "Real2VisInfo",
    Icon(coordinateSystem(initialScale = 0.16, extent = {{-40, -160}, {30, 160}}), graphics = {Rectangle(lineColor = {95, 95, 95}, lineThickness = 0.5, extent = {{-10, 10}, {10, -10}}), Rectangle(fillColor = {144, 144, 144}, fillPattern = FillPattern.Solid, extent = {{-20, 160}, {20, -160}}), Text(origin = {0, -171}, extent = {{-40, 7}, {30, -9}}, textString = "%name")}),
    __OpenModelica_commandLineOptions = "");
end Real2VisualizerInfo00;
