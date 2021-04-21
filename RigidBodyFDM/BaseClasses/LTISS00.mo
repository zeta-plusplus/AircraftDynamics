within AircraftDynamics.RigidBodyFDM.BaseClasses;

partial model LTISS00 "Linear Time Invariant State Space"
  import Modelica.Math.Matrices;
  /* ---------------------------------------------
        Internal variables
  --------------------------------------------- */
  replaceable Real x "State vector";
  replaceable Real u "Input vector";
  replaceable Real y "Output vector";
  //---
  /*
  replaceable Real eigA "eigenvalues of matrix A";
  replaceable Real eigVecA "eigen vectors of matrix A";
  */
  //********************************************************************************
protected
  /* ---------------------------------------------
        parameters not fixed yet
  --------------------------------------------- */
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
algorithm
  //(eigA, eigVecA) := Modelica.Math.Matrices.eigenValues(A);
  
  //********************************************************************************
equation
  
  /* ---------------------------------------------
    Eqns describing physics
  --------------------------------------------- */
  //-----
  der(x) = A * x + B * u;
  y = C * x + D * u;
  //---
  
  
end LTISS00;
