// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 一个仅用于接收ETH的合约
contract Receiver {
    receive() external payable {}
}