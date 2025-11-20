// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EventHistoryTest {
    // 注意：'indexed' 关键字允许我们通过该字段进行搜索过滤
    event DataChanged(address indexed sender, uint256 newValue, string message);

    function updateData(uint256 _data, string calldata _message) public {
        emit DataChanged(msg.sender, _data, _message);
    }
}