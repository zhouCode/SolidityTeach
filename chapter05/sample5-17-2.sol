// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title 错误处理演示
 * 这个合约模拟了一个“限量供应”的代币销售，用来演示三种错误处理。
 */
contract ErrorHandlingDemo {

    // --- 1. 自定义错误 (用于 revert) ---
    // (这是 0.8.4+ 的最佳实践，比 revert("string") 更省 Gas)
    // 错误：当库存不足时触发
    error InsufficientStock(uint requestedAmount, uint availableAmount);

    uint public totalSupply = 100;   // 总供应量 (我们的内部状态)
    uint public price = 1 ether;    // 价格
    mapping(address => uint) public balances; // 记录余额

    /**
     * @dev 购买代币的函数，演示了三种检查。
     */
    function purchase(uint _amount) public payable {
        
        // --- 2. "require" (守卫) ---
        // 用途：检查 *外部* 输入（来自用户的 _amount 和 msg.value）
        // 检查用户是否发送了正确的 ETH
        require(msg.value == _amount * price, "Error: Incorrect ETH amount sent");

        // --- 3. "revert" (手动撤销) ---
        // 用途：检查基于 *内部逻辑* 的复杂条件
        // 检查我们的库存是否足够
        if (_amount > totalSupply) {
            // 如果不够，我们“手动” revert 一个自定义错误
            revert InsufficientStock(_amount, totalSupply);
        }

        // --- 执行核心逻辑 ---
        uint oldTotalSupply = totalSupply; // 记录执行前的状态

        balances[msg.sender] += _amount;
        totalSupply -= _amount;
        
        // --- 4. "assert" (断言) ---
        // 用途：检查 *内部* 状态（不变量）是否被破坏
        // 检查：我们的会计记账是否正确？
        // 这个条件 *永远* 都应该是 true。如果它为 false，
        // 那就说明我们的代码有严重的内部 Bug (比如数学溢出或逻辑错误)。
        assert(totalSupply == oldTotalSupply - _amount);
        
        // (注：在 0.8.0+ 中，totalSupply -= _amount; 
        //  如果发生下溢(underflow)也会自动 revert，所以 assert 在这里
        //  更像是一种“双重保险”的逻辑验证)
    }
}