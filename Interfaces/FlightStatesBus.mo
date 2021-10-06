within AircraftDynamics.Interfaces;

expandable connector FlightStatesBus
  extends Modelica.Icons.SignalBus;
  /********************************************************
                         Declaration
  ********************************************************/
  /* ---------------------------------------------
          Internal objects
  --------------------------------------------- */
  AircraftDynamics.Records.FlightStates fltStates;
  AircraftDynamics.Records.angles4display fltAng4disp;
  
  annotation (defaultComponentName="FltStatesBus");
  
  
end FlightStatesBus;
