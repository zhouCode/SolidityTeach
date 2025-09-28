// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
//声明合约
contract Demo{
    function sum_dowhile(uint _max) public pure returns(uint) {
        uint _i=1;
        uint _sum =0;
        do {
             _sum += _i;
             _i++;
         } while(_i<=_max);
         return _sum;
    }
}
