within AircraftDynamics.Interfaces;

connector InCntrSrcForceMoment6DoF00
  import units= Modelica.Units.SI;
  //----------
  
  input units.Force F[3] "force along body axes, X, Y, Z";
  input units.MomentOfForce M[3] "moment about body axes, L, M, N";
  //-----
  output units.Mass m "mass";
  output units.Position r[3] "position (global frame); xEast, xNorth, alt";
  output units.Angle theta[3] "attitude angles; phi(roll), theta(pitch), psi(yaw)";
  output units.Angle alpha "angle of attack";
  output units.Angle beta "sideslip angle";
  output units.AngularVelocity omega[3] "angular velocity along body axes; p, q, r";
  output units.Velocity v[3] "velocity along body axes; u, v, w";
  output units.Position rCG[3] "";
  
annotation (defaultComponentName="InCntrSrcForceMoment",
   Icon(coordinateSystem(
        initialScale = 0.16), graphics={Rectangle(lineColor = {95, 95, 95}, lineThickness = 0.5, extent = {{-10, 10}, {10, -10}}), Rectangle(fillColor = {237, 237, 237}, fillPattern = FillPattern.Solid, extent = {{-30, 100}, {30, -100}}), Polygon(origin = {-4, 0}, fillPattern = FillPattern.Solid, points = {{-21, 40}, {-21, -40}, {31, 0}, {-21, 40}})}),
   Diagram(coordinateSystem(initialScale = 0.16)));


end InCntrSrcForceMoment6DoF00;
