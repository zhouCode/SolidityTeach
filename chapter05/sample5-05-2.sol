// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OnlineStore {
    address public owner; // 用来记录合约的拥有者

    // 事件：用来在日志中记录购买成功
    event ThingBought(address indexed buyer, uint256 amount);

    // 构造函数：在部署合约时，将部署者设为 owner
    constructor() {
        owner = msg.sender;
    }

    // 外部调用的购买函数
    function buySomething() external payable {
        // 检查价格是否正确
        require(msg.value == 0.001 ether, "Incorrect amount sent.");
        
        // 调用内部的 "转移物品" 函数
        _transferThing(msg.sender);
    }

    // 内部函数，模拟转移物品的动作
    function _transferThing(address _buyer) internal {
        // 实际上我们不转移任何东西，只是发出一个事件来证明函数被调用了
        emit ThingBought(_buyer, 0.001 ether);
    }

    // 允许合约拥有者把合约里的钱取走
    function withdraw() external {
        // 确保只有 owner 才能调用
        require(msg.sender == owner, "You are not the owner.");
        
        // 将合约的全部余额发送给 owner
        payable(owner).transfer(address(this).balance);
    }
}