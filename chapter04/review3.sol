// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title DecentralizedVoting
 * @dev 一个简单的去中心化投票合约.
 */
contract DecentralizedVoting {

    // =========================================================================
    // 知识点回顾：常量, 变量, 结构体, 映射
    // =========================================================================

    // 「常量」: 合约主席，拥有创建提案和授权投票者的权限
    address public immutable chairperson;

    // 「结构体」: 定义一个提案的数据结构
    struct Proposal {
        string name;         // 提案名称，例如 "选举下一任社区代表"
        uint voteCount;      // 该提案获得的票数
    }

    // 「结构体」: 定义一个投票者的数据结构
    struct Voter {
        bool isWhitelisted;  // 是否在白名单中（有投票资格）
        bool hasVoted;       // 是否已经投过票
        uint votedProposalId; // 投给了哪个提案
    }

    // 「映射」: 存储所有投票者的信息
    mapping(address => Voter) public voters;

    // 「动态数组」: 存储所有的提案
    // 「存储位置修-storage」: 这是一个状态变量，数据永久存储在区块链上
    Proposal[] public proposals;

    // `constructor` 在合约部署时执行
    constructor() {
        // chairperson 是 immutable 变量，只能在构造函数中初始化一次
        chairperson = msg.sender;
        // 默认将部署者加入投票者白名单
        voters[msg.sender].isWhitelisted = true;
    }

    // =========================================================================
    // 知识点：函数与业务逻辑 - 条件控制语句
    // =========================================================================

    /**
     * @dev 主席添加一个新的提案选项
     * @param _proposalName 提案的名称
     */
    function addProposal(string memory _proposalName) public {
        // 「条件控制」: 使用 require 进行权限检查，类似一个 if 语句
        require(msg.sender == chairperson, "Only the chairperson can add proposals.");

        // 在 proposals 数组中添加一个新的 Proposal 实例
        proposals.push(Proposal({
            name: _proposalName,
            voteCount: 0
        }));
    }

    /**
     * @dev 主席授权一个地址投票资格
     * @param _voterAddress 要授权的地址
     */
    function authorizeVoter(address _voterAddress) public {
        require(msg.sender == chairperson, "Only the chairperson can authorize voters.");
        
        // 「条件控制」: if 语句
        // 检查该地址是否已经被授权，防止重复操作
        if (voters[_voterAddress].isWhitelisted) {
            revert("Voter is already whitelisted.");
        }
        
        voters[_voterAddress].isWhitelisted = true;
    }

    /**
     * @dev 投票者进行投票
     * @param _proposalId 提案的ID (数组索引)
     */
    function vote(uint _proposalId) public {
        // 从 storage 中获取调用者的信息引用
        Voter storage sender = voters[msg.sender];

        // 「条件控制」: 多个 require 检查投票资格
        require(sender.isWhitelisted, "You are not authorized to vote.");
        require(!sender.hasVoted, "You have already voted.");
        require(_proposalId < proposals.length, "Proposal does not exist.");

        // 更新投票者状态
        sender.hasVoted = true;
        sender.votedProposalId = _proposalId;

        // 对应提案的票数加一
        proposals[_proposalId].voteCount++;
    }

    /**
     * @dev 统计票数并找出获胜的提案
     * @return winningProposalId 获胜提案的ID
     * @return winningVoteCount 获胜提案的票数
     */
    function getWinningProposal() public view returns (uint winningProposalId, uint winningVoteCount) {
        // 「变量」: 声明一个局部变量来存储当前的最高票数
        uint currentMaxVotes = 0;
        uint winnerId = 0;

        // 「条件控制」: for 循环
        // 遍历整个 proposals 数组来查找票数最高的提案
        for (uint p = 0; p < proposals.length; p++) {
            
            // 「条件控制」: if 语句
            // 如果当前遍历到的提案票数高于记录的最高票数
            if (proposals[p].voteCount > currentMaxVotes) {
                // 更新最高票数和获胜者ID
                currentMaxVotes = proposals[p].voteCount;
                winnerId = p;
            }
        }
        
        // 返回最终结果
        return (winnerId, currentMaxVotes);
    }
    
    /**
     * @dev (示例) 演示 while 循环的用法 - 清除前N个提案的票数
     * 注意：在实际公链上要慎用 while 循环，可能会因Gas耗尽导致交易失败。
     * @param _count 要清除票数的提案数量
     */
    function resetFirstNProposalVotes(uint _count) public {
        require(msg.sender == chairperson, "Only chairperson can reset votes.");
        
        // 「条件控制」: if 语句，确保 _count 不会越界
        if (_count > proposals.length) {
            _count = proposals.length;
        }

        uint i = 0;
        // 「条件控制」: while 循环
        while (i < _count) {
            proposals[i].voteCount = 0;
            // 「操作符」: i++ 是 i = i + 1 的简写
            i++; 
        }
    }
}