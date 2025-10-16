// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Animal {
    string public name;
    uint public price;
    uint internal age;
    address internal owner;

    function setName(string memory _name) public {
        name = _name;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function setPrice(uint _price) public {
        price = _price;
    }

    function getPrice() public view returns (uint) {
        return price;
    }

    function buy() public {
        owner = msg.sender;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}

contract Dog is Animal {
    function setAge(uint _age) public {
        age = _age;
    }

    function getAge() public view returns (uint) {
        return age;
    }
}
