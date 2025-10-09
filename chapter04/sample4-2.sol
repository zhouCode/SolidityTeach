// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
//声明合约
contract Demo {
    function hello(int _x) public pure returns (string memory) {
        if (_x == 0) {
          return unicode"参数_x等于0";
        }
        if (_x > 0) {
          return unicode"参数_x是正数。";
        } else {
          return unicode"参数_x是负数。";
        }
    }
}
