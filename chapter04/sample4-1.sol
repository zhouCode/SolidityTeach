// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Demo {
    function assign(uint _a, uint _b) public pure returns (uint) {
        uint result = 10;
        result += _a * _b;
        return result;
    }
}
