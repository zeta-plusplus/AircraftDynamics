within AircraftDynamics.Functions;

function flightPathFormula00
  extends Modelica.Icons.Function;
  //****************************************
  import Units= Modelica.SIunits;
  //****************************************
  input Units.Velocity u;
  input Units.Velocity v;
  input Units.Velocity w;
  input Units.Angle phi;
  input Units.Angle theta;
  input Units.Angle psi;
  //----------
  output Units.Velocity dXG;
  output Units.Velocity dYG;
  output Units.Velocity dZG;
  
//****************************************
protected
  Units.Velocity vector_v[3] "velocity vector along body frame";
  Units.Velocity vector_dr[3] "velocity vector in global frame";
  Real rotPsi[3,3];
  Real rotPhi[3,3];
  Real rotTheta[3,3];
  Real matVelOrt[3,3] "orientation of velocity vector, rotPsi*rotTheta*rotPhi";
  
//****************************************
algorithm
  vector_v[1]:= u;
  vector_v[2]:= v;
  vector_v[3]:= w;
  //----------
  rotPsi:= [cos(psi), -sin(psi), 0.0;
            sin(psi), cos(psi), 0.0;
            0.0, 0.0, 1.0];
  rotTheta:= [cos(theta), 0.0, sin(theta);
              0.0, 1.0, 0.0;
              -sin(theta), 0.0, cos(theta)];
  rotPhi:= [1.0, 0.0, 0.0;
            0.0, cos(phi), -sin(phi);
            0.0, sin(phi), cos(phi)];
  matVelOrt:= rotPsi*rotTheta*rotPhi;
  vector_dr:= matVelOrt*vector_v;
  //----------
  dXG:= vector_dr[1];
  dYG:= vector_dr[2];
  dZG:= vector_dr[3];
end flightPathFormula00;
