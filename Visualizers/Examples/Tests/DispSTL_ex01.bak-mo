within AircraftDynamics.Visualizers.Examples.Tests;

model DispSTL_ex01
  import Modelica.Mechanics.MultiBody.Frames;
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-74, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Frames.Orientation R;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape aircraft(shapeType = "modelica://AircraftDynamics/Visualizers/3dmodels/MSN001A1WR-mod001.stl", length = 2, width = 1, height = 0.3, lengthDirection = {1, 0, 0}, widthDirection = {0, 0, 1}, r_shape = {0, 0, 0}, r = {0, 0, 0}, R = R);
  /* */
  /*
    Modelica.Mechanics.MultiBody.Parts.BodyShape aircraft(r = {0, 0.351, 0}, shapeType = "modelica://AircraftDynamics/Visualizers/3dmodels/MSN001A1WR-mod001.stl", r_shape = {0, 0, 0}, lengthDirection = {1, 0, 0}, widthDirection = {0, 1, 0}, length = 0.225, width = 0.3, height = 0.3, color = {0, 0, 255}, r_CM = {0, 0, 0}, m = 1);
    */
equation
  R = Frames.axisRotation(1, time * 3.14, der(time * 3.14));
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian -d=initialization, --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 ",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", maxIntegrationOrder = "3", outputFormat = "mat"));
end DispSTL_ex01;
