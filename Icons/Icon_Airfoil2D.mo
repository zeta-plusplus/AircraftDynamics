within AircraftDynamics.Icons;

model Icon_Airfoil2D
equation

annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(extent = {{-100, -80}, {100, 80}}), graphics = {Polygon(origin = {36, -2}, fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid, points = {{-92, 2}, {-82, 10}, {-64, 16}, {-48, 18}, {-28, 18}, {-12, 14}, {2, 10}, {14, 6}, {68, -16}, {20, -4}, {4, -2}, {-10, -2}, {-24, -2}, {-40, -2}, {-54, -4}, {-68, -6}, {-76, -6}, {-84, -4}, {-88, -2}, {-92, 2}}, smooth = Smooth.Bezier), Line(origin = {-73.22, -4.46}, points = {{-19, -3}, {19, 3}}, color = {0, 0, 255}, arrow = {Arrow.None, Arrow.Filled}), Line(origin = {6.89, -6.9}, points = {{-99, 9}, {87, -7}}, pattern = LinePattern.Dash), Line(origin = {-85.37, -2.6}, points = {{2.79289, -2.2071}, {0.79289, -0.20711}, {2.79289, 3.79289}}, smooth = Smooth.Bezier), Text(origin = {-79, -35}, extent = {{-11, 26}, {2, 19}}, textString = "AoA"), Line(origin = {-0.13, 4.67}, points = {{-19, -3}, {-1, -5}}, color = {255, 0, 0}, thickness = 0.5, arrow = {Arrow.None, Arrow.Open}, arrowSize = 2), Line(origin = {9.87, 14.67}, points = {{-29, -13}, {-23, 39}}, color = {255, 0, 0}, thickness = 0.5, arrow = {Arrow.None, Arrow.Open}, arrowSize = 2), Text(origin = {-17, 19}, extent = {{-11, 26}, {2, 19}}, textString = "Cl"), Text(origin = {1, -35}, extent = {{-9, 26}, {2, 19}}, textString = "Cd")}));
end Icon_Airfoil2D;
