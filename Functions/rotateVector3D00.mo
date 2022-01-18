within AircraftDynamics.Functions;

function rotateVector3D00
  extends Modelica.Icons.Function;
  //****************************************
  import Units= Modelica.SIunits;
  //****************************************
  input Real u[3];
  input Units.Angle theta[3];
  //----------
  output Real y[3];
  
//****************************************
protected
  Real rotTheta1[3,3];
  Real rotTheta2[3,3];
  Real rotTheta3[3,3];
  Real matRotOrt[3,3] "rotTheta1*rotTheta2*rotTheta3";
  
//****************************************
algorithm
  rotTheta1:= [cos(theta[1]), -sin(theta[1]), 0.0;
               sin(theta[1]), cos(theta[1]), 0.0;
               0.0, 0.0, 1.0];
  rotTheta2:= [cos(theta[2]), 0.0, sin(theta[2]);
               0.0, 1.0, 0.0;
               -sin(theta[2]), 0.0, cos(theta[2])];
  rotTheta3:= [1.0, 0.0, 0.0;
               0.0, cos(theta[3]), -sin(theta[3]);
               0.0, sin(theta[3]), cos(theta[3])];
  matRotOrt:= rotTheta1*rotTheta2*rotTheta3;
  y:= matRotOrt*u;
  
end rotateVector3D00;
