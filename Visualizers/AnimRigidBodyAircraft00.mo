within AircraftDynamics.Visualizers;

model AnimRigidBodyAircraft00
  import Units= Modelica.SIunits;
  import Modelica.Mechanics.MultiBody.Frames;
  
  /* ---------------------------------------------
              parameters
  --------------------------------------------- */
  parameter String fileAircraftMdl="modelica://AircraftDynamics/Visualizers/3dmodels/MSN001A1WR_mod001.dxf";
  parameter Units.Position CGbody[3]={15, 0, 1};
  parameter Units.Length lengthOfAxes=200;
  parameter Units.Length diameterOfAxes=0.25;
  
  parameter Units.Length offset_r0[3]={0,0,1000} "initial position offset for animation display";
  
  parameter Units.Length length=2 "not used";
  parameter Units.Length width=1 "not used";
  parameter Units.Length height= 0.3 "not used";
  
  
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  Units.Position r[3];
  Units.Angle theta[3];
  
  Units.Angle theta4disp[3] "euler angles of aircraft body 0-360 deg, roll, pitch, heading";
  /**/
  
  /* ---------------------------------------------
              Internal objects
  --------------------------------------------- */
  inner Modelica.Mechanics.MultiBody.World world(
    animateGravity = false,
    animateWorld = true, 
    axisDiameter = diameterOfAxes, 
    axisLength = lengthOfAxes, 
    enableAnimation = true,
    axisColor_x={0, 0, 255},
    axisColor_y={0, 0, 255},
    axisColor_z={0, 0, 255}
    )  annotation(
    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //-----
  Frames.Orientation R;
  
  //-----
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape aircraft(
    shapeType = fileAircraftMdl, 
    length = 2, 
    width = 1, 
    height = 0.3, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 1, 0}, 
    r_shape = {-1.0*CGbody[1], -1.0*CGbody[2], -1.0*CGbody[3]},
    r= r,
    R = R);
  /**/
  
  
  /* ---------------------------------------------
                Interface
  --------------------------------------------- */
  AircraftDynamics.Interfaces.VisualizerInfoIn00 VisInfoIn annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  
equation
  /*------------------------------
  interface; internal -- connector
  ------------------------------*/
  for i in 1:3 loop
    r[i]= VisInfoIn.r[i]+offset_r0[i];
  end for;
  
  theta[1]= -1.0*VisInfoIn.theta[1];
  theta[2]= VisInfoIn.theta[2];
  theta[3]= -1.0*VisInfoIn.theta[3] - 90.0*Modelica.Constants.pi/180.0;
  
  /*------------------------------
    convert angles for display (0-360 deg)
  ------------------------------*/
  for i in 1:3 loop
    theta4disp[i]
      = AircraftDynamics.Functions.calcAngles4display(theta[i]);
  end for;
  /**/
  
  
  /*------------------------------
  describing physics
  ------------------------------*/
  R = Frames.axesRotations({3, 2, 1}, {theta4disp[3], theta4disp[2], theta4disp[1]}, {der(theta[3]), der(theta[2]), der(theta[1])});
  
  
  
  annotation(defaultComponentName="AnimAircraft",
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian -d=initialization, --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 ",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", maxIntegrationOrder = "3"),
  Icon(graphics = {Text(origin = {-1, -111}, extent = {{-99, 9}, {101, -9}}, textString = "%name"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
  
end AnimRigidBodyAircraft00;
