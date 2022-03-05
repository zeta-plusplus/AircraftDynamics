within AircraftDynamics.Sensors;

model HeadingAngle
  extends Modelica.Icons.RotationalSensor;
  
  /********************************************************
       Declaration
  ********************************************************/
  /* ---------------------------------------------
            Interface
  --------------------------------------------- */
  output Modelica.Blocks.Interfaces.RealOutput y_psi(final quantity = "Angle", final unit="rad", displayUnit="deg") "Heading Angle" annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  AircraftDynamics.Interfaces.FlightStatesBus FltStatesBus1 annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  
  
//******************************************************************************************
equation
/* ---------------------------------------------
              Interface
  --------------------------------------------- */
  connect(FltStatesBus1.psi, y_psi);
  
  
annotation (defaultComponentName="sensorPsi",
  Icon(coordinateSystem(preserveAspectRatio=false, initialScale = 0.1), graphics={
        Line(origin = {-99.8118, 70.1882},points={{0,-70},{30,-70}}, thickness = 1.5),
Text(origin = {50, 0},lineColor = {0, 0, 255}, extent = {{-150, 80}, {50, 100}}, textString = "%name"), Text(origin = {-78, 34},extent = {{186, -44}, {144, -62}}, textString = "psi"), Line(points = {{70, 0}, {100, 0}}, thickness = 1.5)}),
  Documentation(info="<html>
<p>

</p>
</html>"));
  
  
end HeadingAngle;
