// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./math.sol";

contract TestMath {
    using Math for uint;
    function TestAdd() public pure returns(uint){

        uint a = 1;
        return a.add(2);
    }
    function TestMinus() public pure returns(uint){

        uint a = 10;
        return a.minus(2);
    }
    function TestMultiple() public pure returns(uint){

        uint a = 10;
        return a.multiple(2);
    }
    function TestDivide() public pure returns(uint){

        uint a = 10;
        return a.divide(2);
    }    
}
