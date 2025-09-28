// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
//声明合约
contract Demo{
    function sum_break(uint _max) public pure returns(uint) {
        uint _i=0;
        uint _sum =0;
         while(true){
             if(_i>_max)
                  break;
             _sum += _i;
             _i++;
         }
         return _sum;
    }
}
