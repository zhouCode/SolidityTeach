// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GradeBookPro
 * @dev 一个用于处理班级成绩并提供多种统计功能的智能合约。
 */
contract GradeBookPro {
    /**
     * @dev 处理一个成绩数组，返回平均分、最高分、最低分以及及格人数。
     * @param _scores 一个包含多个学生成绩的数组。
     * @return average 返回计算出的平均分。
     * @return highestScore 返回数组中的最高分。
     * @return lowestScore 返回数组中的最低分。
     * @return passingCount 返回及格（>=60）的学生人数。
     */
    function processGrades(uint[] memory _scores) public pure returns (uint average, uint highestScore, uint lowestScore, uint passingCount) {
        // 处理数组为空的边界情况
        if (_scores.length == 0) {
            return (0, 0, 0, 0);
        }

        uint sum = 0;
        // 初始化最高分和最低分为数组的第一个元素
        highestScore = _scores[0];
        lowestScore = _scores[0];
        passingCount = 0;

        // 使用 for 循环遍历整个成绩数组
        for (uint i = 0; i < _scores.length; i++) {
            sum += _scores[i]; // 累加总分

            // 检查并更新最高分
            if (_scores[i] > highestScore) {
                highestScore = _scores[i];
            }

            // 检查并更新最低分
            if (_scores[i] < lowestScore) {
                lowestScore = _scores[i];
            }

            // 如果成绩及格 (>= 60)，则将 passingCount 加 1
            if (_scores[i] >= 60) {
                passingCount++;
            }
        }

        average = sum / _scores.length; // 计算平均分
        return (average, highestScore, lowestScore, passingCount);
    }
}