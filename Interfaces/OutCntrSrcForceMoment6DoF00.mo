within AircraftDynamics.Interfaces;

connector OutCntrSrcForceMoment6DoF00
  import units= Modelica.Units.SI;
  //----------
  
  output units.Force F[3] "force along body axes, X, Y, Z";
  output units.MomentOfForce M[3] "moment about body axes, L, M, N";
  //-----
  input units.Mass m "mass";
  input units.Position r[3] "position (global frame); xEast, xNorth, alt";
  input units.Angle theta[3] "attitude angles; phi(roll), theta(pitch), psi(yaw)";
  input units.Angle alpha "angle of attack";
  input units.Angle beta "sideslip angle";
  input units.AngularVelocity omega[3] "angular velocity along body axes; p, q, r";
  input units.Velocity v[3] "velocity along body axes; u, v, w";
  input units.Position rCG[3] "";
  
annotation (defaultComponentName="OutCntrSrcForceMoment",
   Icon(coordinateSystem(
        initialScale = 0.16), graphics={Rectangle(lineColor = {95, 95, 95}, lineThickness = 0.5, extent = {{-10, 10}, {10, -10}}), Rectangle(fillColor = {144, 144, 144}, fillPattern = FillPattern.Solid, extent = {{-30, 100}, {30, -100}}), Polygon(origin = {4, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-28, 41}, {-28, -39}, {22, 1}, {-28, 41}})}),
   Diagram(coordinateSystem(initialScale = 0.16)));


end OutCntrSrcForceMoment6DoF00;
