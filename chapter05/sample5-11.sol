// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract Overload {
    function func1() public pure returns(uint){
        return 0;
    }

    function func1(uint _a) public pure returns(uint) {
        return _a;
    }
}
