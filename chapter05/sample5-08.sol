// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract modifierDemo{
    // 保存卖家的账户地址
    address seller;
    
    // 模拟商品上架。将调用此函数的账户地址赋值到seller中。
    function OnSell() public{
        seller = msg.sender;
    }

    //指定调用者必须是seller，否则抛出异常
    modifier OnlySeller(){
        require (msg.sender==seller, unicode"必须是卖家");
        _;
    }

    // 模拟商品下架, 指定调用者必须是seller，否则抛出异常。 
    function Abort() view public OnlySeller {
        
      //......
    } 
}
