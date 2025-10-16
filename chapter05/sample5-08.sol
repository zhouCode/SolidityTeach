// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract modifierDemo{
    address seller;
    
    
    modifier OnlySeller(){
        require (
            msg.sender==seller,
            unicode"必须是卖家"
        );
        _;
    }
    
    function OnSell() public{
        seller = msg.sender;
    }
 // 取消交易 
    function Abort() view public OnlySeller {
        
      //......
    } 
}
