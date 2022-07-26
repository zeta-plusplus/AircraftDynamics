within AircraftDynamics.Visualizers;

model VisPointMass
  extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialShape;
  
  
  
equation

annotation(
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -112}, extent = {{-100, 8}, {100, -8}}, textString = "%name")}));
end VisPointMass;
