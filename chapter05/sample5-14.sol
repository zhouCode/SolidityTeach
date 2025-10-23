// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SendFallback {
    event SendEvent(address to, uint value, bool result);
    //使用send()发送ether，观察会触发fallback函数
    function sendEther() public {
      //从合约地址的余额中发送1wei给它自己，所以其balance不会变，只是会消耗msg.sender账户gas
        bool result = payable(address(this)).send(1);
        emit SendEvent(address(this), 1, result);
    }

    //fallback函数及其事件
    event FallbackTrigged(bytes data);
    fallback() external payable {
        // 一定要声明为payable,否则send()执行结果将会始终为false
        emit FallbackTrigged(msg.data);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function deposit() public payable {}
    // (为了完整性) 如果你还想让 .send() 成功，你应该添加 receive()
    receive() external payable {
        // send() 会触发这里
    }
}
