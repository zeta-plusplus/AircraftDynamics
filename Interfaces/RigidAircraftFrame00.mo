within AircraftDynamics.Interfaces;

partial model RigidAircraftFrame00
  //----- imports -----
  import Const = Modelica.Constants;
  import Units = Modelica.SIunits;
  /********************************************************
           Declaration
    ********************************************************/
  /* ---------------------------------------------
                Parameters
    --------------------------------------------- */
  parameter Integer nSrcForceMoment = 1 "Number of sources of forces&moments" annotation(
    Dialog(group = "Connector setting"));
  //---------- Aircraft Properties ----------
  parameter Units.Mass mTot_par = 1202.01978 "total mass of aircraft body";
  parameter Units.MomentOfInertia Ixx_par = 1285.3154166;
  parameter Units.MomentOfInertia Iyy_par = 1824.9309607;
  parameter Units.MomentOfInertia Izz_par = 2666.89390765;
  
  parameter Units.MomentOfInertia Ixy_par = 0.0;
  parameter Units.MomentOfInertia Iyz_par = 0.0;
  parameter Units.MomentOfInertia Izx_par = 0.0;
  
  parameter Units.Position rCG_par[3]= {1, 0, 0.5} "position vector of CG, origin is nose of aircraft";
  
  //-----
  
  //---------- Initial Conditions ----------
  parameter Units.Velocity u_init_par=0 annotation(
    Dialog(tab = "Initial states"));
  parameter Units.Velocity v_init_par=0 annotation(
    Dialog(tab = "Initial states"));
  parameter Units.Velocity w_init_par=0 annotation(
    Dialog(tab = "Initial states"));
  
  parameter Units.Position XG_init_par=0 annotation(
    Dialog(tab = "Initial states"));
  parameter Units.Position YG_init_par=0 annotation(
    Dialog(tab = "Initial states"));
  parameter Units.Position ZG_init_par=-1000.0 annotation(
    Dialog(tab = "Initial states"));
  
  parameter Units.AngularVelocity p_init_par=0 annotation(
    Dialog(tab = "Initial states"));
  parameter Units.AngularVelocity q_init_par=0 annotation(
    Dialog(tab = "Initial states"));
  parameter Units.AngularVelocity r_init_par=0 annotation(
    Dialog(tab = "Initial states"));
  
  parameter Units.Angle phi_init_par=0 annotation(
    Dialog(tab = "Initial states"));
  parameter Units.Angle theta_init_par=5*Modelica.Constants.pi/180 annotation(
    Dialog(tab = "Initial states"));
  parameter Units.Angle psi_init_par=0 annotation(
    Dialog(tab = "Initial states"));
  
  
  
  /* ---------------------------------------------
                Internal variables
    --------------------------------------------- */
  Units.Force sum_u_F[3];
  Units.MomentOfForce sum_u_M[3];
  
  //---------- Aircraft Properties ----------
  Units.Mass mTot "total mass of aircraft body";
  Units.Position rCG[3] "position vector of CG, origin is nose of aircraft";
  Units.MomentOfInertia Ixx;
  Units.MomentOfInertia Iyy;
  Units.MomentOfInertia Izz;
  Units.MomentOfInertia Ixy;
  Units.MomentOfInertia Ixz;
  Units.MomentOfInertia Iyx;
  Units.MomentOfInertia Iyz;
  Units.MomentOfInertia Izx;
  Units.MomentOfInertia Izy;
  //-----
  //---------- Aircraft States ----------
  Units.Position xEast;
  Units.Position xNorth;
  Units.Position alt;
  
  Units.Position XG(fixed=true, start=XG_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  Units.Position YG(fixed=true, start=YG_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  Units.Position ZG(fixed=true, start=ZG_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  
  Units.Velocity dXG;
  Units.Velocity dYG;
  Units.Velocity dZG;
  
  Units.Acceleration d2XG;
  Units.Acceleration d2YG;
  Units.Acceleration d2ZG;
  
  Units.Angle phi(fixed=true, start=phi_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  Units.Angle theta(fixed=true, start=theta_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  Units.Angle psi(fixed=true, start=psi_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  
  Units.Angle alpha;
  Units.Angle beta;
  Units.Angle gamma;
  
  Units.Angle phi4disp;
  Units.Angle theta4disp;
  Units.Angle psi4disp;
  
  Units.Angle alpha4disp;
  Units.Angle beta4disp;
  Units.Angle gamma4disp;
  
  Units.AngularVelocity dPhi;
  Units.AngularVelocity dTheta;
  Units.AngularVelocity dPsi;
  
  Units.AngularAcceleration d2phi;
  Units.AngularAcceleration d2theta;
  Units.AngularAcceleration d2psi;
  
  Units.Velocity u(fixed=true, start=u_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  Units.Velocity v(fixed=true, start=v_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  Units.Velocity w(fixed=true, start=w_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  
  Units.AngularVelocity p(fixed=true, start=p_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  Units.AngularVelocity q(fixed=true, start=q_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  Units.AngularVelocity r(fixed=true, start=r_init_par) annotation(
    Dialog(tab = "Variables", group = "start attribute", enable = true, showStartAttribute = true));
  
  Units.Force Xf;
  Units.Force Yf;
  Units.Force Zf;
  
  Units.MomentOfForce L;
  Units.MomentOfForce M;
  Units.MomentOfForce N;
  
  
  /* ---------------------------------------------
                Interfaces
    --------------------------------------------- */
  AircraftDynamics.Interfaces.InCntrSrcForceMoment6DoF00 inCntrSrcForceMoment[nSrcForceMoment] annotation(
    Placement(visible = true, transformation(origin = {-100, -2}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-100, -2}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  AircraftDynamics.Interfaces.VisualizerInfoOut00 VisInfoOut annotation(
    Placement(visible = true, transformation(origin = {80, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {80, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  AircraftDynamics.Types.InfoBus infoBus annotation(
    Placement(visible = true, transformation(origin = {100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  
//**********************************************************************
protected
  /* ---------------------------------------------
                Parameters
    --------------------------------------------- */
  parameter Real k_u_FM[nSrcForceMoment] = ones(nSrcForceMoment) "sum coefficients, all 1";
  parameter Units.MomentOfInertia Ixz_par = Izx_par;
  parameter Units.MomentOfInertia Iyx_par = Ixy_par;
  parameter Units.MomentOfInertia Izy_par = Iyz_par;
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
    inCntrSrcForceMoment[i].m=mTot;
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
      inCntrSrcForceMoment[i].rCG[j]= rCG[j];
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
  //-----
  
  
  /*------------------------------
      component physics
  ------------------------------*/
  //----------
  (xEast, xNorth, alt) 
    = AircraftDynamics.Functions.GlobalFrame2earthConvention(XG = XG, YG = YG, ZG = ZG);
  
  
  /*------------------------------
    convert angles for display (0-360 deg)
  ------------------------------*/
  [phi4disp, theta4disp, psi4disp, alpha4disp, beta4disp, gamma4disp] 
    = AircraftDynamics.Functions.calcAngles4display([phi, theta, psi, alpha, beta, gamma]);
  
  //----------
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end RigidAircraftFrame00;
