within AircraftDynamics.Sensors;

model FlightPathAngle
  extends Modelica.Icons.RotationalSensor;
  
  /********************************************************
       Declaration
  ********************************************************/
  /* ---------------------------------------------
            Interface
  --------------------------------------------- */
  output Modelica.Blocks.Interfaces.RealOutput y_gamma(final quantity = "Angle", final unit="rad", displayUnit="deg") "Flight Path Angle" annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  AircraftDynamics.Interfaces.FlightStatesBus FltStatesBus1 annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  
  
//******************************************************************************************
equation
/* ---------------------------------------------
              Interface
  --------------------------------------------- */
  connect(FltStatesBus1.gamma, y_gamma);
  
  
annotation (defaultComponentName="sensorGamma",
  Icon(coordinateSystem(preserveAspectRatio=false, initialScale = 0.1), graphics={
        Line(origin = {-99.3412, 70.2235},points={{0,-70},{30,-70}}, thickness = 1.5),
Text(origin = {50, 0},lineColor = {0, 0, 255}, extent = {{-150, 80}, {50, 100}}, textString = "%name"), Text(origin = {-786, -31}, extent = {{886, -49}, {686, -69}}, textString = "gamma"), Line(points = {{70, 0}, {100, 0}}, thickness = 1.5)}),
  Documentation(info="<html>
<p>

</p>
</html>"));
  
  
end FlightPathAngle;
