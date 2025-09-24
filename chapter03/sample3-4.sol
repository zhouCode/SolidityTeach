// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Demo {
    // 数据类型(地址) 可见性修饰符(外部可见) 状态可变性修饰符(构造函数一次性赋值) 变量名
    address public immutable owner;
    // 构造函数，在合约部署时执行一次
    constructor() {
        owner = msg.sender;
    }
}