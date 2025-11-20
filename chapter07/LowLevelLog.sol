// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LowLevelLog {
    // 标准定义的事件，用于对比
    event Transfer(address indexed from, address indexed to, uint256 amount);

    // 1. 标准写法 (High-Level)
    function standardEmit(address _to, uint256 _amount) public {
        emit Transfer(msg.sender, _to, _amount);
    }

    // 2. 底层写法 (Low-Level Assembly)
    // 这与 standardEmit 的效果完全一致，但更节省 Gas (如果你手动优化得好的话)
    function rawLog3(address _to, uint256 _amount) public {
        // 准备 Topic 0: 事件签名的 Keccak256 哈希
        //  keccak256('Transfer(address,address,uint256)')
        bytes32 topic0 = keccak256("Transfer(address,address,uint256)");

        // 准备 Topic 1: 发送者地址 (需转为 bytes32)
        bytes32 topic1 = bytes32(uint256(uint160(msg.sender)));

        // 准备 Topic 2: 接收者地址 (需转为 bytes32)
        bytes32 topic2 = bytes32(uint256(uint160(_to)));

        assembly {
            // --- 步骤 A: 准备数据 (Data) ---
            // 也就是事件中 "没有 indexed" 的参数，这里是 _amount
            
            // 获取空闲内存指针
            let ptr := mload(0x40)
            
            // 将 _amount 存入内存
            mstore(ptr, _amount)

            // --- 步骤 B: 触发日志 (Log) ---
            // log3(内存指针, 数据长度, topic0, topic1, topic2)
            // 长度是 32 字节 (因为 uint256 占 32 字节)
            log3(ptr, 32, topic0, topic1, topic2)
        }
    }
}