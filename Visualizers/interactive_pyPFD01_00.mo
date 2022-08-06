within AircraftDynamics.Visualizers;

block interactive_pyPFD01_00
  /********************************************************
              imports
          ********************************************************/
  import Modelica.Utilities.Streams;
  import Modelica.Utilities.Files;
  import Modelica.Utilities.System;
  import InteractiveSimulation.Output.Functions;
  import Units= Modelica.SIunits;
  import Modelica.Mechanics.MultiBody.Frames;
  
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  //Units.Angle theta[3] "euler angles of aircraft body, roll, pitch, heading";
  //Units.Angle thetaV[3] "euler angles of velcity vector, roll, pitch heading";
  Units.Velocity V "velocity";
  Units.Angle theta4disp[3] "roll, pitch heading";
  /**/
  
  /********************************************************
              Declaration
  ********************************************************/
  /* ---------------------------------------------
              parameters
          --------------------------------------------- */
  parameter String namePythonPath = "C:\Program Files\Python310";
  parameter String nameFileDataCSV = "currentFlightStates00.csv";
  parameter String namePathDataCSV = "modelica://AircraftDynamics/dataTemp";
  parameter Modelica.SIunits.Time tInterval = 0.01 "in [s]";
  /* ---------------------------------------------
              Internal variables
       --------------------------------------------- */
  discrete Integer nPrinted;
  Real variables2Print[nVariables];
  /* ---------------------------------------------
              Interface
  --------------------------------------------- */
  Interfaces.VisualizerInfoIn00 VisInfoIn annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  //******************************************************************************************
    InteractiveSimulation.Utilities.TimeSignalOut timeSignalOut1 annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  /* ---------------------------------------------
              parameters
      --------------------------------------------- */
  parameter String nameFilePyScript = "pyPFD01.py";
  parameter String namePathPyScript = "modelica://AircraftDynamics/Visualizers";
  parameter String nameFilePathDataCSV = namePathDataCSV + "/" + nameFileDataCSV;
  parameter String nameFullFilePathDataCSV = Files.loadResource(nameFilePathDataCSV);
  parameter String nameFullPathPyScript = Files.loadResource(namePathPyScript);
  parameter String nameFilePathPyScript = namePathPyScript + "/" + nameFilePyScript;
  parameter String nameFullFilePathPyScript = Files.loadResource(nameFilePathPyScript);
  parameter Integer nVariables = 17 "number of variables";
  parameter String nameVariables[nVariables] 
    = {"time[s]", "V", "alt", 
      "phi", "theta", "psi", "alpha", "beta",
      "u", "v", "w", 
      "X_dot", "Y_dot", "Z_dot", 
      "xEast", "xNorth", "alt"};
  //******************************************************************************************
initial algorithm
//----- display inputs on command line -----
  Streams.print("writing csv: " + nameFullFilePathDataCSV);
  Streams.print("full path: " + nameFullPathPyScript);
  Streams.print("script name: " + nameFilePyScript);
  Streams.print("script full file path: " + nameFullFilePathPyScript);
//----- execute python script -----
  System.setEnvironmentVariable("PATH", namePythonPath, true);
  System.command("start python " + nameFullFilePathPyScript);
  nPrinted := 0;
//******************************************************************************************
algorithm
  when sample(tInterval, tInterval) then
    nPrinted := InteractiveSimulation.Output.Functions.C_printVariablesList2file01(
        nameFullFilePathDataCSV, nameVariables, variables2Print, pre(nPrinted));
  end when;
//******************************************************************************************
equation
  /*------------------------------
    convert angles for display (0-360 deg)
  ------------------------------*/
  for i in 1:3 loop
    theta4disp[i]
      = AircraftDynamics.Functions.calcAngles4display(VisInfoIn.theta[i]);
  end for;  
  /**/
  V= sqrt(VisInfoIn.V[1]^2.0 + VisInfoIn.V[3]^2.0 + VisInfoIn.V[3]^2.0);
//-----
  variables2Print[1]= timeSignalOut1.y;
  variables2Print[2]= V;
  variables2Print[3]= VisInfoIn.r[3];
  variables2Print[4]= theta4disp[1];
  variables2Print[5]= theta4disp[2];
  variables2Print[6]= theta4disp[3];
  variables2Print[7]= VisInfoIn.alpha;
  variables2Print[8]= VisInfoIn.beta;
  variables2Print[9]= VisInfoIn.V[1];
  variables2Print[10]= VisInfoIn.V[2];
  variables2Print[11]= VisInfoIn.V[3];
  variables2Print[12]= der(VisInfoIn.r[1]);
  variables2Print[13]= der(VisInfoIn.r[2]);
  variables2Print[14]= der(VisInfoIn.r[3]);
  variables2Print[15]= VisInfoIn.r[1];
  variables2Print[16]= VisInfoIn.r[2];
  variables2Print[17]= VisInfoIn.r[3];
//-----
  annotation(
    defaultComponentName = "pyPFD",
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-12, -101}, extent = {{-88, -1}, {112, -21}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end interactive_pyPFD01_00;
