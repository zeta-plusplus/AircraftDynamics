within AircraftDynamics.RigidBodyFDM.BaseClasses;

partial model LTISS00 "Linear Time Invariant State Space"
  import Modelica.Math.Matrices;
  /* ---------------------------------------------
        Internal variables
  --------------------------------------------- */
  replaceable Real x[4] "State vector";
  replaceable Real vec_u[2] "Input vector";
  replaceable Real y[6] "Output vector";
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
  replaceable parameter Real A[4,4](each fixed=false) annotation(
    fixed=false, HideResult=false);
  replaceable parameter Real B[4,2](each fixed=false) annotation(
    fixed=false, HideResult=false);
  replaceable parameter Real C[6,4](each fixed=false) annotation(
    fixed=false, HideResult=false);
  replaceable parameter Real D[6,2](each fixed=false) annotation(
    fixed=false, HideResult=false);
  //---
  replaceable parameter Real x0[4](each fixed=false) "Initial state vector" annotation(
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
  der(x) = A * x + B * vec_u;
  y = C * x + D * vec_u;
  //---
  
  
end LTISS00;
