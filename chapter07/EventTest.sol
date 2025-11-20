// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EventTest {
    // 定义事件
    // indexed 允许前端通过该字段过滤日志 (如：只监听特定用户的操作)
    event DataChanged(address indexed sender, uint256 newValue, string message);

    uint256 public data;
    string public message;

    // 触发事件的函数
    function updateData(uint256 _data, string calldata _message) public {
        data = _data;
        message = _message;
        
        // 触发事件，将数据写入区块链日志
        emit DataChanged(msg.sender, _data, _message);
    }
}