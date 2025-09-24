// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Demo{
    function GetStringLength(string memory _s) public pure returns(uint){
        return bytes(_s).length;
    }
}
