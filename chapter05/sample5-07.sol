// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * 权限控制
 */
contract ModifierDemo {
  address public owner = msg.sender;

  //检查必须是合约的所有者
  modifier onlyOwner {
    require (
        msg.sender == owner,
        unicode"必须是合约的所有者"
    );
    _;
  }

  // 改变合约的拥有者身份
  // newOwner是新所有者的地址
  function changeOwner(address _newOwner) public onlyOwner {
    owner = _newOwner;
  }
}
