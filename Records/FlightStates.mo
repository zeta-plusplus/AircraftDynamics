within AircraftDynamics.Records;

record FlightStates
  extends Modelica.Icons.Record;
  
  /*-------------------------
  -------------------------*/
  Modelica.SIunits.Velocity u "velocity along airframe x-axis";
  Modelica.SIunits.Velocity v "velocity along airframe y-axis";
  Modelica.SIunits.Velocity w "velocity along airframe z-axis";
  
  Modelica.SIunits.Velocity V "flight velocity, or 'TAS'";
  Real Mn "flight mach number";
  
  /*-------------------------
  -------------------------*/
  Modelica.SIunits.Force X "Force along airframe x-axis";
  Modelica.SIunits.Force Y "Force along airframe y-axis";
  Modelica.SIunits.Force Z "Force along airframe z-axis";
  
  Modelica.SIunits.Force Ftan "force tangent to flight velocity, not along x-axis";
  Modelica.SIunits.Force Fcentr "centripital force which is perpendicular to flight velocity, not along z-axis";
  Modelica.SIunits.Force Fturn "centripital force of horizontal turning circle";
  
  /*-------------------------
  -------------------------*/
  Modelica.SIunits.Angle alpha "angle of attack";
  Modelica.SIunits.Angle gamma "flight path angle";
  Modelica.SIunits.Angle beta "sideslip angle";
  
  /*-------------------------
  -------------------------*/
  Modelica.SIunits.Angle theta "pitch angle";
  Modelica.SIunits.Angle phi "bank angle";
  Modelica.SIunits.Angle psi "heading angle";
  
  /*-------------------------
  -------------------------*/
  Modelica.SIunits.AngularVelocity p "angular velocity around airframe x-axis";
  Modelica.SIunits.AngularVelocity q "angular velocity around airframe y-axis";
  Modelica.SIunits.AngularVelocity r "angular velocity around airframe z-axis";
  
  /*-------------------------
  -------------------------*/
  Modelica.SIunits.MomentOfForce L "moment around airframe x-axis";
  Modelica.SIunits.MomentOfForce M "moment around airframe y-axis";
  Modelica.SIunits.MomentOfForce N "moment around airframe z-axis";
  
end FlightStates;
