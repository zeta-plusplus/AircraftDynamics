within AircraftDynamics.RigidBodyFDM.BaseClasses;

partial model LTISS00 "Linear Time Invariant State Space"
  /* ---------------------------------------------
        Internal variables
  --------------------------------------------- */
  replaceable Real x "State vector";
  replaceable Real u "Input vector";
  replaceable Real y "Output vector";
  
  
  //********************************************************************************
protected
  /* ---------------------------------------------
        parameters not fixed yet
  --------------------------------------------- */
  replaceable parameter Integer nx "number of state variables";
  replaceable parameter Integer nu "number of inputs";
  replaceable parameter Integer ny "number of outputs";
  
  //---
  replaceable parameter Real A(each fixed=false) annotation(
    fixed=false, HideResult=false);
  replaceable parameter Real B(each fixed=false) annotation(
    fixed=false, HideResult=false);
  replaceable parameter Real C(each fixed=false) annotation(
    fixed=false, HideResult=false);
  replaceable parameter Real D(each fixed=false) annotation(
    fixed=false, HideResult=false);
  //---
  replaceable parameter Real x0(each fixed=false) "Initial state vector" annotation(
    HideResult=false);
  
  //********************************************************************************
initial equation
  x = x0;
  
  
  //********************************************************************************
equation
  
  /* ---------------------------------------------
    Eqns describing physics
  --------------------------------------------- */
  //-----
  der(x) = A * x + B * u;
  y = C * x + D * u;
  
  
end LTISS00;
