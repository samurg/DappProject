pragma solidity ^0.4.4;
/// contrato transporte
contract Transporte {
  uint private idTransporte; /// identificador del transporte
  uint private numeroAsientos; ///Numero de asientos que tendra el transporte
  Asiento[] private asientos; ///Array de asientos

  /// Constructor
  function Transporte(uint _idTransporte, uint _numeroAsientos) {
    idTransporte = _idTranporte;
    numeroAsientos = _numeroAsientos;
    inicializarAsientos();
  }
  ///Representacion de un asiento
  struct Asiento {
    address addressPersona; ///Representacion de la persona que contrata el viaje
    uint pagoTransporte;
    bool seguroContratado;
  }

  function getIdTransporte() internal constant return (uint){
    return idTransporte;
  }

  function getNumeroAsientos() internal constant return (uint){
    return numerAsientos;
  }

  function getAsientos() internal constant return (Asiento[]){
    return asientos;
  }
 ///Funcion que inicializa todos los asientos del transporte
  function inicializarAsientos() internal {
    for (uint i = 0; i < numeroAsientos; i++) {
      asientos.push(Asiento(
        {
          persona: 0x0000000000000000000000000000000000000000,
          pagoTranspote: 0,
          seguroContratado: false
        }));
    }
  }
  /// Funcion que modifica un asiento.
  ///Asigna a una "persona" un asiento
  ///param uint _numerAsiento
  function modificarAsiento(uint _numeroAsiento, bool _seguroContratado) payable return (bool) {
    require(_numeroAsiento >= 0 && _numeroAsiento < numeroAsientos);
    require(asientos[_numeroAsiento].addressPersona == 0x0000000000000000000000000000000000000000);
    asientos[_numeroAsiento].addressPersona = msg.sender;
    asientos[_numeroAsiento].pagoTransporte = msg.value;
    asientos[_numeroAsiento].seguroContratado = _seguroContratado;
    return true
  }

  function devolver(uint _numeroAsiento, bool _seguroContratado) returns (bool){
    require(adopters[_numeroAsiento].addressPersona == msg.sender);
    require(asientos[_numeroAsiento].seguroContratado == true);
    require(msg.sender.send(asientos[_numeroAsiento].pagoTransporte));
    asientos[_numeroAsiento].pagoTransporte = 0; // Para evitar doble devolucion
    return true;
  }

}
