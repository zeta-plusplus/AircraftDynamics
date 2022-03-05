within AircraftDynamics.Sensors;

model PitchAngle
  extends Modelica.Icons.RotationalSensor;
  
  /********************************************************
       Declaration
  ********************************************************/
  /* ---------------------------------------------
            Interface
  --------------------------------------------- */
  output Modelica.Blocks.Interfaces.RealOutput y_theta(final quantity = "Angle", final unit="rad", displayUnit="deg") "Pitch Angle" annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  AircraftDynamics.Interfaces.FlightStatesBus FltStatesBus1 annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  //******************************************************************************************
equation
/* ---------------------------------------------
              Interface
  --------------------------------------------- */
  connect(FltStatesBus1.theta, y_theta);
  
  
annotation (defaultComponentName="sensorTheta",
  Icon(coordinateSystem(preserveAspectRatio=false, initialScale = 0.1), graphics={
        Line(origin = {-97.3176, 69.6706},points={{0,-70},{28,-70}}, thickness = 1.5),
Text(origin = {50, 0},lineColor = {0, 0, 255}, extent = {{-150, 80}, {50, 100}}, textString = "%name"), Text(origin = {-785, -25}, extent = {{885, -49}, {685, -69}}, textString = "theta"), Line(points = {{70, 0}, {100, 0}}, thickness = 1.5)}),
  Documentation(info="<html>
<p>

</p>
</html>"));
  
  
end PitchAngle;
