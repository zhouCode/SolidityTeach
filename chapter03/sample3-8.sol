// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Demo{
    uint[5] arr = [1,2,3,4,5];
    
    function sum_arr() public view returns(uint) {
        uint _i;
        uint _sum =0;

         for(_i=0;_i<arr.length;_i++){
             _sum += arr[_i]; 
         }
         return _sum;
    }
}
