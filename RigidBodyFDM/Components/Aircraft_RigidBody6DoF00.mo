within AircraftDynamics.RigidBodyFDM.Components;

model Aircraft_RigidBody6DoF00
  extends AircraftDynamics.Interfaces.RigidAircraftFrame00;
  extends AircraftDynamics.Icons.Icon_Aircraft6DoF;
  
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
  mTot*(der(fltStates.u)+fltStates.q*fltStates.w-fltStates.r*fltStates.v)
    = fltStates.X;
  
  
  
  
end Aircraft_RigidBody6DoF00;
