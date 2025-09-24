// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract variable{
    // 标识符命名规则：
    // 1. 标识符名字的第一个字符必须是字母或下划线
    // 2. 标识符名字的第一个字符后面可以由字母，下划线或者数字组成
    // 3. 标识符名字是区分大小写的，也就是Score和score是不同的标识符

    // 常量
    // 数据类型 constant 常量名 = 值;
    int constant x = 10;
    // 状态变量
    // 数据类型 变量名 = 值;
    int y = 20;
    // 命名字符串
    // unicode: 指定字符串使用UTF-8解析(避免中文乱码)--0.7.0版本加入的特性
    string s = unicode"这是一个变量";
    function add() public pure returns(int result){
        // 局部变量
        // 数据类型 变量名 = 值;
        int a = 10;
        int b = 20;
        return a + b;
    }
}