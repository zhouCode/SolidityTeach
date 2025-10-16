// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//声明合约
contract Demo {
    function swap(uint _x, uint _y) public pure returns (uint, uint) {
        return (_y, _x);
    }
}
