// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Purchase {
    string public name;
    uint public price;
    address payable public seller;

    // 旧版本的要求 (0.7.0 之前)：在旧版本的 Solidity 中，强制要求必须为构造函数指定可见性，通常就是 public。
    // 新版本的简化 (0.7.0 及之后)：Solidity 的开发者意识到，构造函数有一个非常特殊的性质：它只会在合约部署时被调用一次。
    // 这个“部署”动作本身就是从外部发起的，所以构造函数天生就是“公开”的。因此，再显式地写一个 public 就显得多余了。
    constructor(string memory _name, uint _price) {
        name = _name;
        price = _price;
        // 必须显式声明此地址是 payable 的，因为 seller 是 payable
        seller = payable(msg.sender);
    }
}
