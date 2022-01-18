within AircraftDynamics.Functions;

function inverseRotateVector3D00
  extends Modelica.Icons.Function;
  //****************************************
  import Units= Modelica.SIunits;
  import Matrices= Modelica.Math.Matrices;
  //****************************************
  input Real y[3] "vector after rotation";
  input Units.Angle theta[3];
  //----------
  output Real u[3] "vector before rotation";
  
//****************************************
protected
  Real rotTheta1[3,3];
  Real rotTheta2[3,3];
  Real rotTheta3[3,3];
  Real matInvRot[3,3] "";
  
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
  matInvRot:= Matrices.inv(rotTheta3)*Matrices.inv(rotTheta2)*Matrices.inv(rotTheta1);
  u:= matInvRot*y;
  
end inverseRotateVector3D00;
