// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// 0.3.2
// a = 1 + 1;
// 0.5.1
// a = 1.add(1);
// 0.8.0
// a = add(1,1);

// a=1+2; -编译器-> 01101011 -EVM(✅windows?Linux?)-> 3;

// EVM 0.1
// a=1+1;   b=2-1;
// EVM 0.2
// c=1*2;   d=6/5;
// EVM 1.0
// e=6^7;
// opcode

contract Demo{
    function hello() public pure returns(string memory){
        return "hello world!";
    }
}
