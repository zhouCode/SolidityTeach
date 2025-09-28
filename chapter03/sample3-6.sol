// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract StructDemo {
    //将所有属于同一个实体（如用户、书籍、产品）的数据捆绑在一起，让代码结构更清晰。
    // 简化数据传递 (Simplicity): 你可以轻松地在函数之间传递整个 User 对象，
    // 或者从一个函数返回整个 User 对象，而不需要传递或返回五个独立的变量。
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