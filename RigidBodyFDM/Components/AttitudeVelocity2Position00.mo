within AircraftDynamics.RigidBodyFDM.Components;

model AttitudeVelocity2Position00
  /********************************************************
                    imports
  ********************************************************/
  import Modelica.Constants;
  import Modelica.SIunits;
  
  
  /********************************************************
                       Declaration
  ********************************************************/
  /* ---------------------------------------------
              Internal variables
  --------------------------------------------- */
  SIunits.Angle theta "pitch";
  SIunits.Angle phi "bank";
  SIunits.Angle psi "heading";
  
  SIunits.Velocity velocityAlongBody[3] "velocity vector along body frame";
  SIunits.Velocity velocityInGlobal[3] "velocity vector in global frame";
  SIunits.Position position[3] "position vector in global frame";
  
  Real rotPsi[3,3];
  Real rotPhi[3,3];
  Real rotTheta[3,3];
  Real directionCosineMatrix[3,3];
  
  
  /* ---------------------------------------------
                  Interface
  --------------------------------------------- */
  AircraftDynamics.Types.InfoBus busAttitude annotation(
    Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus busPosition annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus busVelocityAlongBody annotation(
    Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  //**********************************************************************
equation
  /*------------------------------
  interface; internal -- connector
  ------------------------------*/
  connect(theta, busAttitude.theta);
  connect(phi, busAttitude.phi);
  connect(psi, busAttitude.psi);
//---
  connect(velocityAlongBody[1], busVelocityAlongBody.u);
  connect(velocityAlongBody[2], busVelocityAlongBody.v);
  connect(velocityAlongBody[3], busVelocityAlongBody.w);
  //---
  connect(position[1], busPosition.XG);
  connect(position[2], busPosition.YG);
  connect(position[3], busPosition.ZG);
  
  
  /* ---------------------------------------------
  Eqns describing physics
  --------------------------------------------- */
  rotPsi=[cos(psi), -sin(psi), 0.0;
          sin(psi), cos(psi), 0.0;
          0.0, 0.0, 1.0];
  rotTheta=[cos(theta), 0.0, sin(theta);
          0.0, 1.0, 0.0;
          -sin(theta), 0.0, cos(theta)];
  rotPhi=[1.0, 0.0, 0.0;
          0.0, cos(phi), -sin(phi);
          0.0, sin(phi), cos(phi)];
  //---
  directionCosineMatrix=rotPsi*rotTheta*rotPhi;
  velocityInGlobal= directionCosineMatrix*velocityAlongBody;
  der(position)= velocityInGlobal;
  //---
  
  
annotation(
    defaultComponentName = "Body2Global",
    Icon(graphics = {Rectangle(origin = {2, -2}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-102, 102}, {98, -98}}), Text(origin = {-1, -90}, extent = {{-95, 10}, {97, -10}}, textString = "%name")}));
  
  
end AttitudeVelocity2Position00;
