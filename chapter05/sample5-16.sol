// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract Father{
    function LastName() public pure virtual returns(string memory);
}

abstract contract Mother{
    function FirstName() public pure virtual returns(string memory);
}

contract Son is Father, Mother {
     function LastName() public pure override returns(string memory){
         return "Jackson";
     }
     function FirstName() public pure override returns(string memory){
         return "Mickle";
     }
}