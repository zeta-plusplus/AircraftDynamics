within AircraftDynamics.PtMassFDM.DoF3.Examples;

model TwoBodyOrbital00
  extends Modelica.Icons.Example;
  import units = Modelica.Units.SI;
  parameter Integer nEdgeM1 = 361;
  parameter units.Length rM1 = 6378.137*10.0^3.0;
  parameter units.Mass m1_par = 5.972*10.0^(24.0) "default value is mass of the earch";
  parameter units.Mass m2_par = 68585 "default value is empty mass of space shuttle orbiter";
  parameter units.Length r1_init[3]= {0.0, 0.0, 0.0};
  parameter units.Length r2_init[3] = {(6378.137+400)*10.0^3.0, 0.0, 0.0};
  parameter units.Velocity v1_init[3]= {0.0, 0.0, 0.0};
  parameter units.Velocity v2_init[3] = {0.0, 7670, 0.0};
  
  units.Mass m1;
  units.Mass m2;
  Real mu;
  units.Length r1[3];
  units.Length r2[3];
  units.Length r1_2[3];
  units.Velocity v1[3];
  units.Velocity v2[3];
  units.Velocity v1_2[3];
  units.Acceleration a1[3];
  units.Acceleration a2[3];
  units.Acceleration a1_2[3];
  units.Force Fg1[3];
  units.Force Fg2[3];
  
  //---
  units.Length mag_r1;
  units.Length mag_r2;
  units.Length mag_r1_2;
  units.Length Alt;
  units.Velocity v1Abs;
  units.Velocity v2Abs;
  
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
    r1[i] = r1_init[i];
    r2[i] = r2_init[i];
    v1[i] = v1_init[i];
    v2[i] = v2_init[i];
    
  end for;
  
equation
  m1= m1_par;
  m2= m2_par;
  
  mu = Modelica.Constants.G*(m1 + m2);
  
  mag_r1 = (r1[1]^2 + r1[2]^2 + r1[3]^2)^(0.5);
  mag_r2 = (r2[1]^2 + r2[2]^2 + r2[3]^2)^(0.5);
  mag_r1_2 = (r1_2[1]^2 + r1_2[2]^2 + r1_2[3]^2)^(0.5);
  Alt= mag_r1_2 - rM1;
  v1Abs= (v1[1]^2 + v1[2]^2 + v1[3]^2 )^(0.5);
  v2Abs= (v2[1]^2 + v2[2]^2 + v2[3]^2 )^(0.5);
  //-----
  for i in 1:3 loop
    r1_2[i]= r2[i] - r1[i];
    v1_2[i]= v2[i] - v1[i];
    a1_2[i]= a2[i] - a1[i];
    
    der(r1[i]) = v1[i];
    der(r2[i]) = v2[i];
    der(v1[i]) = a1[i];
    der(v2[i]) = a2[i];
    
    Fg1[i]= Modelica.Constants.G*m1*m2/(mag_r1_2^3.0)*r1_2[i];
    Fg2[i]= Modelica.Constants.G*m1*m2/(mag_r1_2^3.0)*(-1.0)*r1_2[i];
    
    a1[i]= Fg1[i]/m1;
    a2[i]= Fg2[i]/m2;
    
  end for;
  
  
  annotation(
    experiment(StartTime = 0, StopTime = 7000, Tolerance = 1e-06, Interval = 5));
end TwoBodyOrbital00;
