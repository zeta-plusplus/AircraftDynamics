within AircraftDynamics.Visualizers;

model AnimRigidBodyAircraftAttitude00
  import units= Modelica.Units.SI;
  import Modelica.Mechanics.MultiBody.Frames;
  
  /* ---------------------------------------------
              parameters
  --------------------------------------------- */
  parameter String fileAircraftMdl="modelica://AircraftDynamics/Visualizers/3dmodels/MSN001A1WR_mod001.dxf";
  parameter units.Position CGbody[3]={15, 0, -1};
  parameter units.Length lengthOfAxes=30;
  parameter units.Length diameterOfAxes=0.75;
  
  parameter units.Length length=2 "not used";
  parameter units.Length width=1 "not used";
  parameter units.Length height= 0.3 "not used";
  
  
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  units.Angle theta[3] "euler angles of aircraft body, roll, pitch, heading";
  units.Angle thetaV[3] "euler angles of velcity vector, roll, pitch heading";
  
  units.Angle theta4disp[3] "euler angles of aircraft body 0-360 deg, roll, pitch, heading";
  units.Angle thetaV4disp[3] "euler angles of velcity vector 0-360 deg, roll, pitch heading";
  /**/
  
  /* ---------------------------------------------
              Internal objects
  --------------------------------------------- */
  inner Modelica.Mechanics.MultiBody.World world(
    animateGravity = false,animateWorld = true, 
    axisDiameter = diameterOfAxes, 
    axisLength = lengthOfAxes, 
    enableAnimation = true, label1 = "East", label2 = "North",
    axisColor_x={0, 0, 255},
    axisColor_y={0, 0, 255},
    axisColor_z={0, 0, 255}
    )  annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Frames.Orientation R "orientation of aircraft body";
  Frames.Orientation RV "orientation of velocity vector";
  
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape aircraft(
    shapeType = fileAircraftMdl, 
    color={255, 0, 0},
    length = length, 
    width = 1, 
    height = 0.3, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 1, 0}, 
    r_shape = {-1.0*CGbody[1], -1.0*CGbody[2], -1.0*CGbody[3]},
    r= {0,0,0},
    R = R
    );
  /* 
  "modelica://AircraftDynamics/Visualizers/3dmodels/MSN001A1WR-mod001.stl" 
  "modelica://AircraftDynamics/Visualizers/3dmodels/MSN001A1WR_mod001.dxf"
  Modelica.Utilities.Files.loadResource("modelica://AircraftDynamics/Visualizers/3dmodels/MSN001A1WR_mod001.dxf")
  */
  
  /*
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape shape00(
    shapeType = "modelica://AircraftDynamics/Visualizers/3dmodels/part1.dxf", 
    color={255, 0, 0},
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 1, 0}, 
    r_shape = {0, 0, 0},
    r= {0,0,-5}
    );
  */
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow VVector(
    r_tail = {0,0,0},
    r_head = {-1.3*CGbody[1], 0.0, 0.0},
    r= {0,0,0},
    
    color={0, 255, 0},
    R = RV);
  /*diameter= diameterOfAxes*1.05,*/
  
  
  /* ---------------------------------------------
                Interface
  --------------------------------------------- */
  AircraftDynamics.Interfaces.VisualizerInfoIn00 VisInfoIn annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
equation
  /*------------------------------
  interface; internal -- connector
  ------------------------------*/
  theta[1]= -1.0*VisInfoIn.theta[1];
  theta[2]= VisInfoIn.theta[2];
  theta[3]= -1.0*VisInfoIn.theta[3] - 90.0*Modelica.Constants.pi/180.0;
  thetaV[1]= theta[1];
  thetaV[2]= theta[2]-VisInfoIn.alpha;
  thetaV[3]= theta[3]+VisInfoIn.beta;
  
  /*------------------------------
    convert angles for display (0-360 deg)
  ------------------------------*/
  for i in 1:3 loop
    [theta4disp[i], thetaV4disp[i]]
      = AircraftDynamics.Functions.calcAngles4display([theta[i], thetaV[i]]);
  end for;
  /**/
  
  /*------------------------------
  describing physics
  ------------------------------*/
  R = Frames.axesRotations({3, 2, 1}, {theta4disp[3], theta4disp[2], theta4disp[1]}, 
                          {der(theta[3]), der(theta[2]), der(theta[1])});
  RV = Frames.axesRotations({3, 2, 1}, {thetaV4disp[3], thetaV4disp[2], thetaV4disp[1]},
                          {der(thetaV[3]), der(thetaV[2]), der(thetaV[1])});
  
  
  annotation(defaultComponentName="AnimAircraft",
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian -d=initialization, --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 ",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", maxIntegrationOrder = "3"),
  Icon(graphics = {Text(origin = {-1, -111}, extent = {{-99, 9}, {101, -9}}, textString = "%name"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
  
end AnimRigidBodyAircraftAttitude00;
