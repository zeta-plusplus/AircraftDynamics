within AircraftDynamics.Icons;

partial model Icon_DragObject
  annotation(
    Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}}), graphics = {Ellipse(origin = {5, 0}, fillColor = {85, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-75, 10}, {75, -10}}), Line(origin = {-86, 0}, points = {{-12, 0}, {12, 0}}, arrow = {Arrow.None, Arrow.Open}), Line(origin = {-74, 8}, points = {{-22, -4}, {-14, -4}, {-6, -4}, {0, -2}, {8, 2}, {14, 4}, {22, 6}}, arrow = {Arrow.None, Arrow.Open}, smooth = Smooth.Bezier), Line(origin = {-74.89, -10.11}, points = {{-21.1063, 6.10634}, {-13.1063, 6.10634}, {-9.10634, 6.10634}, {-3.10634, 6.10634}, {0.893661, 4.10634}, {4.89366, 2.10634}, {8.89366, 0.10634}, {12.8937, -1.89366}, {22.8937, -3.89366}}, arrow = {Arrow.None, Arrow.Open}, smooth = Smooth.Bezier), Polygon(origin = {-17, 2}, fillColor = {170, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-17, -4}, {-17, 0}, {-7, 0}, {-7, 4}, {1, -2}, {-7, -8}, {-7, -4}, {-17, -4}}), Text(origin = {-6, 0}, extent = {{-10, 4}, {10, -4}}, textString = "Drag")}));
end Icon_DragObject;
