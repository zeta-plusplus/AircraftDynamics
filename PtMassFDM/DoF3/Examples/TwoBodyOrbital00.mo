within AircraftDynamics.PtMassFDM.DoF3.Examples;

model TwoBodyOrbital00
  extends Modelica.Icons.Example;
  import units = Modelica.Units.SI;
  parameter Integer nEdgeM1 = 361;
  parameter units.Length rM1 = 6378.137*10.0^3.0;
  parameter units.Mass m1 = 5.972*10.0^(24.0) "default value is mass of the earch";
  parameter units.Mass m2 = 68585 "default value is empty mass of space shuttle orbiter";
  parameter units.Length r2_init[3] = {(6378.137 + 400)*10.0^3.0, 0.0, 0.0};
  parameter units.Length v2_init[3] = {0.0, 7670, 0.0};
  
  Real mu;
  units.Length r2[3];
  units.Velocity v2[3];
  units.Acceleration a2[3];
  //---
  units.Length mag_r2;
  units.Length Alt;
  units.Velocity vAbs;
  
  
protected
  parameter units.Length xEdgeM1[nEdgeM1](each fixed=false) annotation(
    HideResult = false);
  parameter units.Length yEdgeM1[nEdgeM1](each fixed=false) annotation(
    HideResult = false);
  
initial equation
  
  for i in 1:nEdgeM1 loop
    xEdgeM1[i] = rM1*cos((i-1)/nEdgeM1*2.0*Modelica.Constants.pi);
    yEdgeM1[i] = rM1*sin((i-1)/nEdgeM1*2.0*Modelica.Constants.pi);
  end for;
  
  for i in 1:3 loop
    r2[i] = r2_init[i];
    v2[i] = v2_init[i];
  end for;
  
equation
  
  mu = Modelica.Constants.G*(m1 + m2);
  mag_r2 = (r2[1]^2 + r2[2]^2 + r2[3])^(0.5);
  Alt= mag_r2 - rM1;
  vAbs= (v2[1]^2 + v2[2]^2 + v2[3]^2 )^(0.5);
  //-----
  for i in 1:3 loop
    der(r2[i]) = v2[i];
    der(v2[i]) = a2[i];
    a2[i] = (-mu/mag_r2^3)*r2[i];
  end for;
  
  
  annotation(
    experiment(StartTime = 0, StopTime = 7000, Tolerance = 1e-06, Interval = 5));
end TwoBodyOrbital00;
