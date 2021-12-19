within AircraftDynamics.Interfaces;

connector VisualizerInfoOut00
  import Units= Modelica.SIunits;
  //-----
  output Units.Position r[3] "position (global frame); xEast, xNorth, alt";
  output Units.Angle theta[3] "attitude angles; roll, pitch, yaw";
  
  
annotation (defaultComponentName="VisInfoOut",
   Icon(coordinateSystem(
        initialScale = 0.16), graphics={Rectangle(lineColor = {95, 95, 95}, lineThickness = 0.5, extent = {{-10, 10}, {10, -10}}), Rectangle(fillColor = {144, 144, 144}, fillPattern = FillPattern.Solid, extent = {{-30, 100}, {30, -100}}), Polygon(origin = {4, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-28, 41}, {-28, -39}, {22, 1}, {-28, 41}})}),
   Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.16), graphics={Text(
          extent={{-140,-50},{140,-88}},
          lineColor={0,0,0},
          textString="%name"), Rectangle(
          extent={{-12,40},{12,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));

end VisualizerInfoOut00;
