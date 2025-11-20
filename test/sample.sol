// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 一个没有 receive 或 fallback 函数的合约

contract Receiver {

    // ... 空的 ...

}



contract Sender {

    bool public lastCallSuccess;



    function sendTo(address payable _to) public {

        (bool success, ) = _to.call{value: 1 ether}("");

        lastCallSuccess = success;

    }

}