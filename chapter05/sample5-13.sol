// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ExecuteFallback {
    function callNonExistFunc() public returns (bool) {
        bytes memory funcIdentifier = abi.encodeWithSignature("functionNotExist()");
        // address(this).call(...) 会调用合约自己
        // 因为 "functionNotExist()" 不存在，它会触发 fallback 函数
        (bool success, bytes memory returnData) = address(this).call(funcIdentifier);
        return success;
    }
    //Fallback事件，会把调用的数据打印出来
    event FallbackCalled(bytes data);
    
    // 旧版中 fallback 函数，是没有名字的，没有参数，没有返回值的
    // function() external{
    //   emit FallbackCalled(msg.data);//触发事件
    // }
    // 在 0.6.0+ 版本中，必须使用 "fallback" 关键字
    // 并且它没有 "function" 关键字，也没有名字
    fallback() external {
        emit FallbackCalled(msg.data); // 触发事件
    }
    // 如果你还想让这个合约能够接收纯 ETH 转账（比如从钱包直接转账）
    // 你必须额外定义一个 receive() 函数
    receive() external payable {
        // (这里可以什么都不做，或者也触发一个事件)
    }
}
