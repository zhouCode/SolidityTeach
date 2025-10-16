// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract selfdestructDemo{
    constructor() payable {

    }

    function kill(address payable _add) public {
        selfdestruct(_add);
    }
}
