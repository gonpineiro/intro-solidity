// SPDX-License-Identifier: GPL-3.0

/**
function <name>(<type> <parameter>..., [..., ]>) 
    <access modifiers>      public|private|internal|external
    <mutability modifiers>  view|pure
    <user defined modifiers> 
    <returns>(<type>) {
        <content>
    }

    ● public: son accesibles desde todo ámbito posible.
    ● private: solo son accesibles desde el mismo contrato.
    ● internal: solo son accesibles desde el mismo contrato y sus contratos derivados.
    ● external: solo accesibles desde fuera del contrato.

    ● view: indica que la función es de sólo lectura y no modifica el estado del contrato.
    ● pure: indica que no se accede a ningún valor del estado del contrato (o sea sus variables).
 */

pragma solidity >=0.7.0 <0.9.0;

contract Funciones {
    function Suma(uint numero1, uint numero2) public pure returns (uint) {
        return sumaInterna(numero1, numero2);
    }

    function sumaInterna(
        uint numero1,
        uint numero2
    ) private pure returns (uint) {
        return numero1 + numero2;
    }

    uint private resultado;

    function ObtenerResultado() public view returns (uint) {
        return resultado;
    }
}
