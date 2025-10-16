// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PayDemo {
    // 错误: 0x1472... 是一个 address, 但 account1 需要 address payable
    // address payable account1 = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C;
    // 正确: 使用 payable() 显式转换  0.8.0之后
    address payable account1 = payable(0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C);

    function pay() public payable {
        account1.transfer(msg.value);
    }

    function getAccount1Balance() public view returns (uint) {
        return account1.balance;
    }

    // 读取合约发起方的余额
    function getOwnerBalance() public view returns (uint) {
        address Owner = msg.sender;
        return Owner.balance;
    }
}
