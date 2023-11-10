// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Saldo {
    mapping(address => uint256) public balance;
    address[] public addressList;

    enum Estado {
        Iniciado,
        Finalizado
    }

    Estado public estadoDelContrato;

    constructor() {
        estadoDelContrato = Estado.Iniciado;

        balance[msg.sender] = 1000;
        addressList.push(msg.sender);

        estadoDelContrato = Estado.Finalizado;
    }

    function addBalance(address _address, uint256 cant) public {
        balance[_address] = balance[_address] + cant;
        if (!isAddressInList(_address)) {
            addressList.push(_address);
        }
    }

    function setBalance(address _address, uint256 _balance) public {
        balance[_address] = _balance;
        if (!isAddressInList(_address)) {
            addressList.push(_address);
        }
    }

    function isAddressInList(address _address) internal view returns (bool) {
        for (uint256 i = 0; i < addressList.length; i++) {
            if (addressList[i] == _address) {
                return true;
            }
        }
        return false;
    }

    function getAllBalances()
        public
        view
        returns (address[] memory, uint256[] memory, uint)
    {
        uint256[] memory balances = new uint256[](addressList.length);
        uint total = 0;
        for (uint256 i = 0; i < addressList.length; i++) {
            balances[i] = balance[addressList[i]];
            total = total + balance[addressList[i]];
        }
        return (addressList, balances, total);
    }
}
