within AircraftDynamics.Interfaces;

model RigidAircraftFrame00
  //----- imports -----
  import Const = Modelica.Constants;
  import units = Modelica.Units.SI;
  /********************************************************
               Declaration
        ********************************************************/
  /* ---------------------------------------------
                    Parameters
        --------------------------------------------- */
  parameter Integer nSrcForceMoment = 1 "Number of sources of forces&moments" annotation(
    Dialog(group = "Connector setting"));
  //---------- Aircraft Properties ----------
  parameter units.Mass mTot_par = 1202.01978 "total mass of aircraft body";
  parameter units.MomentOfInertia Ixx_par = 1285.3154166;
  parameter units.MomentOfInertia Iyy_par = 1824.9309607;
  parameter units.MomentOfInertia Izz_par = 2666.89390765;
  parameter units.MomentOfInertia Ixy_par = 0.0;
  parameter units.MomentOfInertia Iyz_par = 0.0;
  parameter units.MomentOfInertia Izx_par = 0.0;
  parameter units.Position rCG_par[3] = {1, 0, 0.5} "position vector of CG, origin is nose of aircraft";
  //-----
  //---------- Initial Conditions ----------
  parameter units.Velocity u_init_par = 0 annotation(
    Dialog(tab = "Initial states"));
  parameter units.Velocity v_init_par = 0 annotation(
    Dialog(tab = "Initial states"));
  parameter units.Velocity w_init_par = 0 annotation(
    Dialog(tab = "Initial states"));
  parameter units.Position XG_init_par = 0 annotation(
    Dialog(tab = "Initial states"));
  parameter units.Position YG_init_par = 0 annotation(
    Dialog(tab = "Initial states"));
  parameter units.Position ZG_init_par = -1000.0 annotation(
    Dialog(tab = "Initial states"));
  parameter units.AngularVelocity p_init_par = 0 annotation(
    Dialog(tab = "Initial states"));
  parameter units.AngularVelocity q_init_par = 0 annotation(
    Dialog(tab = "Initial states"));
  parameter units.AngularVelocity r_init_par = 0 annotation(
    Dialog(tab = "Initial states"));
  parameter units.Angle phi_init_par = 0 annotation(
    Dialog(tab = "Initial states"));
  parameter units.Angle theta_init_par = 5 * Modelica.Constants.pi / 180 annotation(
    Dialog(tab = "Initial states"));
  parameter units.Angle psi_init_par = 0 annotation(
    Dialog(tab = "Initial states"));
  /* ---------------------------------------------
                    Internal variables
        --------------------------------------------- */
  units.Force sum_u_F[3];
  units.MomentOfForce sum_u_M[3];
  //---------- Aircraft Properties ----------
  units.Mass mTot "total mass of aircraft body";
  units.Position rCG[3] "position vector of CG, origin is nose of aircraft";
  units.MomentOfInertia Ixx;
  units.MomentOfInertia Iyy;
  units.MomentOfInertia Izz;
  units.MomentOfInertia Ixy;
  units.MomentOfInertia Ixz;
  units.MomentOfInertia Iyx;
  units.MomentOfInertia Iyz;
  units.MomentOfInertia Izx;
  units.MomentOfInertia Izy;
  //-----
  //---------- Aircraft States ----------
  units.Position xEast;
  units.Position xNorth;
  units.Position alt;
  units.Position XG(fixed = true, start = XG_init_par) "=xNorth" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.Position YG(fixed = true, start = YG_init_par) "=xEast" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.Position ZG(fixed = true, start = ZG_init_par) "=-alt" annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.Velocity dXG;
  units.Velocity dYG;
  units.Velocity dZG;
  units.Acceleration d2XG;
  units.Acceleration d2YG;
  units.Acceleration d2ZG;
  units.Angle phi(fixed = true, start = phi_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.Angle theta(fixed = true, start = theta_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.Angle psi(fixed = true, start = psi_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.Angle alpha;
  units.Angle beta;
  units.Angle gamma;
  units.Angle phi4disp;
  units.Angle theta4disp;
  units.Angle psi4disp;
  units.Angle alpha4disp;
  units.Angle beta4disp;
  units.Angle gamma4disp;
  units.AngularVelocity dPhi;
  units.AngularVelocity dTheta;
  units.AngularVelocity dPsi;
  units.AngularAcceleration d2phi;
  units.AngularAcceleration d2theta;
  units.AngularAcceleration d2psi;
  units.Velocity u(fixed = true, start = u_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.Velocity v(fixed = true, start = v_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.Velocity w(fixed = true, start = w_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.AngularVelocity p(fixed = true, start = p_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.AngularVelocity q(fixed = true, start = q_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.AngularVelocity r(fixed = true, start = r_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  units.Force Xf;
  units.Force Yf;
  units.Force Zf;
  units.MomentOfForce L;
  units.MomentOfForce M;
  units.MomentOfForce N;
  /* ---------------------------------------------
                    Interfaces
        --------------------------------------------- */
  AircraftDynamics.Interfaces.InCntrSrcForceMoment6DoF00 inCntrSrcForceMoment[nSrcForceMoment] annotation(
    Placement(visible = true, transformation(origin = {-100, -2}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-100, -2}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  AircraftDynamics.Interfaces.VisualizerInfoOut00 VisInfoOut annotation(
    Placement(visible = true, transformation(origin = {80, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {80, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
//**********************************************************************
protected
  /* ---------------------------------------------
                    Parameters
        --------------------------------------------- */
  parameter Real k_u_FM[nSrcForceMoment] = ones(nSrcForceMoment) "sum coefficients, all 1";
  parameter units.MomentOfInertia Ixz_par = Izx_par;
  parameter units.MomentOfInertia Iyx_par = Ixy_par;
  parameter units.MomentOfInertia Izy_par = Iyz_par;
  //**********************************************************************
equation
/*------------------------------
      interfacing
  ------------------------------*/
//--
  for i in 1:3 loop
    sum_u_F[i] = k_u_FM * inCntrSrcForceMoment.F[i];
    sum_u_M[i] = k_u_FM * inCntrSrcForceMoment.M[i];
  end for;
//-----
  Xf = sum_u_F[1];
  Yf = sum_u_F[2];
  Zf = sum_u_F[3];
  L = sum_u_M[1];
  M = sum_u_M[2];
  N = sum_u_M[3];
//-----
  for i in 1:nSrcForceMoment loop
    inCntrSrcForceMoment[i].m = mTot;
    inCntrSrcForceMoment[i].r[1] = XG;
    inCntrSrcForceMoment[i].r[2] = YG;
    inCntrSrcForceMoment[i].r[3] = alt;
    inCntrSrcForceMoment[i].theta[1] = phi;
    inCntrSrcForceMoment[i].theta[2] = theta;
    inCntrSrcForceMoment[i].theta[3] = psi;
    inCntrSrcForceMoment[i].alpha = alpha;
    inCntrSrcForceMoment[i].beta = beta;
    inCntrSrcForceMoment[i].omega[1] = p;
    inCntrSrcForceMoment[i].omega[2] = q;
    inCntrSrcForceMoment[i].omega[3] = r;
    inCntrSrcForceMoment[i].v[1] = u;
    inCntrSrcForceMoment[i].v[2] = v;
    inCntrSrcForceMoment[i].v[3] = w;
    for j in 1:3 loop
      inCntrSrcForceMoment[i].rCG[j] = rCG[j];
    end for;
  end for;
//-----
  VisInfoOut.alpha = alpha;
  VisInfoOut.beta = beta;
  VisInfoOut.r[1] = xEast;
  VisInfoOut.r[2] = xNorth;
  VisInfoOut.r[3] = alt;
  VisInfoOut.theta[1] = phi;
  VisInfoOut.theta[2] = theta;
  VisInfoOut.theta[3] = psi;
  VisInfoOut.V[1]= u;
  VisInfoOut.V[2]= v;
  VisInfoOut.V[3]= w;
//-----
  
/*------------------------------
      component physics
  ------------------------------*/
//----------
  (xEast, xNorth, alt) = AircraftDynamics.Functions.GlobalFrame2earthConvention(XG = XG, YG = YG, ZG = ZG);
/*------------------------------
    convert angles for display (0-360 deg)
  ------------------------------*/
  [phi4disp, theta4disp, psi4disp, alpha4disp, beta4disp, gamma4disp] = AircraftDynamics.Functions.calcAngles4display([phi, theta, psi, alpha, beta, gamma]);
//----------
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end RigidAircraftFrame00;
