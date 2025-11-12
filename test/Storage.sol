// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract Storage {
    uint public myNumber;
    constructor(uint _initialNumber) {
        myNumber = _initialNumber;
    }
    function store(uint _newNumber) public {
        myNumber = _newNumber;
    }
    function retrieve() public view returns (uint) {
        return myNumber;
    }
}