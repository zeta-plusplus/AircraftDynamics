within AircraftDynamics.Interfaces;

connector InCntrSrcForceMoment6DoF00
  import Units= Modelica.SIunits;
  //----------
  
  input Units.Force F[3] "force along body axes, X, Y, Z";
  input Units.MomentOfForce M[3] "moment about body axes, L, M, N";
  //-----
  output Units.Mass m "mass";
  output Units.Position r[3] "position (global frame); xEast, xNorth, alt";
  output Units.Angle theta[3] "attitude angles; phi(roll), theta(pitch), psi(yaw)";
  output Units.Angle alpha "angle of attack";
  output Units.Angle beta "sideslip angle";
  output Units.AngularVelocity omega[3] "angular velocity along body axes; p, q, r";
  output Units.Velocity v[3] "velocity along body axes; u, v, w";
  
  
annotation (defaultComponentName="InCntrSrcForceMoment",
   Icon(coordinateSystem(
        initialScale = 0.16), graphics={Rectangle(lineColor = {95, 95, 95}, lineThickness = 0.5, extent = {{-10, 10}, {10, -10}}), Rectangle(fillColor = {237, 237, 237}, fillPattern = FillPattern.Solid, extent = {{-30, 100}, {30, -100}}), Polygon(origin = {-4, 0}, fillPattern = FillPattern.Solid, points = {{-21, 40}, {-21, -40}, {31, 0}, {-21, 40}})}),
   Diagram(coordinateSystem(initialScale = 0.16)));


end InCntrSrcForceMoment6DoF00;