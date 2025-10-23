// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title OwnerFundableContract
 * @dev 一个允许合约拥有者存入和取出以太币的合约。
 */
contract OwnerFundableContract {

    // 状态变量，用于存储合约拥有者的地址
    // `public` 关键字会自动创建一个名为 `owner` 的 getter 函数
    address public owner;

    /**
     * @dev 构造函数在合约部署时仅执行一次。
     * 它会将部署合约的账户地址设置为拥有者。
     */
    constructor() {
        owner = msg.sender;
    }

    /**
     * @notice 允许合约拥有者向该合约存入以太币。
     * @dev 调用者必须是合约的拥有者。
     * 此函数必须与以太币一起调用（即 `msg.value` > 0）。
     */
    function deposit() public payable {
        // require 语句进行身份验证：确保调用此函数的是拥有者
        require(msg.sender == owner, "Only the owner can deposit funds.");
        // 函数体可以为空，因为接收以太币的动作由 `payable` 关键字自动处理。
    }

    /**
     * @notice 允许合约拥有者从合约中取出指定数量的以太币。
     * @param _amount 需要取出的以太币数量（单位：wei）。
     */
    function withdraw(uint256 _amount) public {
        // 身份验证：确保只有拥有者才能取款
        require(msg.sender == owner, "Only the owner can withdraw funds.");
        
        // 余额检查：确保合约中有足够的资金可供取出
        require(address(this).balance >= _amount, "Insufficient contract balance.");

        // 执行转账：使用 .call 方法，这是当前推荐的最安全的方式
        // 它比 .transfer() 和 .send() 更灵活，可以防止重入攻击的某些变种
        (bool success, ) = owner.call{value: _amount}("");
        require(success, "Transfer failed.");
    }

    /**
     * @notice 查询合约当前的以太币余额。
     * @return 返回合约的余额（单位：wei）。
     */
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @dev 接收以太币的备用函数 (Receive Function)。
     * 如果拥有者直接向合约地址发送以太币（不调用任何函数），
     * 此函数将被触发，从而允许合约接收这笔资金。
     */
    receive() external payable {
        // 同样进行身份验证，确保只有拥有者的直接转账才被接受
        require(msg.sender == owner, "Only the owner can send Ether directly.");
    }
}