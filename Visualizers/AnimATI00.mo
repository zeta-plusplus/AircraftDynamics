within AircraftDynamics.Visualizers;

model AnimATI00
  import Units= Modelica.SIunits;
  import Modelica.Mechanics.MultiBody.Frames;
  
  /* ---------------------------------------------
              parameters
  --------------------------------------------- */
  parameter Units.Length widthOf10degLine=10;
  parameter Units.Length thickOf10degLine=0.1;
  parameter Units.Length widthOfHorizon=50;
  parameter Units.Length thickOfHorizon=0.25;
  //-----
  parameter Units.Length len1degPitch=0.5;
  //-----
  parameter Units.Length lengthOfAxes=5;
  parameter Units.Length diameterOfAxes=1/40*lengthOfAxes;
  
  
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  Units.Angle theta[3] "euler angles of aircraft body, roll, pitch, heading";
  Units.Angle thetaV[3] "euler angles of velcity vector, roll, pitch heading";
  
  
  
  /* ---------------------------------------------
              Internal objects
  --------------------------------------------- */
  inner Modelica.Mechanics.MultiBody.World world(
    animateGravity = false,animateWorld = true, 
    axisDiameter = diameterOfAxes, 
    axisLength = lengthOfAxes, 
    enableAnimation = true
    )  annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Frames.Orientation R "orientation of aircraft body";
  Real rGrd[3];
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape horizon(
    shapeType = "box", 
    length = widthOfHorizon, 
    width = 2, 
    height = thickOfHorizon, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOfHorizon, rGrd[2], rGrd[3]},
    r= {0,0,0},
    R = R,
    color={0, 0, 0}
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineP10deg(
    shapeType = "box", 
    length = widthOf10degLine, 
    width = 2, 
    height = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]+10*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color={0, 0, 256}
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineN10deg(
    shapeType = "box", 
    length = widthOf10degLine, 
    width = 2, 
    height = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]-10*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color={256, 0, 0}
    );
  
  
  /* ---------------------------------------------
                Interface
  --------------------------------------------- */
  AircraftDynamics.Interfaces.VisualizerInfoIn00 VisInfoIn annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  
  
//**************************************************
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
  describing physics
  ------------------------------*/
  R = Frames.axisRotation(3, theta[1], der(theta[1]));
  rGrd[1]=0;
  rGrd[2]= -len1degPitch*theta[2]*180/Modelica.Constants.pi;
  rGrd[3]=0;
  
  
  annotation(defaultComponentName="AnimAircraft",
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian -d=initialization, --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 ",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", maxIntegrationOrder = "3"),
  Icon(graphics = {Text(origin = {-1, -111}, extent = {{-99, 9}, {101, -9}}, textString = "%name"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
  
end AnimATI00;
