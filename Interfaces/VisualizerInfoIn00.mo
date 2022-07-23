within AircraftDynamics.Interfaces;

connector VisualizerInfoIn00
  import Units= Modelica.SIunits;
  //-----
  input Units.Position r[3] "position (global frame); xEast, xNorth, alt";
  input Units.Velocity V[3] "u, v, w";
  input Units.Angle theta[3] "attitude angles; roll, pitch, yaw";
  input Units.Angle alpha "angle of attack";
  input Units.Angle beta "sideslip angle";
  
annotation (defaultComponentName="VisInfoIn",
   Icon(coordinateSystem(
        initialScale = 0.16), graphics={Rectangle(lineColor = {95, 95, 95}, lineThickness = 0.5, extent = {{-10, 10}, {10, -10}}), Rectangle(fillColor = {237, 237, 237}, fillPattern = FillPattern.Solid, extent = {{-30, 100}, {30, -100}}), Polygon(origin = {-4, 0}, fillPattern = FillPattern.Solid, points = {{-21, 40}, {-21, -40}, {31, 0}, {-21, 40}})}),
   Diagram(coordinateSystem(initialScale = 0.16)));

end VisualizerInfoIn00;
