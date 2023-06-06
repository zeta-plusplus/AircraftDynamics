within AircraftDynamics.PtMassFDM.DoF3.Examples;

model ThreeBodyOrbital00
  extends Modelica.Icons.Example;
  import units = Modelica.Units.SI;
  
  
  parameter units.Length rM1 = 6378.137*10.0^3.0;
  parameter units.Mass m1_par = 5.972*10.0^(24.0) "default value is mass of the earch";
  parameter units.Mass m2_par = 7.34767309*10.0^(22.0) "default value is mass of the moon";
  parameter units.Mass m3_par = 68585 "default value is empty mass of space shuttle orbiter";
  parameter units.Length r1_init[3]= {0.0, 0.0, 0.0};
  
  parameter units.Length r2Abs_init= 384399*10.0^(3.0);
  parameter Real phi_r2_deg_init= -30.0;
  parameter Real phi_v2_deg_init= phi_r2_deg_init+90.0;
  parameter units.Velocity v2Abs_init= 1.022*10.0^(3.0);
  
  parameter units.Length r3_init[3] = {-1.0*(6378.137+400)*10.0^3.0, 0.0, 0.0};
  parameter units.Velocity v1_init[3]= {0.0, 0.0, 0.0};
  parameter units.Velocity v3_init[3] = {0.0, -10000.0, 0.0};
  
  units.Mass m1;
  units.Mass m2;
  units.Mass m3;
  
  units.Length r1[3];
  units.Length r2[3];
  units.Length r3[3];
  
  units.Length r1_3[3];
  units.Length r1_2[3];
  units.Length r2_3[3];
  
  units.Velocity v1[3];
  units.Velocity v2[3];
  units.Velocity v3[3];
  
  units.Velocity v1_3[3];
  units.Velocity v1_2[3];
  units.Velocity v2_3[3];
  
  units.Acceleration a1[3];
  units.Acceleration a2[3];
  units.Acceleration a3[3];
  
  units.Acceleration a1_3[3];
  units.Acceleration a1_2[3];
  units.Acceleration a2_3[3];
  
  units.Force Fg1_3[3];
  units.Force Fg3_1[3];
  
  units.Force Fg1_2[3];
  units.Force Fg2_1[3];
  
  units.Force Fg2_3[3];
  units.Force Fg3_2[3];
  
  //---
  units.Length mag_r1;
  units.Length mag_r2;
  units.Length mag_r3;
  
  units.Length mag_r1_3;
  units.Length mag_r1_2;
  units.Length mag_r2_3;
  
  units.Length Alt;
  
  units.Velocity v1Abs;
  units.Velocity v2Abs;
  units.Velocity v3Abs;
  
  units.Velocity v1_3Abs;
  units.Velocity v1_2Abs;
  units.Velocity v2_3Abs;
  
  units.Acceleration a1Abs;
  units.Acceleration a2Abs;
  units.Acceleration a3Abs;
  
  units.Acceleration a1_3Abs;
  units.Acceleration a1_2Abs;
  units.Acceleration a2_3Abs;
  
protected
  parameter units.Length r2_init[3](each fixed=false) annotation(
    HideResult = false);
  parameter units.Velocity v2_init[3](each fixed=false) annotation(
    HideResult = false);
  
  parameter units.Angle phi_r2_init= phi_r2_deg_init* Modelica.Constants.pi/180.0;
  parameter units.Angle phi_v2_init= phi_v2_deg_init* Modelica.Constants.pi/180.0;
  
  
initial equation
  
  r2_init[1]= r2Abs_init*cos(phi_r2_init);
  r2_init[2]= r2Abs_init*sin(phi_r2_init);
  r2_init[3]= 0.0;
  
  v2_init[1]= v2Abs_init*cos(phi_v2_init);
  v2_init[2]= v2Abs_init*sin(phi_v2_init);
  v2_init[3]= 0.0;
  
  for i in 1:3 loop
    r1[i] = r1_init[i];
    r2[i] = r2_init[i];
    r3[i] = r3_init[i];
    
    v1[i] = v1_init[i];
    v2[i] = v2_init[i];
    v3[i] = v3_init[i];
    
  end for;
  
equation
  m1= m1_par;
  m2= m2_par;
  m3= m3_par;
  
  mag_r1 = (r1[1]^2 + r1[2]^2 + r1[3]^2)^(0.5);
  mag_r2 = (r2[1]^2 + r2[2]^2 + r2[3]^2)^(0.5);
  mag_r3 = (r3[1]^2 + r3[2]^2 + r3[3]^2)^(0.5);
  
  mag_r1_3 = (r1_3[1]^2 + r1_3[2]^2 + r1_3[3]^2)^(0.5);
  mag_r1_2 = (r1_2[1]^2 + r1_2[2]^2 + r1_2[3]^2)^(0.5);
  mag_r2_3 = (r2_3[1]^2 + r2_3[2]^2 + r2_3[3]^2)^(0.5);
  
  Alt= mag_r1_3 - rM1;
  
  v1Abs= (v1[1]^2 + v1[2]^2 + v1[3]^2 )^(0.5);
  v2Abs= (v2[1]^2 + v2[2]^2 + v2[3]^2 )^(0.5);
  v3Abs= (v3[1]^2 + v3[2]^2 + v3[3]^2 )^(0.5);
  
  v1_3Abs= (v1_3[1]^2 + v1_3[2]^2 + v1_3[3]^2 )^(0.5);
  v1_2Abs= (v1_2[1]^2 + v1_2[2]^2 + v1_2[3]^2 )^(0.5);
  v2_3Abs= (v2_3[1]^2 + v2_3[2]^2 + v2_3[3]^2 )^(0.5);
  
  a1Abs= (a1[1]^2 + a1[2]^2 + a1[3]^2 )^(0.5);
  a2Abs= (a2[1]^2 + a2[2]^2 + a2[3]^2 )^(0.5);
  a3Abs= (a3[1]^2 + a3[2]^2 + a3[3]^2 )^(0.5);
  
  a1_3Abs= (a1_3[1]^2 + a1_3[2]^2 + a1_3[3]^2 )^(0.5);
  a1_2Abs= (a1_2[1]^2 + a1_2[2]^2 + a1_2[3]^2 )^(0.5);
  a2_3Abs= (a2_3[1]^2 + a2_3[2]^2 + a2_3[3]^2 )^(0.5);
  
  //-----
  for i in 1:3 loop
    r1_3[i]= r3[i] - r1[i];
    r1_2[i]= r2[i] - r1[i];
    r2_3[i]= r3[i] - r2[i];
    
    v1_3[i]= v3[i] - v1[i];
    v1_2[i]= v2[i] - v1[i];
    v2_3[i]= v3[i] - v2[i];
    
    a1_3[i]= a3[i] - a1[i];
    a1_2[i]= a2[i] - a1[i];
    a2_3[i]= a3[i] - a2[i];
    
    der(r1[i]) = v1[i];
    der(r2[i]) = v2[i];
    der(r3[i]) = v3[i];
    
    der(v1[i]) = a1[i];
    der(v2[i]) = a2[i];
    der(v3[i]) = a3[i];
    
    Fg1_3[i]= Modelica.Constants.G*m1*m3/(mag_r1_3^3.0)*r1_3[i];
    Fg3_1[i]= Modelica.Constants.G*m1*m3/(mag_r1_3^3.0)*(-1.0)*r1_3[i];
    
    Fg1_2[i]= Modelica.Constants.G*m1*m2/(mag_r1_2^3.0)*r1_2[i];
    Fg2_1[i]= Modelica.Constants.G*m1*m2/(mag_r1_2^3.0)*(-1.0)*r1_2[i];
    
    Fg3_2[i]= Modelica.Constants.G*m2*m3/(mag_r2_3^3.0)*r2_3[i];
    Fg2_3[i]= Modelica.Constants.G*m2*m3/(mag_r2_3^3.0)*(-1.0)*r2_3[i];
    
    
    a3[i]= (Fg3_1[i] + Fg3_2[i])/m3;
    
    //a2[i]= (Fg2_1[i] + Fg2_3[i])/m2;
    a2[i]= (Fg2_1[i])/m2;
    //a1[i]= (Fg1_3[i] + Fg1_2[i])/m1;
    a1[i]=0.0;
    
  end for;
  
  
  annotation(
    experiment(StartTime = 0, StopTime = 3600, Tolerance = 1e-06, Interval = 5));
end ThreeBodyOrbital00;
