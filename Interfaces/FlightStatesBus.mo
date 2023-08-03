within AircraftDynamics.Interfaces;

expandable connector FlightStatesBus
  extends Modelica.Icons.SignalBus;
  import units = Modelica.Units.SI;
  /********************************************************
                         Declaration
  ********************************************************/
  /*-------------------------
  -------------------------*/
  units.Velocity u "velocity along airframe x-axis";
  units.Velocity v "velocity along airframe y-axis";
  units.Velocity w "velocity along airframe z-axis";
  
  units.Velocity V "flight velocity, or 'TAS'";
  Real Mn "flight mach number";
  
  units.Velocity dXG "velocity along X-Global";
  units.Velocity dYG "velocity along Y-Global";
  units.Velocity dZG "velocity along Z-Global";
  
  units.Position XG "position based on X-Global";
  units.Position YG "position based on Y-Global";
  units.Position ZG "position based on Z-Global, -1*alt";
  units.Position xNorth "position in direction of north";
  units.Position xEast "position in direction of east";
  units.Position alt "flight altitude";
  
  /*-------------------------
  -------------------------*/
  units.Force Xf "Force along airframe x-axis";
  units.Force Yf "Force along airframe y-axis";
  units.Force Zf "Force along airframe z-axis";
  
  units.Force Ftan "force tangent to flight velocity, not along x-axis";
  units.Force Fcentr "centripital force which is perpendicular to flight velocity, not along z-axis";
  units.Force Fturn "centripital force of horizontal turning circle";
  
  /*-------------------------
  -------------------------*/
  units.Angle alpha "angle of attack";
  units.Angle gamma "flight path angle";
  units.Angle beta "sideslip angle";
  
  /*-------------------------
  -------------------------*/
  units.Angle theta "pitch angle";
  units.Angle phi "bank angle";
  units.Angle psi "heading angle";
  
  /*-------------------------
  -------------------------*/
  units.AngularVelocity p "angular velocity around airframe x-axis";
  units.AngularVelocity q "angular velocity around airframe y-axis";
  units.AngularVelocity r "angular velocity around airframe z-axis";
  
  /*-------------------------
  -------------------------*/
  units.MomentOfForce L "moment around airframe x-axis";
  units.MomentOfForce M "moment around airframe y-axis";
  units.MomentOfForce N "moment around airframe z-axis";
  
  annotation (defaultComponentName="FltStatesBus");
  
end FlightStatesBus;
