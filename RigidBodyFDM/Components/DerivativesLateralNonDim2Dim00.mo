within AircraftDynamics.RigidBodyFDM.Components;

model DerivativesLateralNonDim2Dim00
  
  //
  import AircraftDynamics;
  import units = Modelica.Units.SI;
  
  /* ---------------------------------------------
            Internal variables
    --------------------------------------------- */
  units.Velocity U1;
  units.Pressure q1bar;
  units.Angle theta1;
  units.Acceleration g;
  units.Area S;
  units.Mass m;
  units.MomentOfInertia Ixx;
  units.MomentOfInertia Izz;
  units.MomentOfInertia Ixz;
  units.Length b;
  //---
  units.MomentOfInertia I1;
  units.MomentOfInertia I2;
  
  //----------
  Real CYbeta;
  Real CYp;
  Real CYr;
  Real CYdeltaA;
  Real CYdeltaR;
  Real CYdeltaS;
  Real CYdeltaF;
  //---
  Real Clbeta;
  Real Clp;
  Real Clr;
  Real CldeltaA;
  Real CldeltaR;
  Real CldeltaS;
  Real CldeltaF;
  //---
  Real Cnbeta;
  Real Cnp;
  Real Cnr;
  Real CndeltaA;
  Real CndeltaR;
  Real CndeltaS;
  Real CndeltaF;
  //---
  //----------
  Real Ybeta(unit = "m/s2", displayUnit = "m/s2");
  Real Yp(unit = "m/s2", displayUnit = "m/s2");
  Real Yr(unit = "m/s", displayUnit = "m/s");
  Real YdeltaA(unit = "m/s2", displayUnit = "m/s2");
  Real YdeltaR(unit = "m/s2", displayUnit = "m/s2");
  Real YdeltaS(unit = "m/s2", displayUnit = "m/s2");
  Real YdeltaF(unit = "m/s2", displayUnit = "m/s2");
  //---
  Real Ybeta_pri;
  Real Yp_pri;
  Real Yr_pri;
  Real Yphi_pri;
  Real YdeltaA_pri;
  Real YdeltaR_pri;
  Real YdeltaS_pri;
  Real YdeltaF_pri;
  //---
  Real Lbeta(unit = "1/s2", displayUnit = "1/s2");
  Real Lp(unit = "1/s", displayUnit = "1/s");
  Real Lr(unit = "1/s", displayUnit = "1/s");
  Real LdeltaA(unit = "1/s2", displayUnit = "1/s2");
  Real LdeltaR(unit = "1/s2", displayUnit = "1/s2");
  Real LdeltaS(unit = "1/s2", displayUnit = "1/s2");
  Real LdeltaF(unit = "1/s2", displayUnit = "1/s2");
  //---
  Real Lbeta_pri;
  Real Lp_pri;
  Real Lr_pri;
  Real LdeltaA_pri;
  Real LdeltaR_pri;
  Real LdeltaS_pri;
  Real LdeltaF_pri;
  //---
  Real Nbeta;
  Real Np;
  Real Nr;
  Real NdeltaA;
  Real NdeltaR;
  Real NdeltaS;
  Real NdeltaF;
  //---
  Real Nbeta_pri;
  Real Np_pri;
  Real Nr_pri;
  Real NdeltaA_pri;
  Real NdeltaR_pri;
  Real NdeltaS_pri;
  Real NdeltaF_pri;
  //---
  //----------
  Real Ybeta_ppri;
  Real Yp_ppri;
  Real Yr_ppri;
  Real Yphi_ppri;
  Real YdeltaA_ppri;
  Real YdeltaR_ppri;
  Real YdeltaS_ppri;
  Real YdeltaF_ppri;
  //-----
  
  /* ---------------------------------------------
                Interface
      --------------------------------------------- */
  AircraftDynamics.Types.InfoBus infoBusAircraft annotation(
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus infoBusNonDim annotation(
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus infoBusDim annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Types.InfoBus infoBusFlt annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //********************************************************************************
equation
/* ---------------------------------------------
  Connections, interface <-> internal variables
  --------------------------------------------- */
//***** flight condition *****
  connect(U1, infoBusFlt.U1);
  connect(q1bar, infoBusFlt.q1bar);
  connect(theta1, infoBusFlt.theta1);
  connect(g, infoBusFlt.g);
//***** aircraft characteristics *****
  connect(S, infoBusAircraft.S);
  connect(m, infoBusAircraft.m);
  connect(Ixx, infoBusAircraft.Ixx);
  connect(Izz, infoBusAircraft.Izz);
  connect(Ixz, infoBusAircraft.Ixz);
  connect(b, infoBusAircraft.b);
//-----
//***** Non-dimentional coefficients/derivatives *****
  connect(CYbeta, infoBusNonDim.CYbeta);
  connect(CYp, infoBusNonDim.CYp);
  connect(CYr, infoBusNonDim.CYr);
  connect(CYdeltaA, infoBusNonDim.CYdeltaA);
  connect(CYdeltaR, infoBusNonDim.CYdeltaR);
  connect(CYdeltaS, infoBusNonDim.CYdeltaS);
  connect(CYdeltaF, infoBusNonDim.CYdeltaF);
//---
  connect(Clbeta, infoBusNonDim.Clbeta);
  connect(Clp, infoBusNonDim.Clp);
  connect(Clr, infoBusNonDim.Clr);
  connect(CldeltaA, infoBusNonDim.CldeltaA);
  connect(CldeltaR, infoBusNonDim.CldeltaR);
  connect(CldeltaS, infoBusNonDim.CldeltaS);
  connect(CldeltaF, infoBusNonDim.CldeltaF);
//---
  connect(Cnbeta, infoBusNonDim.Cnbeta);
  connect(Cnp, infoBusNonDim.Cnp);
  connect(Cnr, infoBusNonDim.Cnr);
  connect(CndeltaA, infoBusNonDim.CndeltaA);
  connect(CndeltaR, infoBusNonDim.CndeltaR);
  connect(CndeltaS, infoBusNonDim.CndeltaS);
  connect(CndeltaF, infoBusNonDim.CndeltaF);
//-----
//***** Dimentional derivatives *****
  connect(Ybeta, infoBusDim.Ybeta);
  connect(Yp, infoBusDim.Yp);
  connect(Yr, infoBusDim.Yr);
  connect(YdeltaA, infoBusDim.YdeltaA);
  connect(YdeltaR, infoBusDim.YdeltaR);
  connect(YdeltaS, infoBusDim.YdeltaS);
  connect(YdeltaF, infoBusDim.YdeltaF);
//---
  connect(Ybeta_pri, infoBusDim.Ybeta_pri);
  connect(Yp_pri, infoBusDim.Yp_pri);
  connect(Yr_pri, infoBusDim.Yr_pri);
  connect(Yphi_pri, infoBusDim.Yphi_pri);
  connect(YdeltaA_pri, infoBusDim.YdeltaA_pri);
  connect(YdeltaR_pri, infoBusDim.YdeltaR_pri);
  connect(YdeltaS_pri, infoBusDim.YdeltaS_pri);
  connect(YdeltaF_pri, infoBusDim.YdeltaF_pri);
//---
  connect(Lbeta, infoBusDim.Lbeta);
  connect(Lp, infoBusDim.Lp);
  connect(Lr, infoBusDim.Lr);
  connect(LdeltaA, infoBusDim.LdeltaA);
  connect(LdeltaR, infoBusDim.LdeltaR);
  connect(LdeltaS, infoBusDim.LdeltaS);
  connect(LdeltaF, infoBusDim.LdeltaF);
//---
  connect(Lbeta_pri, infoBusDim.Lbeta_pri);
  connect(Lp_pri, infoBusDim.Lp_pri);
  connect(Lr, infoBusDim.Lr_pri);
  connect(LdeltaA_pri, infoBusDim.LdeltaA_pri);
  connect(LdeltaR_pri, infoBusDim.LdeltaR_pri);
  connect(LdeltaS_pri, infoBusDim.LdeltaS_pri);
  connect(LdeltaF_pri, infoBusDim.LdeltaF_pri);
//---
  connect(Nbeta, infoBusDim.Nbeta);
  connect(Np, infoBusDim.Np);
  connect(Nr, infoBusDim.Nr);
  connect(NdeltaA, infoBusDim.NdeltaA);
  connect(NdeltaR, infoBusDim.NdeltaR);
  connect(NdeltaS, infoBusDim.NdeltaS);
  connect(NdeltaF, infoBusDim.NdeltaF);
//---
  connect(Nbeta_pri, infoBusDim.Nbeta_pri);
  connect(Np_pri, infoBusDim.Np_pri);
  connect(Nr, infoBusDim.Nr_pri);
  connect(NdeltaA_pri, infoBusDim.NdeltaA_pri);
  connect(NdeltaR_pri, infoBusDim.NdeltaR_pri);
  connect(NdeltaS_pri, infoBusDim.NdeltaS_pri);
  connect(NdeltaF_pri, infoBusDim.NdeltaF_pri);
  //---
  //----------
  connect(Ybeta_ppri, infoBusDim.Ybeta_ppri);
  connect(Yp_ppri, infoBusDim.Yp_ppri);
  connect(Yr_ppri, infoBusDim.Yr_ppri);
  connect(Yphi_ppri, infoBusDim.Yphi_ppri);
  connect(YdeltaA_ppri, infoBusDim.YdeltaA_ppri);
  connect(YdeltaR_ppri, infoBusDim.YdeltaR_ppri);
  connect(YdeltaS_ppri, infoBusDim.YdeltaS_ppri);
  connect(YdeltaF_ppri, infoBusDim.YdeltaF_ppri);
  //---
  
/* ---------------------------------------------
  Eqns describing physics
  --------------------------------------------- */
  I1= Ixz/Ixx;
  I2= Ixz/Izz;
//-----
  Ybeta= (q1bar*S*CYbeta)/m;
  Yp= (q1bar*S*CYp*b)/(m*2.0*U1);
  Yr= (q1bar*S*CYr*b)/(m*2.0*U1);
  YdeltaA= (q1bar*S*CYdeltaA)/m;
  YdeltaR= (q1bar*S*CYdeltaR)/m;
  YdeltaS= (q1bar*S*CYdeltaS)/m;
  YdeltaF= (q1bar*S*CYdeltaF)/m;
//---
  Ybeta_pri= Ybeta/U1;
  Yp_pri= Yp/U1;
  Yr_pri= (Yr - U1)/U1;
  Yphi_pri= g*cos(theta1)/U1;
  YdeltaA_pri= YdeltaA/U1;
  YdeltaR_pri= YdeltaR/U1;
  YdeltaS_pri= YdeltaS/U1;
  YdeltaF_pri= YdeltaF/U1;
  //---
  Lbeta= (q1bar*S*Clbeta*b)/Ixx;
  Lp= (q1bar*S*b*Clp*b)/(Ixx*2.0*U1);
  Lr= (q1bar*S*b*Clr*b)/(Ixx*2.0*U1);
  LdeltaA= (q1bar*S*CldeltaA*b)/Ixx;
  LdeltaR= (q1bar*S*CldeltaR*b)/Ixx;
  LdeltaS= (q1bar*S*CldeltaS*b)/Ixx;
  LdeltaF= (q1bar*S*CldeltaS*b)/Ixx;
  //---
  Lbeta_pri= (Lbeta + I1*Nbeta)/(1.0 - I1*I2);
  Lp_pri= (Lp + I1*Np)/(1.0 - I1*I2);
  Lr_pri= (Lr + I1*Nr)/(1.0 - I1*I2);
  LdeltaA_pri= (LdeltaA + I1*NdeltaA)/(1.0 - I1*I2);
  LdeltaR_pri= (LdeltaR + I1*NdeltaR)/(1.0 - I1*I2);
  LdeltaS_pri= (LdeltaS + I1*NdeltaS)/(1.0 - I1*I2);
  LdeltaF_pri= (LdeltaF + I1*NdeltaF)/(1.0 - I1*I2);
  //---
  Nbeta= (q1bar*S*Cnbeta*b)/Izz;
  Np= (q1bar*S*b*Cnp*b)/(Izz*2.0*U1);
  Nr= (q1bar*S*b*Cnr*b)/(Izz*2.0*U1);
  NdeltaA= (q1bar*S*CndeltaA*b)/Izz;
  NdeltaR= (q1bar*S*CndeltaR*b)/Izz;
  NdeltaS= (q1bar*S*CndeltaS*b)/Izz;
  NdeltaF= (q1bar*S*CndeltaF*b)/Izz;
  //---
  Nbeta_pri= (I2*Lbeta + Nbeta)/(1.0 - I1*I2);
  Np_pri= (I2*Lp + Np)/(1.0 - I1*I2);
  Nr_pri= (I2*Lr + Nr)/(1.0 - I1*I2);
  NdeltaA_pri= (I2*LdeltaA + NdeltaA)/(1.0 - I1*I2);
  NdeltaR_pri= (I2*LdeltaR + NdeltaR)/(1.0 - I1*I2);
  NdeltaS_pri= (I2*LdeltaS + NdeltaS)/(1.0 - I1*I2);
  NdeltaF_pri= (I2*LdeltaF + NdeltaF)/(1.0 - I1*I2);
  //---
  //----------
  Ybeta_ppri= Ybeta_pri*U1;
  Yp_ppri= Yp_pri*U1;
  Yr_ppri= U1*(Yr_pri+1.0);
  Yphi_ppri= Yphi_pri*U1;
  YdeltaA_ppri= YdeltaA_pri*U1;
  YdeltaR_ppri= YdeltaR_pri*U1;
  YdeltaS_ppri= YdeltaS_pri*U1;
  YdeltaF_ppri= YdeltaF_pri*U1;
  //---
  
/********************************************************
  Graphics
********************************************************/
  annotation(
    defaultComponentName = "DerLateral",
    Diagram,
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-87, -69}, extent = {{-11, 3}, {23, -7}}, textString = "NonDim."), Text(origin = {75, -9}, extent = {{1, 3}, {23, -7}}, textString = "Dim."), Text(origin = {0, -90}, extent = {{-100, 10}, {100, -10}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
end DerivativesLateralNonDim2Dim00;
