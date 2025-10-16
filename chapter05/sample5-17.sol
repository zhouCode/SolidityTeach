// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract VendingMachine {
   function buy(uint amount) public payable {
       if (amount > msg.value / 2 ether)
          revert(unicode"没有支付足够的以太币。");
        // 执行支付
     }
}
