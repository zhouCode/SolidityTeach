// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library Math {
    function add(uint _x, uint _y) public pure returns(uint){
        return _x+_y;
    }
    function minus(uint _x, uint _y) public pure returns(uint){
        return _x-_y;
    }
    function multiple(uint _x, uint _y) public pure returns(uint){
        return _x * _y;
    }
    function divide(uint _x, uint _y) public pure returns(uint){
        return _x / _y;
    }    
}
