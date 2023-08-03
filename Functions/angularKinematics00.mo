within AircraftDynamics.Functions;

function angularKinematics00
  extends Modelica.Icons.Function;
  //****************************************
  import units= Modelica.Units.SI;
  //****************************************
  input units.AngularVelocity p;
  input units.AngularVelocity q;
  input units.AngularVelocity r;
  input units.Angle phi;
  input units.Angle theta;
  input units.Angle psi;
  //----------
  output units.AngularVelocity dPhi;
  output units.AngularVelocity dTheta;
  output units.AngularVelocity dPsi;
  
//****************************************
protected
  units.AngularVelocity vector_dTheta[3];
  units.AngularVelocity vector_omega[3];
  Real matAngVelOrt[3,3] "orientation of angular velocity vector";
  
//****************************************  
algorithm
  vector_omega[1]:= p;
  vector_omega[2]:= q;
  vector_omega[3]:= r;
  //----------
  matAngVelOrt:=[1.0, sin(phi)*tan(theta), cos(phi)*tan(theta);
                 0.0, cos(phi), -sin(phi);
                 0.0, sin(phi)*1.0/cos(theta), cos(phi)*1.0/cos(theta)];  
  vector_dTheta := matAngVelOrt * vector_omega;
  //----------
  dPhi:= vector_dTheta[1];
  dTheta:= vector_dTheta[2];
  dPsi:= vector_dTheta[3];
  
end angularKinematics00;
