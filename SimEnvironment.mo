within AircraftDynamics;

model SimEnvironment
  extends AircraftDynamics.Icons.Icon_SimEnvironment;
  //
  import units = Modelica.Units.SI;
  
  /* ---------------------------------------------
      parameters
  --------------------------------------------- */
  parameter units.Time timeRemoveDesConstraint=0.1
    "time to keep constraint by design point"
    annotation(
    Dialog(group = "Simulation setting"));
  
  
  parameter units.Temperature Tstd= PropulsionSystem.Constants.constants_earth.Tstd
    ""
    annotation(
    Dialog(group = "constants of standards"));
  
  parameter units.Pressure pStd= PropulsionSystem.Constants.constants_earth.pStd
    ""
    annotation(
    Dialog(group = "constants of standards"));
  
  parameter units.Acceleration gravity= PropulsionSystem.Constants.constants_earth.gravity
    ""
    annotation(
    Dialog(group = "constants of standards"));
  //----- gound -----
  parameter units.Length alt_ground= PropulsionSystem.Constants.constants_earth.alt_ground
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
  
  parameter units.Temperature T_ground= PropulsionSystem.Constants.constants_earth.T_ground
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
  
  parameter units.AbsolutePressure p_ground= PropulsionSystem.Constants.constants_earth.p_ground
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
  //----- upper bound of troposhere -----
  parameter units.Length alt_UpBdTropos= PropulsionSystem.Constants.constants_earth.alt_UpBdTropos
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
    
  parameter units.Temperature T_UpBdTropos= PropulsionSystem.Constants.constants_earth.T_UpBdTropos
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
    
  parameter units.AbsolutePressure p_UpBdTropos= PropulsionSystem.Constants.constants_earth.p_UpBdTropos
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
    
  parameter Real LapseR1= PropulsionSystem.Constants.constants_earth.LapseR1
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
    //----- upper bound of stratosphere -----
  parameter units.Length alt_UpBdStratos= PropulsionSystem.Constants.constants_earth.alt_UpBdStratos
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
  
  parameter units.Temperature T_UpBdStratos= PropulsionSystem.Constants.constants_earth.T_UpBdStratos
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
    
  parameter units.AbsolutePressure p_UpBdStratos= PropulsionSystem.Constants.constants_earth.p_UpBdStratos
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
    
  parameter Real LapseR2= PropulsionSystem.Constants.constants_earth.LapseR2
    ""
    annotation(
    Dialog(group = "constants for atmosphere model"));
  
  
  output Modelica.Blocks.Interfaces.RealOutput y_pStd(final quantity="Pressrue") annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_Tstd(final quantity="Temperature") annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.RealOutput y_g(final quantity="Acceleration") annotation(
    Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
//********************************************************************************
equation
  /* ---------------------------------------------
    Connections, interface <-> internal variables
  --------------------------------------------- */
  y_pStd= pStd;
  y_Tstd= Tstd;
  y_g= gravity;
  
  
  /********************************************************
    Graphics
  ********************************************************/
  annotation (
    defaultComponentName="environmentAircraftDynSim",
    defaultComponentPrefixes="inner",
    missingInnerMessage="
Your model is using an outer \"environment\" component but
an inner \"environment\" component is not defined.
For simulation drag Modelica.Fluid.System into your model
to specify system properties.",
    Icon(coordinateSystem(preserveAspectRatio=false, initialScale = 0.1), graphics={Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
    Documentation(info="<html>
            </html>"));
  
  
  
end SimEnvironment;
