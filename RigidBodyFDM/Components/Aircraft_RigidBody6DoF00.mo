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
  
  
//**********************************************************************
equation
  /*------------------------------
      interfacing
  ------------------------------*/
  mTot= mTot_par;
  Ixx= Ixx_par;
  Ixy= Ixy_par;
  Ixz= Ixz_par;
  Iyx= Iyx_par;
  Iyy= Iyy_par;
  Iyz= Iyz_par;
  Izx= Izx_par;
  Izy= Izy_par;
  Izz= Izz_par;
  
  
  
  /*------------------------------
      component physics
  ------------------------------*/
  //----- linear momentum -----
  mTot*(der(u)+q*w-r*v) = Xf;
  mTot*(der(v)+u*r-p*w) = Yf;
  mTot*(der(w)+p*v-q*u) = Zf;
  
  //----- angular momentum -----
  (der(p)*Ixx-der(q)*Ixy-der(r)*Izx)+(p*r*Ixy+(r^2-q^2)*Iyz-p*q*Izx+(Izz-Iyy)*r*q) = L;
  (der(q)*Iyy-der(p)*Ixy-der(r)*Iyz)+(p*r*(Ixx-Izz)+(p^2-r^2)*Izx-q*r*Ixy+p*q*Iyz) = M;
  (der(r)*Izz-der(p)*Izx-der(q)*Iyz)+(p*q*(Iyy-Ixx)+(q^2-p^2)*Ixy+q*r*Izx-p*r*Iyz) = N;
  
  //----- flight path -----
  (dXG, dYG, dZG)
    =AircraftDynamics.Functions.flightPathFormula00(u=u, v=v, w=w, phi=phi, theta=theta, psi=psi);
  
  der(XG)=dXG;
  der(YG)=dYG;
  der(ZG)=dZG;
  
  der(dXG)=d2XG;
  der(dYG)=d2YG;
  der(dZG)=d2ZG;
  
  //----- angular kinematics -----
  (dPhi, dTheta, dPsi)
    =AircraftDynamics.Functions.angularKinematics00(p=p, q=q, r=r, phi=phi, theta=theta, psi=psi);
  der(phi)= dPhi;
  der(theta)= dTheta;
  der(psi)= dPsi;
  
  der(dPhi)=d2phi;
  der(dTheta)=d2theta;
  der(dPsi)= d2psi;
  
  //-----
  (alpha, beta, gamma)
    =AircraftDynamics.Functions.alphaBetaGamma00(u=u, v=v, w=w, dXG=dXG, dYG=dYG, dZG=dZG);
  
  annotation(
    defaultComponentName = "AirplaneDyn");  
  
  
end Aircraft_RigidBody6DoF00;
