within AircraftDynamics.Interfaces;

connector VisualizerInfoOut00
  import units = Modelica.Units.SI;
  //-----
  output units.Position r[3] "position (global frame); xEast, xNorth, alt";
  output units.Velocity V[3] "u, v, w";
  output units.Angle theta[3] "attitude angles; roll, pitch, yaw";
  output units.Angle alpha "angle of attack";
  output units.Angle beta "sideslip angle";
  
  
annotation (defaultComponentName="VisInfoOut",
   Icon(coordinateSystem(
        initialScale = 0.16), graphics={Rectangle(lineColor = {95, 95, 95}, lineThickness = 0.5, extent = {{-10, 10}, {10, -10}}), Rectangle(fillColor = {144, 144, 144}, fillPattern = FillPattern.Solid, extent = {{-30, 100}, {30, -100}}), Polygon(origin = {4, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-28, 41}, {-28, -39}, {22, 1}, {-28, 41}})}),
   Diagram(coordinateSystem(initialScale = 0.16)));

end VisualizerInfoOut00;
