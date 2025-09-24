// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Person{
    enum Sex { Male, Female}
    string name;
    uint age;
    Sex sex;
    
    function SetFemale() public {
        sex = Sex.Female;
    }
    function GetSex() public view returns(Sex){
        return sex;
    }
}