within AircraftDynamics.Visualizers;

model AnimATI00
  import Units= Modelica.SIunits;
  import Modelica.Mechanics.MultiBody.Frames;
  
  
  
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  Units.Angle theta[3] "euler angles of aircraft body, roll, pitch, heading";
  Units.Angle thetaV[3] "euler angles of velcity vector, roll, pitch heading";
  Real rGrd[3] "position of artificial horizon symbol";
  
  Units.Angle theta4disp[3];
  /**/
  
  
  
  /* ---------------------------------------------
              Internal objects
  --------------------------------------------- */
  inner Modelica.Mechanics.MultiBody.World world(
    animateGravity = false,
    animateWorld = false, 
    axisDiameter = diameterOfAxes, 
    axisLength = lengthOfAxes, 
    enableAnimation = true
    )  annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Frames.Orientation R "orientation of aircraft body";
  Frames.Orientation RHI "orientation of heading indicator";
  
  //----------
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape nose(
    shapeType = "cone", 
    extra=0,
    length = lenCone, 
    width = diamCone, 
    lengthDirection = {0, 1, 0}, 
    widthDirection = {1, 0, 0}, 
    r_shape = {0, 0, 0},
    r= {0,-3/4*lenCone,0},
    color={255, 255, 0}
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape wingL(
    shapeType = "cylinder", 
    length = 6, 
    width = 0.5, 
    lengthDirection = {-1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {-1.5, 0, 0},
    r= {0,0,0},
    color={255, 255, 0}
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape wingR(
    shapeType = "cylinder", 
    length = 6, 
    width = 0.5, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {1.5, 0, 0},
    r= {0,0,0},
    color={255, 255, 0}
    );
  
  //-----
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape VVector(
    shapeType = "sphere", 
    length = diamVVector, 
    r_shape = {-1/2*diamVVector+VisInfoIn.beta*180/Modelica.Constants.pi*len1degPitch,
               -1*VisInfoIn.alpha*180/Modelica.Constants.pi*len1degPitch,
               0},
    r= {0,
      0,
      3},
    color={0, 255, 0}
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape VVector_wing(
    shapeType = "cylinder", 
    length = 2*diamVVector, 
    width = 0.3, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {-1/2*diamVVector+VisInfoIn.beta*180/Modelica.Constants.pi*len1degPitch-1/2*diamVVector,
               -1*VisInfoIn.alpha*180/Modelica.Constants.pi*len1degPitch,
               0},
    r= {0,
        0,
        3},
    color={0, 255, 0}
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape VVector_Vstab(
    shapeType = "cylinder", 
    length = 0.8*diamVVector, 
    width = 0.3, 
    lengthDirection = {0, 1, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {-1/2*diamVVector+VisInfoIn.beta*180/Modelica.Constants.pi*len1degPitch+1/2*diamVVector,
               -1*VisInfoIn.alpha*180/Modelica.Constants.pi*len1degPitch,
               0},
    r= {0,
        0,
        3},
    color={0, 255, 0}
    );
  
  //-----
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape horizon(
    shapeType = "cylinder", 
    length = widthOfHorizon, 
    width = thickOfHorizon, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOfHorizon, rGrd[2], rGrd[3]},
    r= {0,0,0},
    R = R,
    color={0, 0, 0}
    );
  /**/
  
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape ground(
    shapeType = "box", 
    length = widthOfHorizon, 
    width = 0.5, 
    height = 90*len1degPitch, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOfHorizon, rGrd[2]-1/2*90*len1degPitch, rGrd[3]},
    r= {0,0,-0.5},
    R = R,
    color={171, 127, 92}
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape sky(
    shapeType = "box", 
    length = widthOfHorizon, 
    width = 0.5, 
    height = 90*len1degPitch, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOfHorizon, rGrd[2]+1/2*90*len1degPitch, rGrd[3]},
    r= {0,0,-0.5},
    R = R,
    color={135, 206, 250}
    );
  /**/
  
  //----------
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineP10deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]+10*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorPline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineP20deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]+20*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorPline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineP30deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]+30*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorPline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineP40deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]+40*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorPline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineP50deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]+50*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorPline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineP60deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]+60*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorPline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineP70deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]+70*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorPline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineP80deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]+80*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorPline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineP90deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]+90*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorPline
    );
  
  
  //----------
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineN10deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]-10*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorNline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineN20deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]-20*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorNline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineN30deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]-30*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorNline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineN40deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]-40*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorNline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineN50deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]-50*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorNline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineN60deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]-60*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorNline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineN70deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]-70*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorNline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineN80deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]-80*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorNline
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape lineN90deg(
    shapeType = "cylinder", 
    length = widthOf10degLine, 
    width = thickOf10degLine, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 0, 1}, 
    r_shape = {rGrd[1]-1/2*widthOf10degLine, rGrd[2]-90*len1degPitch, rGrd[3]},
    r= {0,0,0},
    R = R,
    color=colorNline
    );
  
  //----------
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape HI(
    shapeType= "pipe",
    extra=0.6,
    length=0.5,
    width= diamHI,
    lengthDirection={0,0,1},
    widthDirection= {1,0,0},
    r_shape={0,0,0},
    r=r_HI,
    R=RHI,
    color=colorHI
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow HIheading(
    r_tail = {0, 0, 0},
    r_head = {0, 1.4*1/2*diamHI, 0},
    r= r_HI+{0,0,1},
    diameter= diameterOfAxes*1.2,
    color={0,0,0}
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow HInorth(
    r_tail = {0, -1.3*1/2*diamHI, 0},
    r_head = {0, 1.3*diamHI, 0},
    r= r_HI,
    diameter= 0.4,
    color={180,0,255},
    R = RHI
    );
  
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape HIeast(
    shapeType= "cylinder",
    length= diamHI*1.3,
    width= 0.3,
    r_shape={-1/2*1.3*diamHI, 0, 0},
    r= r_HI,
    color=colorHI,
    R = RHI
    );
  /**/
  
  
  /* ---------------------------------------------
                Interface
  --------------------------------------------- */
  AircraftDynamics.Interfaces.VisualizerInfoIn00 VisInfoIn annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  
  
//**************************************************
protected
  /* ---------------------------------------------
              parameters
  --------------------------------------------- */
  parameter Units.Length widthOf10degLine=20;
  parameter Units.Length thickOf10degLine=0.1;
  //-----
  parameter Units.Length widthOfHorizon=120;
  parameter Units.Length thickOfHorizon=0.2;
  //-----
  parameter Units.Length len1degPitch=0.5;
  //-----
  parameter Units.Length lengthOfAxes=20;
  parameter Units.Length diameterOfAxes=0.125;
  //-----
  parameter Units.Length diamCone=6;
  parameter Units.Length lenCone=1/3*diamCone;
  //-----
  parameter Units.Length diamVVector=2;
  //-----
  parameter Integer colorPline[3]={0,0,255};
  parameter Integer colorNline[3]={255,0,0};
  //-----
  parameter Units.Length diamHI= 10;
  parameter Real r_HI[3]={0,-25*len1degPitch,1};
  parameter Integer colorHI[3]={0,0,255};
  
  
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
  R = Frames.axisRotation(3, -1*theta4disp[1], der(theta[1]));
  RHI = Frames.axisRotation(3, -1*theta4disp[3]- 90.0*Modelica.Constants.pi/180.0, der(VisInfoIn.theta[3]));
  rGrd[1]=0;
  rGrd[2]= -len1degPitch*theta4disp[2]*180/Modelica.Constants.pi;
  rGrd[3]=0;
    
  
  annotation(defaultComponentName="AnimATI",
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian -d=initialization, --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 ",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", maxIntegrationOrder = "3"),
  Icon(graphics = {Text(origin = {-1, -111}, extent = {{-99, 9}, {101, -9}}, textString = "%name"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
  
end AnimATI00;
