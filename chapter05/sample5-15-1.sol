// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.20;

abstract contract Pet {
    function cry(string memory _sound) public virtual returns (string memory);
}

// Cat合约现在正确地实现了Pet接口
contract Cat is Pet {
    // 为了遵守接口，函数签名必须完全匹配
    // 'external' 的接口可以用 'public' 或 'external' 来实现
    function cry(string memory _sound) public override returns (string memory){
        // 在这里可以添加具体逻辑，比如发出一个事件
        // emit Crying(_sound);
        // 注意：因为接口规定没有返回值，所以这里也不能有返回值
    }
}