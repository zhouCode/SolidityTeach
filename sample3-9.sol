// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract arrDemo{
    uint[] arr;
    
    function push(uint _a) public {
       arr.push(_a);
    }
    
    function length() public view returns(uint){
        return arr.length;
    }
    
    function pop() public returns(uint){
        arr.pop();
       return (arr.length);
    }
}
