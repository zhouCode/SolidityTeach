// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract movieVote {
    mapping(uint => uint) public VoteCount;
    mapping(address => uint) public voteRecord;

    function vote(uint _movieId) public returns (string memory) {
        if (voteRecord[msg.sender] == 0) {  // 未投过票
            voteRecord[msg.sender] = _movieId;
            VoteCount[_movieId] += 1;
            return unicode"投票成功"; 
        }
        return unicode"您已经投过票了";  
    }

    function getVoteCount(uint _movieId) view public returns (uint) {
        return VoteCount[_movieId];
    }

    function getVoteRecord() view public returns (uint) {
        return voteRecord[msg.sender];
    }
}