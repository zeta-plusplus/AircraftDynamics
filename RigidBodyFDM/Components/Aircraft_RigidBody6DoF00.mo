within AircraftDynamics.RigidBodyFDM.Components;

model Aircraft_RigidBody6DoF00
  extends AircraftDynamics.Interfaces.RigidAircraftFrame00;
  extends AircraftDynamics.Icons.Icon_Aircraft6DoF;
  //----- imports -----
  import Const = Modelica.Constants;
  import Units = Modelica.SIunits;
  /* ---------------------------------------------
                  Internal variables
      --------------------------------------------- */
  /**/
  
  /* ---------------------------------------------
                    Interfaces
  --------------------------------------------- */
  AircraftDynamics.Interfaces.FlightStatesBus fltStatesBus annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  //**********************************************************************
equation
/*------------------------------
      interfacing
  ------------------------------*/
  mTot = mTot_par;
  Ixx = Ixx_par;
  Ixy = Ixy_par;
  Ixz = Ixz_par;
  Iyx = Iyx_par;
  Iyy = Iyy_par;
  Iyz = Iyz_par;
  Izx = Izx_par;
  Izy = Izy_par;
  Izz = Izz_par;
  for i in 1:3 loop
    rCG[i] = rCG_par[i];
  end for;
  
  //----------
  //connect(fltStatesBus, );
  connect(fltStatesBus.phi, phi);
  connect(fltStatesBus.theta, theta);
  connect(fltStatesBus.psi, psi);
  
  connect(fltStatesBus.alpha, alpha);
  connect(fltStatesBus.beta, beta);
  connect(fltStatesBus.gamma, gamma);
  
  connect(fltStatesBus.L, L);
  connect(fltStatesBus.M, M);
  connect(fltStatesBus.N, N);
  
  connect(fltStatesBus.p, p);
  connect(fltStatesBus.q, q);
  connect(fltStatesBus.r, r);
  
  connect(fltStatesBus.u, u);
  connect(fltStatesBus.v, v);
  connect(fltStatesBus.w, w);
  
  connect(fltStatesBus.Xf, Xf);
  connect(fltStatesBus.Yf, Yf);
  connect(fltStatesBus.Zf, Zf);
  
  connect(fltStatesBus.alt, alt);
  connect(fltStatesBus.xEast, xEast);
  connect(fltStatesBus.xNorth, xNorth);
  
  connect(fltStatesBus.dXG, dXG);
  connect(fltStatesBus.dYG, dYG);
  connect(fltStatesBus.dZG, dZG);
  
  connect(fltStatesBus.XG, XG);
  connect(fltStatesBus.YG, YG);
  connect(fltStatesBus.ZG, ZG);
  //----------
  
/*------------------------------
      component physics
  ------------------------------*/
//----- linear momentum -----
  mTot * (der(u) + q * w - r * v) = Xf;
  mTot * (der(v) + u * r - p * w) = Yf;
  mTot * (der(w) + p * v - q * u) = Zf;
/*
  mTot*(der(u)) = Xf;
  mTot*(der(v)) = Yf;
  mTot*(der(w)) = Zf;
  */
//----- angular momentum -----
  der(p) * Ixx - der(q) * Ixy - der(r) * Izx + p * r * Ixy + (r ^ 2 - q ^ 2) * Iyz - p * q * Izx + (Izz - Iyy) * r * q = L;
  der(q) * Iyy - der(p) * Ixy - der(r) * Iyz + p * r * (Ixx - Izz) + (p ^ 2 - r ^ 2) * Izx - q * r * Ixy + p * q * Iyz = M;
  der(r) * Izz - der(p) * Izx - der(q) * Iyz + p * q * (Iyy - Ixx) + (q ^ 2 - p ^ 2) * Ixy + q * r * Izx - p * r * Iyz = N;
//----- flight path -----
  (dXG, dYG, dZG) = AircraftDynamics.Functions.flightPathFormula00(u = u, v = v, w = w, phi = phi, theta = theta, psi = psi);
  der(XG) = dXG;
  der(YG) = dYG;
  der(ZG) = dZG;
  der(dXG) = d2XG;
  der(dYG) = d2YG;
  der(dZG) = d2ZG;
//----- angular kinematics -----
  (dPhi, dTheta, dPsi) = AircraftDynamics.Functions.angularKinematics00(p = p, q = q, r = r, phi = phi, theta = theta, psi = psi);
  der(phi) = dPhi;
  der(theta) = dTheta;
  der(psi) = dPsi;
  der(dPhi) = d2phi;
  der(dTheta) = d2theta;
  der(dPsi) = d2psi;
//-----
  (alpha, beta, gamma) = AircraftDynamics.Functions.alphaBetaGamma00(u = u, v = v, w = w, dXG = dXG, dYG = dYG, dZG = dZG);
protected
  annotation(
    defaultComponentName = "AircraftDyn",
    Icon(graphics = {Text(origin = {0, 80}, extent = {{-100, 10}, {100, -10}}, textString = "%name")}));
end Aircraft_RigidBody6DoF00;
