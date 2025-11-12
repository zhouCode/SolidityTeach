// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract Counter {
    uint public count = 0;
    function increment() public {
        count += 1;
    }
    function get() public view returns (uint) {
        return count;
    }
}
