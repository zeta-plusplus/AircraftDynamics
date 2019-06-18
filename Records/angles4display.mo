within AircraftDynamics.Records;

record angles4display
  extends Modelica.Icons.Record;
  /*-------------------------
  -------------------------*/
  Modelica.SIunits.Angle alpha "angle of attack";
  Modelica.SIunits.Angle gamma "flight path angle";
  Modelica.SIunits.Angle beta "sideslip angle";
  
  /*-------------------------
  -------------------------*/
  Modelica.SIunits.Angle theta "pitch angle";
  Modelica.SIunits.Angle phi "bank angle";
  Modelica.SIunits.Angle psi "heading angle";
  
end angles4display;
