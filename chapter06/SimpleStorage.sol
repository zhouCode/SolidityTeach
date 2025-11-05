// SimpleStorage.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract SimpleStorage {
    uint public myNumber;

    // 构造函数，在部署时设置一个初始值
    constructor(uint _initialNumber) {
        myNumber = _initialNumber;
    }

    // 一个 "set" 函数来修改状态
    function set(uint _newNumber) public {
        myNumber = _newNumber;
    }

    // 一个 "get" 函数来读取状态
    function get() public view returns (uint) {
        return myNumber;
    }
}
