// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ParameterDemo {
    string s = "test";

    function SetString(string storage _str) internal {
        bytes(_str)[0] = "T";
    }
    function SetStrTest() public returns (string memory) {
        SetString(s);
        return s;
    }
    function GetS() public view returns (string memory) {
        return s;
    }
}
