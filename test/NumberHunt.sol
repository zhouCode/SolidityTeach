// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title NumberHuntPro
 * @dev 一个带有陷阱的数字寻宝游戏合约。
 */
contract NumberHuntPro {
    // 预设的宝藏数字
    uint public constant TREASURE_NUMBER = 100;
    // 新增的陷阱数字
    uint public constant TRAP_NUMBER_1 = 42;
    uint public constant TRAP_NUMBER_2 = 84;

    /**
     * @dev 从0开始，以_step为步长累加，看是否能找到宝藏或踩中陷阱。
     * @param _step 每次累加的步长。
     * @return result 返回一个字符串，描述寻宝的结果。
     */
    function findTreasure(uint _step) public pure returns (string memory result) {
        // 确保步长大于0，防止无限循环
        require(_step > 0, "Step must be greater than zero.");

        uint currentNumber = 0;

        // 使用 while 循环来模拟寻宝过程
        while (currentNumber <= TREASURE_NUMBER) {
            
            // 检查是否踩中陷阱
            if (currentNumber == TRAP_NUMBER_1 || currentNumber == TRAP_NUMBER_2) {
                return "Oops! You hit a trap!";
            }

            // 检查是否找到宝藏
            if (currentNumber == TREASURE_NUMBER) {
                return "Success! You found the treasure!";
            }
            
            currentNumber += _step; // 向前走一步
        }

        // 如果循环正常结束（意味着没找到宝藏也没踩到陷阱），返回此信息
        return "Missed! The treasure was not on this path.";
    }
}