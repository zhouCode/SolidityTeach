// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ExecuteFallback {
    function callNonExistFunc() public returns(bool){
        bytes memory funcIdentifier = abi.encodeWithSignature("functionNotExist()");
        (bool success, bytes memory returnData) = address(this).call(funcIdentifier);
        return success;

    }
    //Fallback事件，会把调用的数据打印出来
  event FallbackCalled(bytes data);
  //fallback函数，注意是没有名字的，没有参数，没有返回值的
  function() external{
    emit FallbackCalled(msg.data);//触发事件
  }
}
