// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Demo {
    function sum_for(uint _max) public pure returns (uint) {
        uint _i;
        uint _sum = 0;
        for (_i = 0; _i <= _max; _i++) {
            _sum += _i;
        }
        return _sum;
    }
}
