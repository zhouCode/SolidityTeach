// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Solidity本身不支持浮点数 -> 没有float/double
// 多数语言的float有精度问题，例如: 0.1+0.2=0.30000000000000004
// 定点数: 核心思想是用整数来模拟
// 1 ETH = 10^18 Wei
contract FixedDemo{
    function testFixed() public pure returns (uint256, uint256){
        
    }
}
