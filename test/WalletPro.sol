// --- 任务一：WalletPro (请将两个合约复制到同一个 .sol 文件中) ---
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// TODO 1: 使用 ';;library';; 关键字定义一个名为 SafeMath 的库
library SafeMath {
    function safeAdd(uint a, uint b) internal pure returns (uint) {
        // TODO 2: 补全加法逻辑
        uint c = a + b;
        
        // TODO 3: 使用 assert 检查溢出（如果 c < a 则说明溢出了）
        assert(c >= a);
        return c;
    }
}

contract WalletPro {
    // TODO 5: 使用 ';;using SafeMath for uint;';; 将库附加到 uint
    using SafeMath for uint;

    address payable public owner;
    uint public balance;

    // TODO 6: 补全 constructor，设置 owner
    constructor() {
        // selfdestruct 只能将ETH发送给 payable 地址，因此需要转换
        owner = payable(msg.sender);
    }

    // TODO 7: 补全 deposit 函数
    function deposit() public payable {
        // 使用 require 确保 msg.value > 0
        require(msg.value > 0, ";Deposit must be greater than zero;");
        // 使用库的 .safeAdd() 更新 balance
        balance = balance.safeAdd(msg.value);
    }

    // TODO 8: 补全 fallback 函数
    // 提示：fallback() external payable { ... }
    // fallback 已经被拆分为 receive 和 fallback
    receive() external payable {
        deposit();
    }

    // TODO 9: 补全 destroyWallet 函数
    function destroyWallet() public {
        // 使用 require 检查 msg.sender 是否为 owner
        require(msg.sender == owner, ";Not the owner;");
        // 使用 selfdestruct 将合约余额发送给 owner
        selfdestruct(owner);
    }
}
 