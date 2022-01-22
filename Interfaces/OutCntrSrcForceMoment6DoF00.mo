within AircraftDynamics.Interfaces;

connector OutCntrSrcForceMoment6DoF00
  import Units= Modelica.SIunits;
  //----------
  
  output Units.Force F[3] "force along body axes, X, Y, Z";
  output Units.MomentOfForce M[3] "moment about body axes, L, M, N";
  //-----
  input Units.Mass m "mass";
  input Units.Position r[3] "position (global frame); xEast, xNorth, alt";
  input Units.Angle theta[3] "attitude angles; phi(roll), theta(pitch), psi(yaw)";
  input Units.Angle alpha "angle of attack";
  input Units.Angle beta "sideslip angle";
  input Units.AngularVelocity omega[3] "angular velocity along body axes; p, q, r";
  input Units.Velocity v[3] "velocity along body axes; u, v, w";
  input Units.Position rCG[3] "";
  
annotation (defaultComponentName="OutCntrSrcForceMoment",
   Icon(coordinateSystem(
        initialScale = 0.16), graphics={Rectangle(lineColor = {95, 95, 95}, lineThickness = 0.5, extent = {{-10, 10}, {10, -10}}), Rectangle(fillColor = {144, 144, 144}, fillPattern = FillPattern.Solid, extent = {{-30, 100}, {30, -100}}), Polygon(origin = {4, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-28, 41}, {-28, -39}, {22, 1}, {-28, 41}})}),
   Diagram(coordinateSystem(initialScale = 0.16)));


end OutCntrSrcForceMoment6DoF00;
