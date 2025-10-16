// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.20;

//声明合约
contract A{
    uint public data=10;
}

contract B is A{
    function getValue() public returns(uint){
       A a = new A();
       return a.data();
    }
}
