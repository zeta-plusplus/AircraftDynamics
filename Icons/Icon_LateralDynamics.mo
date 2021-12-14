within AircraftDynamics.Icons;

partial model Icon_LateralDynamics
  annotation(
    Icon(coordinateSystem(extent = {{-150, -150}, {150, 150}}), graphics = {Rectangle(origin = {66, 152}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-216, -2}, {84, -302}}), Text(origin = {-44, -27}, extent = {{-104, 108}, {25, 79}}, textString = "d(x[t]) = A*x[t] + B*u[t]"), Polygon(origin = {61, -11}, fillColor = {85, 255, 255}, fillPattern = FillPattern.Solid, points = {{-61, 41}, {39, -41}, {39, -59}, {-61, -17}, {-61, 41}}), Polygon(origin = {49, -83}, fillColor = {85, 255, 255}, fillPattern = FillPattern.Solid, points = {{-49, 7}, {-15, -19}, {-15, -33}, {-49, -25}, {-49, 7}}), Polygon(origin = {-57, 33}, fillColor = {85, 255, 255}, fillPattern = FillPattern.Solid, points = {{-43, -85}, {57, -3}, {57, -61}, {-43, -103}, {-43, -85}}), Polygon(origin = {19, -65}, fillColor = {85, 255, 255}, fillPattern = FillPattern.Solid, points = {{-51, -37}, {-19, -11}, {-19, -43}, {-51, -51}, {-51, -37}}), Polygon(origin = {-1, -12}, fillColor = {85, 255, 0}, fillPattern = FillPattern.Solid, points = {{1, 114}, {7, 92}, {9, 76}, {11, 46}, {11, -4}, {11, -64}, {9, -84}, {5, -114}, {-3, -114}, {-7, -86}, {-9, -64}, {-9, -4}, {-9, 46}, {-7, 76}, {-5, 92}, {1, 114}}, smooth = Smooth.Bezier), Line(origin = {14.8732, -168.486}, points = {{-158, 36}, {-60, 36}}, thickness = 0.5, arrow = {Arrow.None, Arrow.Open}), Text(origin = {-33, -181}, extent = {{-9, 56}, {2, 41}}, textString = "y"), Text(origin = {-133, -59}, extent = {{-9, 56}, {2, 41}}, textString = "x"), Line(origin = {-134.374, -76.9605}, points = {{0, -62}, {0, 54}}, thickness = 0.5, arrow = {Arrow.None, Arrow.Open}), Line(origin = {-26.4084, 28.7539}, rotation = -5, points = {{27.5852, -21.1138}, {16.7837, 108.29}}, pattern = LinePattern.Dash, thickness = 0.5), Line(origin = {63.1188, 36.0818}, points = {{-43, 99}, {-63, -23}}, pattern = LinePattern.DashDot, thickness = 0.5), Line(origin = {48.4346, 12.1401}, rotation = -5, points = {{80.5991, 6.66262}, {-51.1217, -4.50242}}, pattern = LinePattern.Dash, thickness = 0.5), Text(origin = {34, 81}, extent = {{-12, 42}, {3, 31}}, textString = "V"), Line(origin = {35.0241, 125.161}, points = {{-15, 8}, {-23, -44}}, color = {85, 0, 255}, thickness = 2, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Ellipse(origin = {0, 12}, fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, 7}, {7, -7}}), Polygon(origin = {-2, 5}, rotation = -180, fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-37, -8}, {-25, 0}, {-25, -4}, {-5, -4}, {-5, -10}, {-25, -10}, {-25, -14}, {-37, -8}}), Text(origin = {51, -14}, extent = {{-17, 41}, {4, 30}}, textString = "Fy"), Line(origin = {0.27366, 130.66}, points = {{0.79289, -2.2071}, {8.79289, -0.207107}, {16.7929, -4.20711}}, thickness = 0.75, smooth = Smooth.Bezier), Text(origin = {-7, 102}, extent = {{-17, 41}, {4, 30}}, textString = "beta"), Line(origin = {20.27, 93.8}, points = {{-24.0271, 4.778}, {-33.0271, 9.778}, {-32.0271, 16.778}, {-26.0271, 22.778}, {-18.0271, 22.778}, {-12.0271, 14.778}}, color = {255, 0, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5, smooth = Smooth.Bezier), Text(origin = {-18, 70}, extent = {{-12, 41}, {3, 30}}, textString = "L"), Line(origin = {29.0462, 14.21}, points = {{-48.0271, 10.778}, {-42.0271, 20.778}, {-30.0271, 24.778}, {-18.0271, 22.778}, {-8.0271, 10.778}}, color = {255, 0, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5, smooth = Smooth.Bezier), Text(origin = {-21, -2}, extent = {{-17, 41}, {4, 30}}, textString = "N")}));
end Icon_LateralDynamics;
