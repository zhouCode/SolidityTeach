// --- 任务二：MyToken (请将三个合约复制到同一个 .sol 文件中) ---
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// TODO 1: 使用 ';;interface';; 关键字定义 IERC20
interface IERC20 {
    function balanceOf(address account) external view returns (uint);
    
    // TODO 2: 声明 transfer 函数签名
    // 提示：function transfer(address to, uint amount) external returns (bool);
    function transfer(address to, uint amount) external returns (bool);
}


// TODO 3: 使用 ';;abstract contract';; 关键字定义 TokenBase
abstract contract TokenBase is IERC20 { // TODO 4: 继承 IERC20
    
    mapping(address => uint) public balances;
    
    // 声明一个自定义错误
    error InsufficientBalance(uint requested, uint available);

    function balanceOf(address account) public view virtual override returns (uint) {
        return balances[account];
    }

    function transfer(address to, uint amount) public virtual override returns (bool) {
        uint fromBalance = balances[msg.sender];
        
        // TODO 5: 使用 revert 和自定义错误处理余额不足
        if (fromBalance < amount) {
            revert InsufficientBalance(amount, fromBalance);
        }

        balances[msg.sender] -= amount;
        balances[to] += amount;
        return true;
    }
}


// TODO 6: 使 MyToken 继承自 TokenBase
contract MyToken is TokenBase {

    // TODO 7: 补全 constructor，为部署者(msg.sender)铸造(mint) 1000 代币
    constructor() {
        balances[msg.sender] = 1000;
    }

    // TODO 8: 函数重载 - 版本一
    // 定义一个 approve 函数
    function approve(address spender, uint amount) public returns (bool) {
        // (在本实验中，我们省略 allowance 逻辑，只为演示重载)
        return true;
    }

    // TODO 9: 函数重载 - 版本二
    // 定义同名 approve 函数，但增加一个 string memory _note 参数
    function approve(address spender, uint amount, string memory _note) public returns (bool) {
        // (省略 _note 的处理逻辑)
        // 调用版本一的 approve 函数
        return this.approve(spender, amount);
    }
}
 