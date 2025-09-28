// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Demo {
    // 地址 可见性修饰符(外部可见) 状态可变性修饰符(构造函数一次性赋值) 变量名
    address public immutable _owner;
    // 地址：一个唯一的 20 字节（160 位） 的值
    // 两种地址类型
    /* 普通的地址类型，可以查询余额，可以向他发送ERC20代币，
    但是不能直接通过.tansfer()或.send()发送以太币(ETH)*/
    address owner2;
    /*特殊的、被标记为“可支付”的地址类型，继承了address的所有功能，
    并额外拥有了接受ETH的能力*/
    address payable owner3;

    // 构造函数，在合约部署时执行一次
    constructor() {
        _owner = msg.sender;
    }
    function GetOwner() public view returns(address){
        return _owner;
    }
    function getBalance() public view returns (uint256) {
        return address(_owner).balance;
    }
}