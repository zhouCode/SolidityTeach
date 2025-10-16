// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Father{
    function LastName() public pure returns(string memory);
}

contract Mother{
    function FirstName() public pure returns(string memory);
}

contract Son is Father, Mother {
     function LastName() public pure returns(string memory){
         return "Jackson";
     }
     function FirstName() public pure returns(string memory){
         return "Mickle";
     }
}