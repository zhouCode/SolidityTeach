// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
//声明合约
contract Demo{
string constant hellostring = "hello world!";
    function hello() public pure returns(string memory){
        return hellostring;
    }
}
