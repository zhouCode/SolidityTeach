// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
//声明合约
contract Demo{
    function sum_even(uint _max) public pure returns(uint) {
        uint _i;
        uint _sum =0;
         for(_i=1;_i<=_max;_i++){
              if(_i%2 == 1)
                  continue;
             _sum += _i; 
         }
         return _sum;
    }
}
