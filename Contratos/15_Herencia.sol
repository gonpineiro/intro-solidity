// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./16_Interface.sol";
import "./08_Modificadores.sol";

contract Herencia is Suma, Modificadores {
    constructor(string memory nombreNuevo) Modificadores(nombreNuevo) {}

    function sumar(
        uint numero1,
        uint numero2
    ) public view override EsOwner returns (uint) {
        return numero1 + numero2;
    }
}
