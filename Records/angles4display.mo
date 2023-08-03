within AircraftDynamics.Records;

record angles4display
  extends Modelica.Icons.Record;
  
  import units= Modelica.Units.SI;
  /*-------------------------
  -------------------------*/
  units.Angle alpha "angle of attack";
  units.Angle gamma "flight path angle";
  units.Angle beta "sideslip angle";
  
  /*-------------------------
  -------------------------*/
  units.Angle theta "pitch angle";
  units.Angle phi "bank angle";
  units.Angle psi "heading angle";
  
end angles4display;
