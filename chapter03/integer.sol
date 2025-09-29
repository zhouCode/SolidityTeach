// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    uint8 public myNumber = 255;

    function add() public {
        // 在 Solidity 0.8+ 中，这行代码会失败并回滚交易
        // 因为 255 + 1 会导致 uint8 上溢
        myNumber = myNumber + 1; 
    }
    // function divide() public returns(uint){
    //     // 整数除法，向下取整
    //     uint a = 5;
    //     uint b = 2;
    //     uint result = a / b; // result 的结果是 2, 而不是 2.5
    //     return result;
    // }
}