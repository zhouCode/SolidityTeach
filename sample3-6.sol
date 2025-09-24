// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract StructDemo {
    struct Book {
        string Name;
        string Publisher;
        uint Pagecount;
        uint Price;
    }

    // Use `unicode` prefix for strings with non-ASCII characters
    Book b = Book(
        unicode"以太坊Solidity语言智能合约设计与开发",
        unicode"人民邮电出版社",
        350,
        38
    );

    function getName() view public returns (string memory) {
        return b.Name;
    }

    function getPublisher() view public returns (string memory) {
        return b.Publisher;
    }

    function getPagecount() view public returns (uint) {
        return b.Pagecount;
    }

    function getPrice() view public returns (uint) {
        return b.Price;
    }
}