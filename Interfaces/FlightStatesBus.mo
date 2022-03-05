within AircraftDynamics.Interfaces;

expandable connector FlightStatesBus
  extends Modelica.Icons.SignalBus;
  import SI= Modelica.SIunits;
  /********************************************************
                         Declaration
  ********************************************************/
  /*-------------------------
  -------------------------*/
  SI.Velocity u "velocity along airframe x-axis";
  SI.Velocity v "velocity along airframe y-axis";
  SI.Velocity w "velocity along airframe z-axis";
  
  SI.Velocity V "flight velocity, or 'TAS'";
  Real Mn "flight mach number";
  
  SI.Velocity dXG "velocity along X-Global";
  SI.Velocity dYG "velocity along Y-Global";
  SI.Velocity dZG "velocity along Z-Global";
  
  SI.Position XG "position based on X-Global";
  SI.Position YG "position based on Y-Global";
  SI.Position ZG "position based on Z-Global, -1*alt";
  SI.Position xNorth "position in direction of north";
  SI.Position xEast "position in direction of east";
  SI.Position alt "flight altitude";
  
  /*-------------------------
  -------------------------*/
  SI.Force Xf "Force along airframe x-axis";
  SI.Force Yf "Force along airframe y-axis";
  SI.Force Zf "Force along airframe z-axis";
  
  SI.Force Ftan "force tangent to flight velocity, not along x-axis";
  SI.Force Fcentr "centripital force which is perpendicular to flight velocity, not along z-axis";
  SI.Force Fturn "centripital force of horizontal turning circle";
  
  /*-------------------------
  -------------------------*/
  SI.Angle alpha "angle of attack";
  SI.Angle gamma "flight path angle";
  SI.Angle beta "sideslip angle";
  
  /*-------------------------
  -------------------------*/
  SI.Angle theta "pitch angle";
  SI.Angle phi "bank angle";
  SI.Angle psi "heading angle";
  
  /*-------------------------
  -------------------------*/
  SI.AngularVelocity p "angular velocity around airframe x-axis";
  SI.AngularVelocity q "angular velocity around airframe y-axis";
  SI.AngularVelocity r "angular velocity around airframe z-axis";
  
  /*-------------------------
  -------------------------*/
  SI.MomentOfForce L "moment around airframe x-axis";
  SI.MomentOfForce M "moment around airframe y-axis";
  SI.MomentOfForce N "moment around airframe z-axis";
  
  annotation (defaultComponentName="FltStatesBus");
  
end FlightStatesBus;
